package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.ManagementStaff;

public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    /**
     * [Bước 3 - 7 trên Sequence Hình 2.10]
     * Kiểm tra thông tin đăng nhập của nhân viên quản lý
     */
    public ManagementStaff checkLogin(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        if (username.contains("true") || username.contains("=")
                || password.contains("true") || password.contains("=")) {
            return null;
        }
        // Truy vấn kết hợp 3 bảng kế thừa: tblMember -> tblStaff -> tblManagementStaff
        String sql = "SELECT m.id, m.username, m.password, m.fullname, m.email, m.phone, m.dob, m.address, "
                   + "s.staffCode, s.position "
                   + "FROM tblMember m "
                   + "INNER JOIN tblStaff s ON m.id = s.tblMemberid "
                   + "INNER JOIN tblManagementStaff ms ON s.tblMemberid = ms.tblStafftblMemberid "
                   + "WHERE m.username = ? AND m.password = ?";
        try {
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, username.trim());
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    // Bước 4 - 6: Khởi tạo và đóng gói thực thể ManagementStaff
                    ManagementStaff staff = new ManagementStaff();
                    staff.setId(rs.getInt("id"));
                    staff.setUsername(rs.getString("username"));
                    staff.setPassword(rs.getString("password"));
                    staff.setFullname(rs.getString("fullname"));
                    staff.setEmail(rs.getString("email"));
                    staff.setPhone(rs.getString("phone"));
                    Date dob = rs.getDate("dob");
                    if (dob != null) {
                        staff.setDob(dob.toLocalDate());
                    }
                    staff.setAddress(rs.getString("address"));
                    staff.setStaffCode(rs.getString("staffCode"));
                    staff.setPosition(rs.getString("position"));
                    // Bước 7: Trả về ManagementStaff cho LoginServlet
                    return staff;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
