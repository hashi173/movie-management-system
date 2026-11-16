<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng</title>
    <!-- Nhúng stylesheet định dạng giao diện chuẩn -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <!-- ========================================================================= -->
    <!-- [GIAO DIỆN KHỞI ĐẦU: TRANG CHỦ KHÁCH HÀNG - Boundary: CustomerHomeView]   -->
    <!-- Khớp với Sơ đồ ca sử dụng Tổng quan và Bước 1 trên Sequence Diagram       -->
    <!-- ========================================================================= -->
    <div class="window-card" style="max-width: 380px; min-height: 440px;">
        <!-- Tiêu đề cửa sổ -->
        <div class="window-header">Trang chủ khách hàng</div>
        
        <div class="window-body" style="text-align: center; padding-top: 50px;">
            <!-- [Thuộc tính -txtWelcome : text]: Tiêu đề lời chào mừng khách hàng -->
            <h2 id="txtWelcome" style="font-size: 20px; line-height: 1.4; margin-bottom: 45px;">
                Chào mừng đến với<br>hệ thống quản lý rạp<br>chiếu phim
            </h2>

            <!-- [Thuộc tính -subSearchMovie : link]: Nút dẫn sang MODULE 1 - Tìm kiếm phim -->
            <div style="margin-bottom: 24px;">
                <a id="subSearchMovie"
                   href="<%=request.getContextPath()%>/view/Customer/SearchMovieView.jsp"
                   class="btn-primary"
                   style="width: 240px; padding: 14px 20px;">
                    Tìm kiếm phim
                </a>
            </div>

            <!-- [Thuộc tính -subLogin : link]: Nút dẫn sang trang Đăng nhập hệ thống -->
            <div>
                <a id="subLogin"
                   href="<%=request.getContextPath()%>/login"
                   class="btn-primary"
                   style="width: 240px; padding: 14px 20px;">
                    Đăng nhập
                </a>
            </div>
        </div>
    </div>
</body>
</html>
