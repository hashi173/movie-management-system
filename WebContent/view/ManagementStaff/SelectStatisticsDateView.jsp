<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="model.ManagementStaff"%>
<%
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }

    String errorMsg = (String) request.getAttribute("errorMsg");
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <!-- Ngoại lệ 8.1 & 8.2: Hiện thông báo và nút OK, khi click OK quay trở về giao diện chọn ngày -->
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

    <div class="window-card" style="max-width: 470px; min-height: 480px;">
        <div class="window-header">Chọn ngày xem thống kê</div>
        <div class="window-body" style="padding-top: 75px;">
            <form action="<%=request.getContextPath()%>/customer-statistics" method="get">
                <input type="hidden" name="action" value="viewRevenue" />
                <table style="width: 100%; border-collapse: collapse;">
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

                <div style="display: flex; justify-content: center; gap: 18px; margin-top: 42px;">
                    <button type="submit" id="subViewStatistics" name="subViewStatistics" tabindex="3" class="btn-primary" style="width: 180px; padding: 14px 16px;">
                        Xem thống kê
                    </button>
                    <a id="subBack"
                       tabindex="4"
                       href="<%=request.getContextPath()%>/view/ManagementStaff/ManagementStaffHomeView.jsp"
                       class="btn-primary"
                       style="width: 170px; padding: 14px 16px;">
                        Trở về
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
