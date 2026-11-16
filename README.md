# Hệ Thống Quản Lý Rạp Chiếu Phim (Cinema Management System - J2EE MVC)

Dự án triển khai đầy đủ theo đúng thiết kế trong **17B23DCCN266.docx**, kết hợp chuẩn tổ chức dự án J2EE của sách **Bài giảng Phân tích thiết kế & Đảm bảo chất lượng phần mềm (BG)** và **LAB 1 (JSP + Servlet + JDBC + MySQL + DAO)**.

---

## 1. Cấu trúc thư mục dự án (Eclipse Dynamic Web Project)

```text
Movie management system/
├── sql/
│   └── cinema_db.sql                                     # Script tạo CSDL 19 bảng + dữ liệu Seed (100 phim, 203 giao dịch)
├── src/
│   ├── model/                                            # 21 lớp thực thể (Hình 2.1, 2.4, 2.6)
│   │   ├── Member.java, Customer.java, Staff.java, ManagementStaff.java, Saler.java
│   │   ├── CustomerStatistic.java, MovieStatistic.java
│   │   ├── Cinema.java, Room.java, Seat.java
│   │   ├── Movie.java, Genre.java, MovieGenre.java
│   │   ├── ShowDate.java, TimeSlot.java, Showtime.java
│   │   ├── TicketPricing.java, Ticket.java, Transaction.java
│   │   └── CardRank.java, MembershipCard.java
│   ├── dao/                                              # Tầng truy xuất dữ liệu (Hình 2.4, 2.6)
│   │   ├── DAO.java
│   │   ├── MovieDAO.java
│   │   ├── MemberDAO.java
│   │   ├── CustomerStatisticDAO.java
│   │   └── TransactionDAO.java
│   ├── controller/                                       # Tầng điều khiển Servlet (Deployment Diagram & LAB1)
│   │   ├── LoginServlet.java
│   │   ├── SearchMovieServlet.java
│   │   └── CustomerStatisticsServlet.java
│   └── unittest/                                         # Kiểm thử đơn vị JUnit (Mục 5.3 BG)
│       └── TestCinemaDAO.java
└── WebContent/
    ├── css/
    │   └── style.css
    ├── view/                                             # Tầng giao diện JSP chia theo gói (Mục 2.3.3)
    │   ├── Member/
    │   │   ├── LoginView.jsp
    │   │   └── ChangePasswordView.jsp
    │   ├── Customer/
    │   │   ├── CustomerHomeView.jsp
    │   │   └── SearchMovieView.jsp
    │   └── ManagementStaff/
    │       ├── ManagementStaffHomeView.jsp
    │       ├── SelectStatisticsDateView.jsp
    │       ├── CustomerStatisticsByRevenueView.jsp
    │       └── CustomerTransactionStatisticsView.jsp
    ├── WEB-INF/
    │   ├── lib/                                          # Thư viện mysql-connector-j, servlet-api, jsp-api
    │   └── web.xml
    └── index.jsp
```

---

## 2. Hướng dẫn cài đặt và chạy chương trình

1. **Khởi tạo CSDL MySQL (`cinema_db`)**:
   - Mở MySQL Workbench hoặc MySQL CLI và chạy file `sql/cinema_db.sql`.
   - Kiểm tra thông tin tài khoản MySQL (`username`, `password`, cổng `3306`) trong `src/dao/DAO.java`.

2. **Chạy trên Eclipse & Apache Tomcat**:
   - Mở Eclipse -> `File` -> `Import` -> `Existing Projects into Workspace` -> chọn thư mục dự án.
   - Đảm bảo đường dẫn cài đặt Apache Tomcat 9 nằm ở thư mục không dấu (ví dụ: `C:\Users\Admin\apache-tomcat-9.0.100`).
   - Chuột phải vào dự án -> `Run As` -> `Run on Server` (Apache Tomcat v9.0).
   - Truy cập địa chỉ: `http://localhost:8080/CinemaManagementSystem/`

---

## 3. Thông tin chi tiết bộ dữ liệu Seed (`sql/cinema_db.sql`)

Cơ sở dữ liệu `cinema_db` đã được nạp sẵn bộ dữ liệu lớn phục vụ kiểm thử toàn diện:

### 3.1. Tài khoản đăng nhập hệ thống
* **Nhân viên quản lý (Management Staff)**:
  - **Username:** `staffa`
  - **Password:** `123456`
  - **Họ tên:** `Management Staff A` (Mã NV: `QL01`)
* **Nhân viên bán vé (Saler - 8 nhân viên)**:
  - `saler1` (`NV98` - Nguyễn A), `saler2` (`NV6` - Phạm C), `saler3` (`NV10` - Trần Thị Mai), `saler4` (`NV11` - Lê Hoàng Nam), `saler5` (`NV12` - Vũ Minh Tuấn), `saler6` (`NV13` - Đặng Thu Hà), `saler7` (`NV14` - Bùi Quốc Khánh), `saler8` (`NV15` - Hoàng Lan Anh) — mật khẩu chung: `123456`.
* **Khách hàng (Customer - 40 khách hàng)**:
  - `KH98` (Phạm A - `phama`), `KH2` (Nguyễn B - `nguyenb`), cùng 38 khách hàng từ `KH3` đến `KH40` (`khachhang3` .. `khachhang40`) — mật khẩu chung: `123456`.

### 3.2. Dữ liệu Phim & Lịch chiếu (100 bộ phim)
* **Số lượng:** **100 bộ phim** (`MV01` .. `MV100`), gắn với **10 thể loại** (`GR01` .. `GR10`: Hành động, Thần thoại, Hoạt hình, Khoa học viễn tưởng, Kinh dị, Tình cảm, Hài hước, Phiêu lưu, Tâm lý, Hình sự).
* **Trạng thái phát hành đa dạng:** `Đang chiếu`, `Sắp chiếu`, `Hết chiếu`, `Ngừng chiếu`.
* **Thời gian khởi chiếu:** Trải dài từ `01/2025` đến `12/2026`.
* **63 suất chiếu (`tblShowtime`)** trên **4 phòng chiếu (`RM01` - IMAX, `RM02` - 4DX, `RM03` - 2D, `RM04` - 3D)** với **80 ghế ngồi (`S001` .. `S080`)** và **120 ngày chiếu (`tblShowDate`)**.
* **Các từ khóa gợi ý để test Tìm kiếm phim:**
  - `The Odyssey` *(Kịch bản chuẩn trong báo cáo: trả về đúng 2 phim `MV78 - The Odyssey` và `MV11 - The Odyssey Animation`)*.
  - `The` *(Trả về 12 bộ phim có chữ "The")*.
  - `Lật Mặt` *(Trả về 3 phần Lật Mặt 6, 7, 8 của Lý Hải)*.
  - `Avengers`, `Spider-Man`, `Dune`, `Avatar`, `John Wick`, `Wicked`, `Quỷ`...
  - Để trống ô tìm kiếm rồi bấm **Tìm kiếm**: Hiển thị toàn bộ **100 bộ phim**.
  - Nhập từ khóa không tồn tại (VD: `XYZ999`): Kiểm thử ngoại lệ *"Không có bộ phim nào trùng với từ khóa. Vui lòng nhập lại tên phim."*

### 3.3. Dữ liệu Giao dịch & Vé (203 giao dịch & 719 vé)
* **Số lượng:** **203 giao dịch (`GD1` .. `GD203`)** và **719 vé (`TK01` .. `TK0718`)**.
* **Khoảng thời gian trải dài:** Từ **`02/01/2025` đến `28/12/2026`** (cứ mỗi 3–4 ngày đều có giao dịch phát sinh liên tục qua tất cả các tháng của năm 2025 và 2026).
* **Các mốc thời gian gợi ý để test Xem thống kê khách hàng theo doanh thu:**
  1. **Tháng 07/2026 (`01/07/2026` đến `30/07/2026`)**:
     - Giữ nguyên số liệu của `KH98 - Phạm A` (**1.000.000 VND** gồm 2 giao dịch `GD1` và `GD2`) và `KH2 - Nguyễn B` (**400.000 VND** gồm `GD3`) đúng kịch bản trong báo cáo, kèm các khách hàng giao dịch trong tháng 7/2026.
  2. **Cả năm 2025 (`01/01/2025` đến `31/12/2025`)**:
     - Thống kê ~100 giao dịch của gần 40 khách hàng trong năm 2025, mỗi khách hàng có nhiều giao dịch khi click vào xem chi tiết.
  3. **Cả năm 2026 (`01/01/2026` đến `31/12/2026`)** hoặc **Toàn bộ 2 năm (`01/01/2025` đến `31/12/2026`)**:
     - Thống kê toàn bộ 40 khách hàng và 203 giao dịch xếp hạng từ cao xuống thấp theo tổng doanh thu.
  4. **Kiểm thử ngoại lệ ngày thống kê**:
     - Chọn ngày kết thúc sớm hơn ngày bắt đầu (VD: `30/07/2026` đến `01/07/2026`) -> Hiện popup *"Ngày kết thúc không hợp lệ do sớm hơn ngày bắt đầu."*
     - Chọn khoảng ngày không có giao dịch (VD: `01/01/2024` đến `31/01/2024`) -> Hiện popup *"Không có giao dịch nào trong khoảng thời gian đã chọn."*
