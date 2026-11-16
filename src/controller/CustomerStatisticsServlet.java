package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.CustomerStatisticDAO;
import dao.TransactionDAO;
import model.CustomerStatistic;
import model.ManagementStaff;
import model.Transaction;

@WebServlet("/customer-statistics")
public class CustomerStatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerStatisticDAO customerStatisticDAO;
    private TransactionDAO transactionDAO;

    public CustomerStatisticsServlet() {
        super();
    }

    @Override
    public void init() {
        customerStatisticDAO = new CustomerStatisticDAO();
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Bước 15 & 25 (Sequence Hình 2.10): Xử lý thống kê khách hàng theo doanh thu và xem chi tiết giao dịch
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        ManagementStaff managementStaff = (session != null)
                ? (ManagementStaff) session.getAttribute("managementStaff")
                : null;
        if (managementStaff == null) {
            response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
            return;
        }

        String action = request.getParameter("action");

        // === NHÁNH 2 (Bước 25 - 43 trên Sequence Hình 2.10): Xem chi tiết giao dịch của 1 khách hàng ===
        if ("viewTransactions".equalsIgnoreCase(action)) {
            String customerCode = request.getParameter("customerCode");
            String rawStartDate = request.getParameter("startDate");
            String rawEndDate = request.getParameter("endDate");

            LocalDate startDate = null;
            LocalDate endDate = null;
            try {
                if (rawStartDate != null && !rawStartDate.trim().isEmpty()) {
                    startDate = LocalDate.parse(rawStartDate.trim());
                }
            } catch (Exception e) {
                startDate = null;
            }
            try {
                if (rawEndDate != null && !rawEndDate.trim().isEmpty()) {
                    endDate = LocalDate.parse(rawEndDate.trim());
                }
            } catch (Exception e) {
                endDate = null;
            }

            if (startDate == null && session.getAttribute("startDateObj") != null) {
                startDate = (LocalDate) session.getAttribute("startDateObj");
            }
            if (endDate == null && session.getAttribute("endDateObj") != null) {
                endDate = (LocalDate) session.getAttribute("endDateObj");
            }

            // Bước 26 - 42: Gọi TransactionDAO.getTransactionsByCustomer()
            Transaction[] transaction = transactionDAO.getTransactionsByCustomer(customerCode, startDate, endDate);
            request.setAttribute("transaction", transaction);

            // Bước 43: Chuyển tiếp (forward) sang trang CustomerTransactionStatisticsView.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/CustomerTransactionStatisticsView.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // === NHÁNH 1 (Bước 15 - 21 trên Sequence Hình 2.10): Xem thống kê khách hàng theo doanh thu ===
        String rawStartDate = request.getParameter("inStartDate");
        String rawEndDate = request.getParameter("inEndDate");

        if ((rawStartDate == null || rawStartDate.trim().isEmpty()) && session.getAttribute("inStartDate") != null) {
            rawStartDate = (String) session.getAttribute("inStartDate");
        }
        if ((rawEndDate == null || rawEndDate.trim().isEmpty()) && session.getAttribute("inEndDate") != null) {
            rawEndDate = (String) session.getAttribute("inEndDate");
        }

        LocalDate startDate = null;
        LocalDate endDate = null;
        try {
            if (rawStartDate != null && !rawStartDate.trim().isEmpty()) {
                startDate = LocalDate.parse(rawStartDate.trim());
            }
        } catch (Exception e) {
            startDate = null;
        }
        try {
            if (rawEndDate != null && !rawEndDate.trim().isEmpty()) {
                endDate = LocalDate.parse(rawEndDate.trim());
            }
        } catch (Exception e) {
            endDate = null;
        }

        if (startDate == null || endDate == null) {
            request.setAttribute("errorMsg", "Vui lòng chọn ngày bắt đầu và ngày kết thúc hợp lệ.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/SelectStatisticsDateView.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Ngoại lệ 8.2: Ngày kết thúc sớm hơn ngày bắt đầu
        if (endDate.isBefore(startDate)) {
            request.setAttribute("inStartDate", rawStartDate);
            request.setAttribute("inEndDate", rawEndDate);
            request.setAttribute("errorMsg", "Ngày kết thúc không hợp lệ do sớm hơn ngày bắt đầu.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/SelectStatisticsDateView.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Bước 16 - 20: Gọi CustomerStatisticDAO.getCustomerStatisticsByRevenue(startDate, endDate)
        CustomerStatistic[] customerStatistic = customerStatisticDAO.getCustomerStatisticsByRevenue(startDate, endDate);

        // Ngoại lệ 8.1: Không có giao dịch nào trong khoảng thời gian đã chọn
        if (customerStatistic == null || customerStatistic.length == 0) {
            request.setAttribute("inStartDate", rawStartDate);
            request.setAttribute("inEndDate", rawEndDate);
            request.setAttribute("errorMsg", "Không có giao dịch nào trong khoảng thời gian đã chọn.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/SelectStatisticsDateView.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Tính tổng doanh thu của tất cả khách hàng trong khoảng thời gian
        BigDecimal outTotalRevenue = BigDecimal.ZERO;
        for (CustomerStatistic cs : customerStatistic) {
            if (cs.getTotalAmount() != null) {
                outTotalRevenue = outTotalRevenue.add(cs.getTotalAmount());
            }
        }

        session.setAttribute("startDateObj", startDate);
        session.setAttribute("endDateObj", endDate);
        session.setAttribute("inStartDate", startDate.toString());
        session.setAttribute("inEndDate", endDate.toString());
        session.setAttribute("customerStatistic", customerStatistic);
        session.setAttribute("outTotalRevenue", outTotalRevenue);

        request.setAttribute("outStartDate", startDate);
        request.setAttribute("outEndDate", endDate);
        request.setAttribute("customerStatistic", customerStatistic);
        request.setAttribute("outTotalRevenue", outTotalRevenue);

        // Bước 21: Chuyển tiếp (forward) sang trang CustomerStatisticsByRevenueView.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/CustomerStatisticsByRevenueView.jsp");
        dispatcher.forward(request, response);
    }
}
