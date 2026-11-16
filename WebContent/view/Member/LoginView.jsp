<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    // =========================================================================
    // [PHẦN 1: CẤU HÌNH & HỨNG THÔNG BÁO LỖI TỪ LOGINSERVLET]
    // =========================================================================
    request.setCharacterEncoding("UTF-8");
    
    // Hứng thông báo lỗi khi đăng nhập thất bại (Ngoại lệ 4.1)
    String loginError = (String) request.getAttribute("loginError");
    
    // Giữ lại tên tài khoản vừa nhập để người dùng không phải gõ lại
    String inUsername = (String) request.getAttribute("inUsername");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <!-- Nhúng file CSS thiết kế chuẩn -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <!-- ========================================================================= -->
    <!-- [PHẦN 2: HỘP THOẠI MODAL THÔNG BÁO NGOẠI LỆ 4.1 - SAI TÀI KHOẢN/MẬT KHẨU]  -->
    <!-- Hiển thị khi loginError != null, có nút OK đóng popup                     -->
    <!-- ========================================================================= -->
    <% if (loginError != null) { %>
    <div id="errorModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">Thông báo</div>
            <div class="modal-content"><%= loginError %></div>
            <div class="modal-footer">
                <button type="button" class="btn-primary" onclick="document.getElementById('errorModal').style.display='none';">
                    OK
                </button>
            </div>
        </div>
    </div>
    <% } %>

    <!-- ========================================================================= -->
    <!-- [PHẦN 3: FORM ĐĂNG NHẬP HỆ THỐNG - Boundary: LoginView]                   -->
    <!-- Khớp với các thuộc tính: inUsername, inPassword, subLogin                 -->
    <!-- ========================================================================= -->
    <div class="window-card" style="max-width: 390px; min-height: 450px;">
        <div class="window-header">Đăng nhập hệ thống</div>
        <div class="window-body" style="padding-top: 65px;">
            <form action="<%=request.getContextPath()%>/login" method="post">
                <table style="width: 100%; border-collapse: collapse;">
                    <!-- [Thuộc tính -inUsername : text]: Ô nhập tên đăng nhập (tabindex=1) -->
                    <tr>
                        <td style="padding: 12px 6px; width: 115px; font-size: 14px;">Tên đăng nhập:</td>
                        <td style="padding: 12px 6px;">
                            <input type="text"
                                   id="inUsername"
                                   name="inUsername"
                                   tabindex="1"
                                   class="form-input"
                                   style="width: 100%;"
                                   placeholder="staffa"
                                   value="<%= (inUsername != null) ? inUsername : "" %>"
                                   required />
                        </td>
                    </tr>
                    
                    <!-- [Thuộc tính -inPassword : password]: Ô nhập mật khẩu (tabindex=2) -->
                    <tr>
                        <td style="padding: 12px 6px; font-size: 14px;">Mật khẩu:</td>
                        <td style="padding: 12px 6px;">
                            <input type="password"
                                   id="inPassword"
                                   name="inPassword"
                                   tabindex="2"
                                   class="form-input"
                                   style="width: 100%;"
                                   placeholder="******"
                                   required />
                        </td>
                    </tr>
                </table>

                <!-- [Thuộc tính -subLogin : submit]: Nút gửi form đăng nhập (tabindex=3) -->
                <div style="text-align: center; margin-top: 28px;">
                    <button type="submit" id="subLogin" name="subLogin" tabindex="3" class="btn-primary" style="width: 190px; padding: 12px 24px;">
                        Đăng nhập
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
