<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="model.ManagementStaff"%>
<%
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }
    String msg = (String) request.getAttribute("msg");
    String err = (String) request.getAttribute("err");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <div class="window-card" style="max-width: 420px; min-height: 400px;">
        <div class="window-header">Đổi mật khẩu cá nhân</div>
        <div class="window-body" style="padding-top: 35px;">
            <% if (msg != null) { %>
                <div style="padding: 10px; background: #dff0d8; border: 1px solid #b2dba1; color: #3c763d; margin-bottom: 16px; text-align: center;">
                    <%= msg %>
                </div>
            <% } %>
            <% if (err != null) { %>
                <div style="padding: 10px; background: #f2dede; border: 1px solid #dca7a7; color: #a94442; margin-bottom: 16px; text-align: center;">
                    <%= err %>
                </div>
            <% } %>

            <form action="<%=request.getContextPath()%>/login" method="post">
                <input type="hidden" name="action" value="changePassword" />
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="padding: 10px 6px; width: 130px; font-size: 14px;">Mật khẩu cũ:</td>
                        <td style="padding: 10px 6px;">
                            <input type="password" name="inOldPassword" class="form-input" style="width: 100%;" required />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 10px 6px; font-size: 14px;">Mật khẩu mới:</td>
                        <td style="padding: 10px 6px;">
                            <input type="password" name="inNewPassword" class="form-input" style="width: 100%;" required />
                        </td>
                    </tr>
                </table>

                <div style="text-align: center; margin-top: 24px; display: flex; gap: 12px; justify-content: center;">
                    <button type="submit" class="btn-primary">Lưu mật khẩu</button>
                    <a href="<%=request.getContextPath()%>/view/ManagementStaff/ManagementStaffHomeView.jsp" class="btn-primary">Trở về</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
