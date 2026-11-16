<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="model.ManagementStaff"%>
<%
    // =========================================================================
    // [PHẦN 1: BẢO MẬT PHIÊN LÀM VIỆC & HỨNG DỮ LIỆU ĐIỀU HƯỚNG]
    // =========================================================================
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }

    // Hứng thông báo ngoại lệ từ Servlet (Ngoại lệ 8.1 & 8.2)
    String errorMsg = (String) request.getAttribute("errorMsg");
    
    // Giữ lại giá trị ngày đã nhập hoặc nạp giá trị mẫu để người dùng tiện thao tác
    String inStartDate = (String) request.getAttribute("inStartDate");
    String inEndDate = (String) request.getAttribute("inEndDate");
    if (inStartDate == null) {
        inStartDate = (session.getAttribute("inStartDate") != null)
                ? (String) session.getAttribute("inStartDate")
                : "2026-07-01";
    }
    if (inEndDate == null) {
        inEndDate = (session.getAttribute("inEndDate") != null)
                ? (String) session.getAttribute("inEndDate")
                : "2026-07-30";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn ngày xem thống kê</title>
    <!-- Nhúng CSS thiết kế chung -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <!-- ========================================================================= -->
    <!-- [PHẦN 2: HỘP THOẠI MODAL BÁO LỖI (NGOẠI LỆ 8.1 & 8.2 TRONG BÁO CÁO)]       -->
    <!-- Khi errorMsg != null (ngày không hợp lệ hoặc không có giao dịch), hiện modal-->
    <!-- ========================================================================= -->
    <% if (errorMsg != null) { %>
    <div id="dateErrorModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">Thông báo</div>
            <div class="modal-content"><%= errorMsg %></div>
            <div class="modal-footer">
                <button type="button" class="btn-primary" onclick="document.getElementById('dateErrorModal').style.display='none';">
                    OK
                </button>
            </div>
        </div>
    </div>
    <% } %>

    <!-- ========================================================================= -->
    <!-- [PHẦN 3: FORM CHỌN KHOẢNG THỜI GIAN THỐNG KÊ - SelectStatisticsDateView]  -->
    <!-- Khớp với các thuộc tính: inStartDate, inEndDate, subView, subBack         -->
    <!-- ========================================================================= -->
    <div class="window-card" style="max-width: 470px; min-height: 480px;">
        <div class="window-header">Chọn ngày xem thống kê</div>
        <div class="window-body" style="padding-top: 75px;">
            <form action="<%=request.getContextPath()%>/customer-statistics" method="get">
                <!-- BIẾN ẨN TRÊN FORM: Báo cho Servlet biết là hành động xem doanh thu -->
                <input type="hidden" name="action" value="viewRevenue" />
                
                <table style="width: 100%; border-collapse: collapse;">
                    <!-- [Thuộc tính -inStartDate : date]: Ô chọn ngày bắt đầu (tabindex=1) -->
                    <tr>
                        <td style="padding: 18px 8px; width: 120px; font-size: 14.5px;">Ngày bắt đầu:</td>
                        <td style="padding: 18px 8px;">
                            <input type="date"
                                   id="inStartDate"
                                   name="inStartDate"
                                   tabindex="1"
                                   class="form-input"
                                   style="width: 100%; padding: 10px 12px;"
                                   value="<%= inStartDate %>"
                                   required />
                        </td>
                    </tr>
                    
                    <!-- [Thuộc tính -inEndDate : date]: Ô chọn ngày kết thúc (tabindex=2) -->
                    <tr>
                        <td style="padding: 18px 8px; font-size: 14.5px;">Ngày kết thúc:</td>
                        <td style="padding: 18px 8px;">
                            <input type="date"
                                   id="inEndDate"
                                   name="inEndDate"
                                   tabindex="2"
                                   class="form-input"
                                   style="width: 100%; padding: 10px 12px;"
                                   value="<%= inEndDate %>"
                                   required />
                        </td>
                    </tr>
                </table>

                <!-- ===================================================================== -->
                <!-- [PHẦN 3.1: CÁC NÚT HÀNH ĐỘNG - subView & subBack]                    -->
                <!-- ===================================================================== -->
                <div style="text-align: center; margin-top: 55px; display: flex; gap: 18px; justify-content: center;">
                    <!-- [Thuộc tính -subView : submit]: Nút gửi form để xem thống kê (tabindex=3) -->
                    <button type="submit" id="subView" name="subView" tabindex="3" class="btn-primary" style="padding: 12px 36px;">
                        Xem thống kê
                    </button>
                    
                    <!-- [Thuộc tính -subBack : link]: Nút quay về Trang chủ quản lý (tabindex=4) -->
                    <a id="subBack"
                       tabindex="4"
                       href="<%=request.getContextPath()%>/view/ManagementStaff/ManagementStaffHomeView.jsp"
                       class="btn-primary"
                       style="padding: 12px 36px;">
                        Trở về
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
