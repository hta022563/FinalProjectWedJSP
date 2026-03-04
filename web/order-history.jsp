<%-- 
    Document   : order-history
    Created on : Mar 3, 2026, 6:37:36 PM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <h2 class="text-center fw-bold mb-4 text-uppercase border-bottom pb-2 border-danger d-inline-block">Lịch sử đặt hàng</h2>
    
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover table-bordered mb-0 text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Ngày Đặt</th>
                        <th>Địa Chỉ Giao</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listOrders}">
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">
                                    <i class="fa-solid fa-box-open fs-1 mb-2"></i><br>
                                    Bạn chưa có đơn hàng nào. Hãy chốt một chiếc siêu xe ngay!
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${listOrders}">
                                <tr>
                                    <td class="fw-bold text-danger">#${order.orderID}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td class="text-start">${order.shippingAddress}</td>
                                    <td class="fw-bold text-success">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <span class="badge bg-warning text-dark"><i class="fa-solid fa-clock"></i> ${order.status}</span>
                                    </td>
                                    <td>
                                       <a href="OrderController?action=detail&id=${order.orderID}" class="btn btn-sm btn-outline-dark">
    <i class="fa-solid fa-eye"></i> Xem chi tiết
</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>