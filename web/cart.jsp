<%-- File: web/cart.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    
    .luxury-title {
        font-family: 'Playfair Display', serif;
        color: #D4AF37; text-transform: uppercase; letter-spacing: 2px;
        text-shadow: 0 2px 10px rgba(212, 175, 55, 0.4);
    }
    .text-gold { color: #D4AF37 !important; }
    .text-light-grey { color: #cccccc !important; }

    .luxury-container {
        background: linear-gradient(145deg, #1a1a1a, #121212);
        border: 1px solid rgba(212, 175, 55, 0.3);
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6), 0 0 15px rgba(212, 175, 55, 0.05);
        padding: 25px;
    }

    .table-luxury { 
        --bs-table-bg: transparent; border-color: rgba(212, 175, 55, 0.2); 
    }
    .table-luxury tbody, .table-luxury tr, .table-luxury td, .table-luxury th, .table-luxury thead {
        background-color: transparent !important; background: none !important; color: #ffffff !important; 
    }
    .table-luxury thead th {
        background-color: rgba(0, 0, 0, 0.5) !important; border-bottom: 2px solid #D4AF37 !important;
        color: #D4AF37 !important; font-family: 'Playfair Display', serif; letter-spacing: 1px;
    }
    .table-luxury tbody tr { transition: 0.3s; }
    .table-luxury tbody tr:hover td { background-color: rgba(212, 175, 55, 0.08) !important; }
    .table-luxury td { border-bottom: 1px solid rgba(212, 175, 55, 0.1); vertical-align: middle; }

    .btn-luxury {
        background: linear-gradient(45deg, #B8860B, #FFD700, #B8860B);
        background-size: 200% auto; color: #000 !important; font-weight: 700; text-transform: uppercase;
        border: none; border-radius: 50px; padding: 12px 25px; transition: 0.5s;
        box-shadow: 0 0 20px rgba(212, 175, 55, 0.4);
    }
    .btn-luxury:hover { background-position: right center; transform: translateY(-3px); box-shadow: 0 0 30px rgba(212, 175, 55, 0.8); }

    .btn-outline-luxury {
        color: #D4AF37; border: 1px solid #D4AF37; border-radius: 50px;
        text-transform: uppercase; font-weight: 600; transition: 0.4s; background: transparent;
    }
    .btn-outline-luxury:hover { background: #D4AF37; color: #000; box-shadow: 0 0 15px rgba(212, 175, 55, 0.5); }
    
    .btn-qty { background: transparent; border: 1px solid #D4AF37; color: #D4AF37; font-weight: bold; }
    .btn-qty:hover { background: #D4AF37; color: #000; }
    .input-qty { color: #ffffff !important; background-color: transparent !important; }

    /* CSS Popup Luxury Tinh Tế (Đã xóa bộ CSS Sci-fi) */
    .swal-luxury-popup {
        border: 1px solid rgba(212, 175, 55, 0.3) !important;
        border-radius: 12px !important;
        box-shadow: 0 15px 40px rgba(0,0,0,0.8) !important;
    }
</style>

<script>
    function xoaKhoiGio(event, url) {
        event.preventDefault();
        Swal.fire({
            title: '<span style="font-family: \'Playfair Display\', serif; color: #D4AF37; font-size: 1.8rem;">Loại Bỏ Siêu Xe</span>',
            html: '<p style="color: #ccc; font-family: \'Montserrat\', sans-serif; font-size: 1rem; margin-top: 10px;">Bạn có chắc chắn muốn bỏ siêu phẩm này khỏi giỏ hàng không?</p>',
            icon: 'question', 
            iconColor: '#D4AF37', 
            background: '#121212',
            backdrop: `rgba(0, 0, 0, 0.7)`,
            showCancelButton: true,
            confirmButtonText: 'Xác nhận bỏ',
            cancelButtonText: 'Giữ lại',
            customClass: { 
                popup: 'swal-luxury-popup',
                confirmButton: 'btn btn-danger px-4 py-2 mx-2 rounded-pill fw-bold', 
                cancelButton: 'btn btn-outline-secondary text-white border-secondary px-4 py-2 mx-2 rounded-pill fw-bold' 
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '<span style="color: #D4AF37; font-family: \'Playfair Display\', serif;">Đang cập nhật...</span>',
                    background: '#121212',
                    allowOutsideClick: false,
                    didOpen: () => { 
                        Swal.showLoading(); 
                        setTimeout(() => { window.location.href = url; }, 500); 
                    }
                });
            }
        })
    }
</script>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom border-warning pb-2">
        <h2 class="luxury-title mb-0">Gara Của Bạn</h2>
    </div>

    <c:if test="${not empty msg}">
        <script>
            Swal.fire({ 
                title: '<span style="font-family: \'Playfair Display\', serif; color: #D4AF37;">Thành Công</span>', 
                html: '<span style="color: #e0e0e0; font-family: \'Montserrat\', sans-serif;">${msg}</span>', 
                icon: 'success', 
                iconColor: '#D4AF37',
                background: '#121212', 
                customClass: {
                    popup: 'swal-luxury-popup',
                    confirmButton: 'btn btn-outline-luxury px-4 py-2 rounded-pill fw-bold'
                },
                buttonsStyling: false,
                confirmButtonText: 'Đóng'
            });
        </script>
    </c:if>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="luxury-container p-0 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-luxury mb-0 text-center">
                        <thead>
                            <tr>
                                <th class="text-start ps-4 py-3">Siêu Phẩm</th> <th>Đơn Giá</th> <th>Số Lượng</th> <th>Thành Tiền</th> <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td class="text-start ps-4">
                                        <c:choose>
                                            <c:when test="${item.productID == 1}"><span class="fw-bold fs-5 text-gold">Mercedes-Benz G63</span></c:when>
                                            <c:when test="${item.productID == 2}"><span class="fw-bold fs-5 text-gold">Audi R8 V10</span></c:when>
                                            <c:when test="${item.productID == 3}"><span class="fw-bold fs-5 text-gold">Mercedes C300</span></c:when>
                                            <c:otherwise><span class="fw-bold fs-5 text-gold">Mã số #${item.productID}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-bold fs-6"><fmt:formatNumber value="${productPrices[item.productID]}" type="number" pattern="#,###"/> VNĐ</td>
                                    <td>
                                        <div class="input-group input-group-sm mx-auto" style="width: 120px; border: 1px solid #D4AF37; border-radius: 5px; overflow: hidden;">
                                            <a href="CartController?action=update&cartItemId=${item.cartItemID}&quantity=${item.quantity - 1}" class="btn btn-qty px-3"> - </a>
                                            <input type="text" class="form-control text-center fw-bold bg-transparent border-0 input-qty" value="${item.quantity}" readonly>
                                            <a href="CartController?action=update&cartItemId=${item.cartItemID}&quantity=${item.quantity + 1}" class="btn btn-qty px-3"> + </a>
                                        </div>
                                    </td>
                                    <td class="fw-bold fs-6 text-white"><fmt:formatNumber value="${productPrices[item.productID] * item.quantity}" type="number" pattern="#,###"/> VNĐ</td>
                                    <td>
                                        <a href="CartController?action=remove&itemId=${item.cartItemID}" class="btn btn-outline-danger btn-sm px-3 rounded-pill" onclick="xoaKhoiGio(event, this.href)">
                                            <i class="fa-solid fa-trash"></i> Bỏ
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty cartItems}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <i class="fa-solid fa-car mb-3" style="font-size: 4rem; color: #333;"></i><br>
                                        <span class="fs-5 text-light-grey">Gara của bạn đang trống.</span>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="mt-4 d-flex flex-wrap gap-3 justify-content-between">
                <a href="home.jsp" class="btn btn-outline-luxury"><i class="fa-solid fa-arrow-left me-2"></i> Tiếp tục chọn xe</a>
                <a href="OrderController?action=history" class="btn btn-outline-secondary text-white rounded-pill px-4"><i class="fa-solid fa-clock-rotate-left me-2"></i> Hồ sơ giao dịch</a>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="luxury-container position-sticky" style="top: 100px;">
                <h5 class="luxury-title border-bottom border-warning pb-3 mb-4 fs-4 text-center">TỔNG KẾT</h5>
                <div class="d-flex justify-content-between mb-2 text-light-grey fs-6">
                    <span>Tạm tính:</span> <span class="fw-bold text-white"><fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> VNĐ</span>
                </div>
                <div class="d-flex justify-content-between mb-4 text-light-grey fs-6">
                    <span>Phí vận chuyển:</span> <span class="fst-italic">Liên hệ</span>
                </div>
                <div class="d-flex justify-content-between mb-4 border-top border-secondary pt-3">
                    <span class="fs-5 fw-bold text-white">Tổng cộng:</span> <span class="fs-4 fw-bold text-gold"><fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> VNĐ</span>
                </div>
                <form action="OrderController" method="POST">
                    <input type="hidden" name="action" value="checkout">
                    <button type="submit" class="btn btn-luxury w-100 fs-6" ${empty cartItems ? 'disabled' : ''}>
                        <i class="fa-solid fa-file-signature me-2"></i> LÀM HỢP ĐỒNG MUA
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>