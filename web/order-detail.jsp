<%-- 
    Document   : order-detail
    Created on : Mar 4, 2026, 7:04:38 PM
    Author     : AngDeng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h2 class="text-uppercase fw-bold text-danger m-0">Chi Tiết Đơn Hàng #${orderId}</h2>
        <a href="OrderController?action=history" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left"></i> Quay lại</a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover table-bordered mb-0 text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Mã SP</th>
                        <th>Tên Siêu Xe</th>
                        <th>Đơn Giá</th>
                        <th>Số Lượng</th>
                        <th>Thành Tiền</th>
                    </tr>
                </thead>
                <tbody>
                   <tbody>
                    <c:forEach var="item" items="${listDetails}">
                        <tr>
                            <td class="fw-bold">SP00${item.productID}</td>
                            
                            <td class="text-start fw-bold text-primary">${productNames[item.productID]}</td>
                            
                            <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="$" maxFractionDigits="0"/></td>
                            <td>${item.quantity}</td>
                            <td class="fw-bold text-success">
                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>