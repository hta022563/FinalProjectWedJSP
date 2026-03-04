<%-- 
    Document   : cart
    Created on : Mar 3, 2026, 6:36:56 PM
    Author     : AngDeng
--%>

<%-- File: web/cart.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

    <div class="container my-5">
        <h2 class="fw-bold mb-4 text-uppercase border-bottom pb-2">Giỏ hàng của bạn</h2>

    <c:if test="${not empty msg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover mb-0 text-center align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Mã Xe (ProductID)</th>
                                <th>Số lượng</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td class="text-start">
                                        <c:choose>
                                            <c:when test="${item.productID == 1}">
                                                <span class="fw-bold fs-5">Mercedes-Benz G63</span><br>
                                                <span class="text-danger fw-bold">$200,000</span>
                                            </c:when>
                                            <c:when test="${item.productID == 2}">
                                                <span class="fw-bold fs-5">Audi R8 V10</span><br>
                                                <span class="text-danger fw-bold">$180,000</span>
                                            </c:when>
                                            <c:when test="${item.productID == 3}">
                                                <span class="fw-bold fs-5">Mercedes C300</span><br>
                                                <span class="text-danger fw-bold">$65,000</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fw-bold fs-5">Mã xe: #${item.productID}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary fs-6">1 chiếc</span>
                                        <br>
                                        <small class="text-muted">Màu: Tiêu chuẩn</small>
                                    </td>
                                    <td>
                                        <a href="CartController?action=remove&itemId=${item.cartItemID}" 
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn bỏ xe này khỏi giỏ?');">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty cartItems}">
                                <tr>
                                    <td colspan="3" class="text-center py-4 text-muted">
                                        <i>Giỏ hàng của bạn đang trống. Hãy ra ngoài showroom rước 1 em về nhé!</i>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="mt-3">
                <a href="home.jsp" class="btn btn-outline-dark"><i class="fa-solid fa-arrow-left"></i> Tiếp tục mua sắm</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm border-0 bg-light">
                <div class="card-body">
                    <h5 class="card-title fw-bold border-bottom pb-2">Tóm tắt đơn hàng</h5>
                    <div class="d-flex justify-content-between mb-3 mt-3">
                        <span>Tạm tính:</span>
                        <span class="fw-bold">Liên hệ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3 border-bottom pb-3">
                        <span>Khuyến mãi:</span>
                        <span class="text-success">- 0$</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fs-5 fw-bold">Tổng tiền:</span>
                        <span class="fs-5 fw-bold text-danger">Liên hệ</span>
                    </div>

                    <form action="OrderController" method="POST">
                        <input type="hidden" name="action" value="checkout">
                        <button type="submit" class="btn btn-danger w-100 btn-lg fw-bold shadow-sm" ${empty cartItems ? 'disabled' : ''}>
                            XÁC NHẬN ĐẶT HÀNG
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>