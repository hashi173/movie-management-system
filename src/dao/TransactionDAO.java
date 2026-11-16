package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Saler;
import model.Showtime;
import model.Ticket;
import model.Transaction;

public class TransactionDAO extends DAO {

    public TransactionDAO() {
        super();
    }

    /**
     * Lấy danh sách các giao dịch của khách hàng trong khoảng thời gian từ startDate đến endDate
     * Thứ tự đóng gói thực thể khớp 100% với Sequence Diagram (Hình 2.10):
     * Customer -> Saler -> Showtime -> Ticket -> Transaction
     */
    public Transaction[] getTransactionsByCustomer(String customerId, LocalDate startDate, LocalDate endDate) {
        List<Transaction> list = new ArrayList<>();
        if (customerId == null || startDate == null || endDate == null) {
            return new Transaction[0];
        }

        String sqlTrans = "SELECT t.transactionCode, t.createDate, t.createTime, t.paymentMethod, "
                        + "t.totalAmount, t.discountAmount, t.finalAmount, "
                        + "cm.id AS customerMemberId, cm.fullname AS customerName, cm.email AS customerEmail, cm.phone AS customerPhone, "
                        + "c.customerCode, "
                        + "sm.id AS salerMemberId, sm.fullname AS salerName, st.staffCode AS salerCode, st.position AS salerPosition "
                        + "FROM tblTransaction t "
                        + "INNER JOIN tblCustomer c ON t.tblCustomertblMemberid = c.tblMemberid "
                        + "INNER JOIN tblMember cm ON c.tblMemberid = cm.id "
                        + "LEFT JOIN tblSaler sl ON t.tblSalertblStafftblMemberid = sl.tblStafftblMemberid "
                        + "LEFT JOIN tblStaff st ON sl.tblStafftblMemberid = st.tblMemberid "
                        + "LEFT JOIN tblMember sm ON st.tblMemberid = sm.id "
                        + "WHERE (c.customerCode = ? OR CAST(c.tblMemberid AS CHAR) = ?) "
                        + "  AND t.createDate BETWEEN ? AND ? "
                        + "ORDER BY t.createDate ASC, t.createTime ASC, t.transactionCode ASC";

        String sqlTicket = "SELECT tk.ticketCode, tk.ticketStatus, tk.tblShowtimeshowtimeCode "
                         + "FROM tblTicket tk WHERE tk.tblTransactiontransactionCode = ?";

        try {
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(sqlTrans);
                ps.setString(1, customerId.trim());
                ps.setString(2, customerId.trim());
                ps.setDate(3, Date.valueOf(startDate));
                ps.setDate(4, Date.valueOf(endDate));
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    String transCode = rs.getString("transactionCode");

                    // 1. Đóng gói Customer (Bước 27 - 29 trên Sequence Diagram)
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("customerMemberId"));
                    customer.setCustomerCode(rs.getString("customerCode"));
                    customer.setFullname(rs.getString("customerName"));
                    customer.setEmail(rs.getString("customerEmail"));
                    customer.setPhone(rs.getString("customerPhone"));

                    // 2. Đóng gói Saler (Bước 30 - 32 trên Sequence Diagram)
                    Saler saler = null;
                    if (rs.getObject("salerMemberId") != null) {
                        saler = new Saler();
                        saler.setId(rs.getInt("salerMemberId"));
                        saler.setFullname(rs.getString("salerName"));
                        saler.setStaffCode(rs.getString("salerCode"));
                        saler.setPosition(rs.getString("salerPosition"));
                    }

                    // 3 & 4. Đóng gói Showtime và Ticket (Bước 33 - 38 trên Sequence Diagram)
                    List<Ticket> tickets = new ArrayList<>();
                    PreparedStatement psTicket = con.prepareStatement(sqlTicket);
                    psTicket.setString(1, transCode);
                    ResultSet rsTicket = psTicket.executeQuery();
                    while (rsTicket.next()) {
                        Showtime showtime = new Showtime();
                        showtime.setShowtimeCode(rsTicket.getString("tblShowtimeshowtimeCode"));

                        Ticket ticket = new Ticket();
                        ticket.setTicketCode(rsTicket.getString("ticketCode"));
                        ticket.setTicketStatus(rsTicket.getString("ticketStatus"));
                        ticket.setShowtime(showtime);

                        tickets.add(ticket);
                    }

                    // 5. Đóng gói Transaction (Bước 39 - 41 trên Sequence Diagram)
                    Transaction trans = new Transaction();
                    trans.setTransactionCode(transCode);
                    Date createDate = rs.getDate("createDate");
                    if (createDate != null) {
                        trans.setCreateDate(createDate.toLocalDate());
                    }
                    Time createTime = rs.getTime("createTime");
                    if (createTime != null) {
                        trans.setCreateTime(createTime.toLocalTime());
                    }
                    trans.setPaymentMethod(rs.getString("paymentMethod"));
                    trans.setTotalAmount(rs.getBigDecimal("totalAmount"));
                    trans.setDiscountAmount(rs.getBigDecimal("discountAmount"));
                    trans.setFinalAmount(rs.getBigDecimal("finalAmount"));
                    trans.setCustomer(customer);
                    trans.setSaler(saler);
                    trans.setTickets(tickets.toArray(new Ticket[0]));

                    list.add(trans);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Transaction[0]);
    }
}
