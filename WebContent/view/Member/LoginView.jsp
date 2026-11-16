<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String loginError = (String) request.getAttribute("loginError");
    String inUsername = (String) request.getAttribute("inUsername");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
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

    <div class="window-card" style="max-width: 390px; min-height: 450px;">
        <div class="window-header">Đăng nhập hệ thống</div>
        <div class="window-body" style="padding-top: 65px;">
            <form action="<%=request.getContextPath()%>/login" method="post">
                <table style="width: 100%; border-collapse: collapse;">
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
