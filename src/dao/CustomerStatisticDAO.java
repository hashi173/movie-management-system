package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.CustomerStatistic;

public class CustomerStatisticDAO extends DAO {

    public CustomerStatisticDAO() {
        super();
    }

    /**
     * Lấy danh sách thống kê khách hàng theo doanh thu trong khoảng thời gian từ startDate đến endDate
     * @param startDate ngày bắt đầu
     * @param endDate ngày kết thúc
     * @return mảng CustomerStatistic[] sắp xếp giảm dần theo tổng tiền đã chi
     */
    public CustomerStatistic[] getCustomerStatisticsByRevenue(LocalDate startDate, LocalDate endDate) {
        List<CustomerStatistic> list = new ArrayList<>();
        if (startDate == null || endDate == null) {
            return new CustomerStatistic[0];
        }

        String sql = "SELECT m.id, m.username, m.fullname, m.email, m.phone, m.dob, m.address, "
                   + "c.customerCode, "
                   + "SUM(t.finalAmount) AS totalAmount, "
                   + "MAX(t.createDate) AS lastTransactionDate, "
                   + "(SELECT t2.createTime FROM tblTransaction t2 "
                   + " WHERE t2.tblCustomertblMemberid = c.tblMemberid "
                   + "   AND t2.createDate BETWEEN ? AND ? "
                   + " ORDER BY t2.createDate DESC, t2.createTime DESC LIMIT 1) AS lastTransactionTime "
                   + "FROM tblCustomer c "
                   + "INNER JOIN tblMember m ON c.tblMemberid = m.id "
                   + "INNER JOIN tblTransaction t ON t.tblCustomertblMemberid = c.tblMemberid "
                   + "WHERE t.createDate BETWEEN ? AND ? "
                   + "GROUP BY m.id, m.username, m.fullname, m.email, m.phone, m.dob, m.address, c.customerCode "
                   + "ORDER BY totalAmount DESC, lastTransactionDate DESC";
        try {
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setDate(1, Date.valueOf(startDate));
                ps.setDate(2, Date.valueOf(endDate));
                ps.setDate(3, Date.valueOf(startDate));
                ps.setDate(4, Date.valueOf(endDate));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    CustomerStatistic cs = new CustomerStatistic();
                    cs.setId(rs.getInt("id"));
                    cs.setUsername(rs.getString("username"));
                    cs.setFullname(rs.getString("fullname"));
                    cs.setEmail(rs.getString("email"));
                    cs.setPhone(rs.getString("phone"));
                    Date dob = rs.getDate("dob");
                    if (dob != null) {
                        cs.setDob(dob.toLocalDate());
                    }
                    cs.setAddress(rs.getString("address"));
                    cs.setCustomerCode(rs.getString("customerCode"));
                    cs.setTotalAmount(rs.getBigDecimal("totalAmount"));

                    Date lastDate = rs.getDate("lastTransactionDate");
                    if (lastDate != null) {
                        cs.setLastTransactionDate(lastDate.toLocalDate());
                    }
                    Time lastTime = rs.getTime("lastTransactionTime");
                    if (lastTime != null) {
                        cs.setLastTransactionTime(lastTime.toLocalTime());
                    }
                    list.add(cs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new CustomerStatistic[0]);
    }
}
