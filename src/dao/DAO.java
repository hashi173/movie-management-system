package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        try {
            if (con == null || con.isClosed()) {
                String dbUrl = "jdbc:mysql://localhost:3306/cinema_db?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException ex) {
                    Class.forName("com.mysql.jdbc.Driver");
                }
                con = DriverManager.getConnection(dbUrl, "root", "123456");
            }
        } catch (Exception e) {
            // Thử kết nối với password rỗng hoặc "root" nếu máy local cấu hình mặc định
            try {
                String dbUrl = "jdbc:mysql://localhost:3306/cinema_db?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                con = DriverManager.getConnection(dbUrl, "root", "");
            } catch (Exception e2) {
                try {
                    String dbUrl = "jdbc:mysql://localhost:3306/cinema_db?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                    con = DriverManager.getConnection(dbUrl, "root", "root");
                } catch (Exception e3) {
                    e.printStackTrace();
                }
            }
        }
    }
}
