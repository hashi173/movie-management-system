<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.math.BigDecimal,java.text.DecimalFormat,java.text.DecimalFormatSymbols,java.time.LocalDate,java.time.format.DateTimeFormatter,java.util.Locale,model.CustomerStatistic,model.ManagementStaff"%>
<%
    // Thực thể ẩn trên Class Diagram Hình 2.6: managementStaff (từ session)
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }

    LocalDate outStartDate = (LocalDate) request.getAttribute("outStartDate");
    LocalDate outEndDate = (LocalDate) request.getAttribute("outEndDate");
    // Thực thể ẩn trên Class Diagram Hình 2.6: customerStatistic (kết quả từ CustomerStatisticDAO)
    CustomerStatistic[] customerStatistic = (CustomerStatistic[]) request.getAttribute("customerStatistic");
    BigDecimal outTotalRevenue = (BigDecimal) request.getAttribute("outTotalRevenue");

    if (outStartDate == null && session.getAttribute("startDateObj") != null) {
        outStartDate = (LocalDate) session.getAttribute("startDateObj");
    }
    if (outEndDate == null && session.getAttribute("endDateObj") != null) {
        outEndDate = (LocalDate) session.getAttribute("endDateObj");
    }
    if (customerStatistic == null && session.getAttribute("customerStatistic") != null) {
        customerStatistic = (CustomerStatistic[]) session.getAttribute("customerStatistic");
    }
    if (outTotalRevenue == null && session.getAttribute("outTotalRevenue") != null) {
        outTotalRevenue = (BigDecimal) session.getAttribute("outTotalRevenue");
    }

    DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
    DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
    symbols.setGroupingSeparator('.');
    DecimalFormat moneyFmt = new DecimalFormat("#,###", symbols);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê khách hàng</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <div class="window-card" style="max-width: 1120px; min-height: 520px;">
        <div class="window-header">Thống kê khách hàng</div>
        <div class="window-body">
            <div style="font-size: 15px; margin-bottom: 18px;">
                <span id="txtStartDate" style="margin-right: 90px;">
                    Ngày bắt đầu: <%= (outStartDate != null) ? outStartDate.format(dateFmt) : "" %>
                </span>
                <span id="txtEndDate">
                    Ngày kết thúc: <%= (outEndDate != null) ? outEndDate.format(dateFmt) : "" %>
                </span>
            </div>

            <h3 style="margin-top: 0; margin-bottom: 12px; font-size: 16px;">Danh sách thống kê khách hàng</h3>

            <div class="table-scroll-container">
                <table id="outsubCustomerList" class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 55px;">STT</th>
                            <th style="width: 90px;">Mã KH</th>
                            <th style="width: 150px;">Họ tên</th>
                            <th style="width: 130px;">SĐT</th>
                            <th>Email</th>
                            <th style="width: 150px;">Giờ giao dịch<br>gần nhất</th>
                            <th style="width: 150px;">Ngày giao dịch<br>gần nhất</th>
                            <th style="width: 150px;">Tổng số tiền<br>đã chi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (customerStatistic != null && customerStatistic.length > 0) {
                                for (int i = 0; i < customerStatistic.length; i++) {
                                    CustomerStatistic cs = customerStatistic[i];
                                    String detailUrl = request.getContextPath()
                                            + "/customer-statistics?action=viewTransactions&customerCode="
                                            + cs.getCustomerCode()
                                            + "&startDate=" + (outStartDate != null ? outStartDate.toString() : "")
                                            + "&endDate=" + (outEndDate != null ? outEndDate.toString() : "");
                        %>
                        <tr class="clickable-row" onclick="window.location.href='<%=detailUrl%>'">
                            <td><a href="<%=detailUrl%>"><%= (i + 1) %></a></td>
                            <td><a href="<%=detailUrl%>"><%= cs.getCustomerCode() %></a></td>
                            <td style="text-align: left;"><a href="<%=detailUrl%>"><%= cs.getFullname() %></a></td>
                            <td><a href="<%=detailUrl%>"><%= cs.getPhone() != null ? cs.getPhone() : "" %></a></td>
                            <td style="text-align: left;"><a href="<%=detailUrl%>"><%= cs.getEmail() != null ? cs.getEmail() : "" %></a></td>
                            <td><a href="<%=detailUrl%>"><%= cs.getLastTransactionTime() != null ? cs.getLastTransactionTime().format(timeFmt) : "" %></a></td>
                            <td><a href="<%=detailUrl%>"><%= cs.getLastTransactionDate() != null ? cs.getLastTransactionDate().format(dateFmt) : "" %></a></td>
                            <td style="text-align: right;"><a href="<%=detailUrl%>"><%= cs.getTotalAmount() != null ? moneyFmt.format(cs.getTotalAmount()) : "0" %></a></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <p id="txtTotal" style="font-weight: bold; font-size: 16px; color: #173f66; margin-top: 22px;">
                Tổng doanh thu trong khoảng thời gian: <%= (outTotalRevenue != null) ? moneyFmt.format(outTotalRevenue) : "0" %> VND
            </p>

            <div style="text-align: right; margin-top: 40px;">
                <a id="subBack"
                   href="<%=request.getContextPath()%>/view/ManagementStaff/SelectStatisticsDateView.jsp"
                   class="btn-primary"
                   style="width: 240px; padding: 14px 24px;">
                    Trở về
                </a>
            </div>
        </div>
    </div>
</body>
</html>
