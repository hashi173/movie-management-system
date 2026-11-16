<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.math.BigDecimal,java.text.DecimalFormat,java.text.DecimalFormatSymbols,java.time.LocalDate,java.time.format.DateTimeFormatter,java.util.Locale,model.ManagementStaff,model.Transaction"%>
<%
    // Thực thể ẩn trên Class Diagram Hình 2.6: managementStaff (từ session)
    ManagementStaff managementStaff = (ManagementStaff) session.getAttribute("managementStaff");
    if (managementStaff == null) {
        response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
        return;
    }

    // Thực thể ẩn trên Class Diagram Hình 2.6: transaction (kết quả từ TransactionDAO)
    Transaction[] transaction = (Transaction[]) request.getAttribute("transaction");

    // Tính tổng tiền đã chi của khách hàng từ mảng transaction[]
    BigDecimal totalSpent = BigDecimal.ZERO;
    if (transaction != null) {
        for (Transaction t : transaction) {
            if (t.getFinalAmount() != null) {
                totalSpent = totalSpent.add(t.getFinalAmount());
            }
        }
    }

    // Truy xuất thông tin Customer từ phần tử đầu tiên: transaction[0].getCustomer()
    String khCode = (transaction != null && transaction.length > 0 && transaction[0].getCustomer() != null)
            ? transaction[0].getCustomer().getCustomerCode() : "";
    String khName = (transaction != null && transaction.length > 0 && transaction[0].getCustomer() != null)
            ? transaction[0].getCustomer().getFullname() : "";
    String khPhone = (transaction != null && transaction.length > 0 && transaction[0].getCustomer() != null)
            ? transaction[0].getCustomer().getPhone() : "";
    String khEmail = (transaction != null && transaction.length > 0 && transaction[0].getCustomer() != null)
            ? transaction[0].getCustomer().getEmail() : "";

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
    <title>Chi tiết giao dịch của khách hàng</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <div class="window-card" style="max-width: 1020px; min-height: 500px;">
        <div class="window-header left-align">Chi tiết giao dịch của khách hàng</div>
        <div class="window-body" style="padding: 28px 36px;">
            <div style="font-size: 16px; font-weight: bold; margin-bottom: 24px;">
                <div style="display: flex; gap: 80px; margin-bottom: 14px;">
                    <span id="txtCustomerCode">Mã khách hàng: <%= khCode %></span>
                    <span id="txtCustomerName">Họ tên: <%= khName %></span>
                    <span id="txtCustomerPhone">SĐT: <%= khPhone %></span>
                </div>
                <div>
                    <span id="txtCustomerEmail">Email: <%= khEmail %></span>
                </div>
            </div>

            <h3 style="margin-top: 0; margin-bottom: 12px; font-size: 16px;">Danh sách giao dịch</h3>

            <div class="table-scroll-container">
                <table id="outTransactionList" class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 55px;">STT</th>
                            <th>Mã GD</th>
                            <th>Ngày mua</th>
                            <th>Giờ mua</th>
                            <th>Nhân viên bán vé</th>
                            <th>Mã NV</th>
                            <th>Số lượng</th>
                            <th>Mã suất chiếu</th>
                            <th>Tổng tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (transaction != null && transaction.length > 0) {
                                for (int i = 0; i < transaction.length; i++) {
                                    Transaction t = transaction[i];
                                    String salerName = (t.getSaler() != null) ? t.getSaler().getFullname() : "Mua trực tuyến";
                                    String salerCode = (t.getSaler() != null) ? t.getSaler().getStaffCode() : "-";
                                    int ticketQty = (t.getTickets() != null) ? t.getTickets().length : 0;
                                    String showtimeCode = (t.getTickets() != null && t.getTickets().length > 0
                                            && t.getTickets()[0] != null && t.getTickets()[0].getShowtime() != null)
                                            ? t.getTickets()[0].getShowtime().getShowtimeCode() : "";
                        %>
                        <tr>
                            <td><%= (i + 1) %></td>
                            <td><%= t.getTransactionCode() %></td>
                            <td><%= t.getCreateDate() != null ? t.getCreateDate().format(dateFmt) : "" %></td>
                            <td><%= t.getCreateTime() != null ? t.getCreateTime().format(timeFmt) : "" %></td>
                            <td><%= salerName %></td>
                            <td><%= salerCode %></td>
                            <td><%= ticketQty %></td>
                            <td><%= showtimeCode %></td>
                            <td style="text-align: right;"><%= t.getFinalAmount() != null ? moneyFmt.format(t.getFinalAmount()) : "0" %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" style="padding: 18px; color: #666;">
                                Không có giao dịch nào của khách hàng trong khoảng thời gian đã chọn.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <p id="txtTotalSpent" style="font-weight: bold; font-size: 16px; color: #173f66; margin-top: 22px;">
                Tổng số tiền đã chi: <%= moneyFmt.format(totalSpent) %> VND
            </p>

            <div style="text-align: right; margin-top: 28px;">
                <a id="subBack"
                   href="<%=request.getContextPath()%>/customer-statistics?action=backToRevenue"
                   class="btn-primary"
                   style="padding: 10px 48px;">
                    Trở về
                </a>
            </div>
        </div>
    </div>
</body>
</html>
