<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="model.ManagementStaff"%>
<%
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ nhân viên quản lý</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        .staff-menu {
            list-style: none;
            margin: 0;
            padding: 0;
            width: 245px;
            border: 1px solid #8e9ba8;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .staff-menu li {
            border-bottom: 1px solid #8e9ba8;
            background: #ffffff;
            transition: background-color 0.12s ease;
        }
        .staff-menu li:last-child {
            border-bottom: none;
        }
        .staff-menu a {
            display: block;
            padding: 13px 14px;
            color: #111;
            font-weight: bold;
            font-size: 13.5px;
            text-decoration: none;
        }
        .staff-menu li:hover {
            background: #e7f0f8;
        }
    </style>
</head>
<body>
    <div class="window-card" style="max-width: 520px; min-height: 600px;">
        <div class="window-header">Trang chủ nhân viên quản lý</div>
        <div class="window-body" style="display: flex; flex-direction: column; justify-content: space-between; min-height: 540px;">
            <div style="display: flex; align-items: center; gap: 22px;">
                <!-- Menu chức năng nhân viên quản lý đúng theo Hình 2.5 & Hình 2.6 -->
                <ul class="staff-menu">
                    <li class="active">
                        <a id="subViewStatistics" href="<%=request.getContextPath()%>/view/ManagementStaff/SelectStatisticsDateView.jsp">
                            Xem thống kê
                        </a>
                    </li>
                    <li>
                        <a id="subScheduleShowtimes" href="javascript:void(0);">Quản lý lịch chiếu</a>
                    </li>
                    <li>
                        <a id="subManageMovie" href="javascript:void(0);">Quản lý phim</a>
                    </li>
                    <li>
                        <a id="subManageCinema" href="javascript:void(0);">Quản lý thông tin rạp chiếu phim</a>
                    </li>
                    <li>
                        <a id="subManageSeat" href="javascript:void(0);">Quản lý chỗ ngồi</a>
                    </li>
                    <li>
                        <a id="subManageRoom" href="javascript:void(0);">Quản lý phòng</a>
                    </li>
                    <li>
                        <a id="subManageTimeSlot" href="javascript:void(0);">Quản lý khung giờ</a>
                    </li>
                    <li>
                        <a id="subManageCardRank" href="javascript:void(0);">Quản lý hạng thẻ</a>
                    </li>
                    <li>
                        <a id="subManageTicketPricing" href="javascript:void(0);">Quản lý giá vé</a>
                    </li>
                </ul>

                <!-- Lời chào nhân viên quản lý -->
                <div id="txtWelcome" style="flex: 1; text-align: center; font-weight: bold; font-size: 16px; line-height: 1.5;">
                    Chào mừng,<br><%= managementStaff.getFullname() %>
                </div>
            </div>

            <!-- Nút đăng xuất (subLogout) -->
            <div style="margin-top: 32px;">
                <a id="subLogout"
                   href="<%=request.getContextPath()%>/login?action=logout"
                   class="btn-primary"
                   style="width: 200px; padding: 12px 24px;">
                    Đăng xuất
                </a>
            </div>
        </div>
    </div>
</body>
</html>
