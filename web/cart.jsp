<%-- 
    Document   : cart
    Created on : Mar 3, 2026, 6:36:56 PM
    Author     : AngDeng
--%>

<%-- File: web/cart.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <h2 class="fw-bold mb-4 text-uppercase border-bottom pb-2">Giỏ hàng của bạn</h2>

    <c:if test="${not empty msg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">${msg}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>
    </c:if>

    <div class="row">
        <div class="col-md-8 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover mb-0 text-center align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-start ps-4 py-3">Sản phẩm</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th><th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td class="text-start ps-4">
                                        <c:choose>
                                            <c:when test="${item.productID == 1}"><span class="fw-bold fs-5 text-primary">Mercedes-Benz G63</span></c:when>
                                            <c:when test="${item.productID == 2}"><span class="fw-bold fs-5 text-primary">Audi R8 V10</span></c:when>
                                            <c:when test="${item.productID == 3}"><span class="fw-bold fs-5 text-primary">Mercedes C300</span></c:when>
                                            <c:otherwise><span class="fw-bold fs-5 text-primary">Xe mã số #${item.productID}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-bold"><fmt:formatNumber value="${productPrices[item.productID]}" type="number" pattern="#,###"/> VNĐ</td>
                                    <td>
                                        <div class="input-group input-group-sm mx-auto" style="width: 120px;">
                                            <a href="CartController?action=update&cartItemId=${item.cartItemID}&quantity=${item.quantity - 1}" class="btn btn-outline-secondary fw-bold"> - </a>
                                            <input type="text" class="form-control text-center fw-bold" value="${item.quantity}" readonly>
                                            <a href="CartController?action=update&cartItemId=${item.cartItemID}&quantity=${item.quantity + 1}" class="btn btn-outline-secondary fw-bold"> + </a>
                                        </div>
                                    </td>
                                    <td class="fw-bold text-success"><fmt:formatNumber value="${productPrices[item.productID] * item.quantity}" type="number" pattern="#,###"/> VNĐ</td>
                                    <td>
                                        <a href="CartController?action=remove&itemId=${item.cartItemID}" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn bỏ xe này khỏi giỏ?');">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty cartItems}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="fa-solid fa-cart-arrow-down mb-3 text-secondary" style="font-size: 4rem;"></i><br>
                                        <span class="fs-5 fw-bold">Giỏ hàng của bạn đang trống.</span>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="mt-3 d-flex justify-content-between">
                <a href="home.jsp" class="btn btn-outline-dark fw-bold"><i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua sắm</a>
                <a href="OrderController?action=history" class="btn btn-info text-white fw-bold"><i class="fa-solid fa-clock-rotate-left me-1"></i> Xem Lịch sử đặt hàng</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm border-0 bg-light">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold border-bottom pb-3 mb-4 text-secondary">TÓM TẮT ĐƠN HÀNG</h5>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fs-5 fw-bold">Tổng thanh toán:</span>
                        <span class="fs-4 fw-bold text-danger"><fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> VNĐ</span>
                    </div>

                    <form action="OrderController" method="POST">
                        <input type="hidden" name="action" value="checkout">
                        <button type="submit" class="btn btn-danger w-100 btn-lg fw-bold shadow-sm" ${empty cartItems ? 'disabled' : ''}>
                            <i class="fa-solid fa-check-circle me-1"></i> XÁC NHẬN ĐẶT HÀNG
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>