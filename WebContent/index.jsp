<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Trang điều hướng mặc định khi truy cập vào thư mục gốc của ứng dụng (/)
    // Tự động chuyển hướng sang Trang chủ khách hàng (CustomerHomeView.jsp)
    response.sendRedirect(request.getContextPath() + "/view/Customer/CustomerHomeView.jsp");
%>
