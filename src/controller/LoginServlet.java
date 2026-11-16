package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.MemberDAO;
import model.ManagementStaff;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDAO memberDAO;

    public LoginServlet() {
        super();
    }

    @Override
    public void init() {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/Member/LoginView.jsp");
        dispatcher.forward(request, response);
    }

    // Bước 2 - 8 (Sequence Hình 2.10): Xử lý đăng nhập của nhân viên quản lý
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String inUsername = request.getParameter("inUsername");
        String inPassword = request.getParameter("inPassword");

        // Bước 3 - 7: Gọi MemberDAO.checkLogin() để kiểm tra thông tin đăng nhập
        ManagementStaff managementStaff = memberDAO.checkLogin(inUsername, inPassword);
        if (managementStaff != null) {
            // Đăng nhập thành công: Lưu thực thể ẩn managementStaff vào session
            HttpSession session = request.getSession();
            session.setAttribute("managementStaff", managementStaff);
            // Bước 8: Chuyển tiếp (forward) sang trang ManagementStaffHomeView.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/ManagementStaffHomeView.jsp");
            dispatcher.forward(request, response);
        } else {
            // Ngoại lệ 4.1: Sai tên đăng nhập hoặc mật khẩu -> Báo lỗi trên LoginView.jsp
            request.setAttribute("loginError", "Sai tên đăng nhập hoặc mật khẩu!");
            request.setAttribute("inUsername", inUsername);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/Member/LoginView.jsp");
            dispatcher.forward(request, response);
        }
    }
}
