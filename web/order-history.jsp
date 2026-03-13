<%-- File: web/order-history.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #0a0a0a;
            color: #e0e0e0;
            font-family: 'Montserrat', sans-serif;
        }

        .luxury-title {
            font-family: 'Playfair Display', serif;
            color: #D4AF37;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .text-gold {
            color: #D4AF37 !important;
        }
        .text-light-grey {
            color: #cccccc !important;
        }

        .luxury-container {
            background: #111;
            border: 1px solid rgba(212, 175, 55, 0.2);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            padding: 30px;
        }

        .table-luxury {
            --bs-table-bg: transparent;
            border-color: rgba(212, 175, 55, 0.1);
        }
        .table-luxury th, .table-luxury td, .table-luxury tr, .table-luxury tbody, .table-luxury thead {
            background-color: transparent !important;
            color: #ffffff !important;
        }
        .table-luxury thead th {
            background-color: rgba(0, 0, 0, 0.4) !important;
            border-bottom: 1px solid #D4AF37 !important;
            color: #D4AF37 !important;
            font-family: 'Playfair Display', serif;
            letter-spacing: 1px;
            text-transform: uppercase;
            padding: 15px;
        }
        .table-luxury tbody tr {
            transition: 0.3s;
        }
        .table-luxury tbody tr:hover td {
            background-color: rgba(212, 175, 55, 0.05) !important;
        }
        .table-luxury td {
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            vertical-align: middle;
            padding: 15px;
        }

        .btn-outline-luxury {
            color: #D4AF37;
            border: 1px solid #D4AF37;
            border-radius: 50px;
            font-weight: 500;
            transition: 0.3s;
            background: transparent;
        }
        .btn-outline-luxury:hover {
            background: #D4AF37;
            color: #000;
        }

        .btn-outline-danger-lux {
            color: #e74c3c;
            border: 1px solid #e74c3c;
            border-radius: 50px;
            font-weight: 500;
            transition: 0.3s;
            background: transparent;
        }
        .btn-outline-danger-lux:hover {
            background: #e74c3c;
            color: #fff;
        }

        .badge-luxury {
            background: rgba(212, 175, 55, 0.1) !important;
            border: 1px solid rgba(212, 175, 55, 0.5);
            color: #D4AF37 !important;
            padding: 8px 15px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        /* Tùy chỉnh nhẹ lại khung Modal của SweetAlert2 cho Luxury */
        .swal-luxury-popup {
            border: 1px solid rgba(212, 175, 55, 0.3) !important;
            border-radius: 12px !important;
            box-shadow: 0 15px 40px rgba(0,0,0,0.8) !important;
        }
    </style>

    <script>
        function xoaDonHang(event, url, orderId) {
            event.preventDefault();
            Swal.fire({
                title: '<span style="font-family: \'Playfair Display\', serif; color: #D4AF37; font-size: 1.8rem;">Hủy Giao Dịch</span>',
                html: '<p style="color: #ccc; font-family: \'Montserrat\', sans-serif; font-size: 1rem; margin-top: 10px;">Bạn có chắc chắn muốn hủy đơn đặt xe mã <b style="color: #fff;">#' + orderId + '</b> không?</p>',
                icon: 'question',
                iconColor: '#D4AF37',
                background: '#121212',
                backdrop: `rgba(0, 0, 0, 0.7)`,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận hủy',
                cancelButtonText: 'Đóng',
                customClass: {
                    popup: 'swal-luxury-popup',
                    confirmButton: 'btn btn-danger px-4 py-2 mx-2 rounded-pill fw-bold',
                    cancelButton: 'btn btn-outline-secondary text-white border-secondary px-4 py-2 mx-2 rounded-pill fw-bold'
                },
                buttonsStyling: false
            }).then((result) => {
                if (result.isConfirmed) {
                    // Hiển thị loading nhẹ nhàng
                    Swal.fire({
                        title: '<span style="color: #D4AF37; font-family: \'Playfair Display\', serif;">Đang xử lý...</span>',
                        background: '#121212',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                            setTimeout(() => {
                                window.location.href = url;
                            }, 500);
                        }
                    });
                }
            }
        }
    </script>

    <div class="container my-5">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home.jsp" class="text-gold text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active text-light-grey" aria-current="page">Hồ sơ giao dịch</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-end mb-4 border-bottom border-secondary pb-3">
            <h2 class="luxury-title mb-0">Hồ Sơ Giao Dịch</h2>
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
        <c:remove var="msg" />
    </c:if>

    <div class="luxury-container p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-luxury mb-0 text-center align-middle">
                <thead>
                    <tr>
                        <th class="ps-4 text-start">Mã Đơn</th> 
                        <th>Ngày Lập</th> 
                        <th class="text-start">Địa Chỉ Giao Xe</th> 
                        <th>Tổng Giá Trị</th> 
                        <th>Trạng Thái</th> 
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listOrders}">
                            <tr>
                                <td colspan="6" class="text-center py-5">
                                    <i class="fa-solid fa-box-open mb-3" style="font-size: 3.5rem; color: #444;"></i><br>
                                    <span class="fs-6 text-muted">Bạn chưa có hồ sơ giao dịch nào.</span>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${listOrders}">
                                <tr>
                                    <td class="fw-bold text-gold text-start ps-4 fs-6">#${order.orderID}</td>
                                    <td class="text-light-grey small"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td class="text-start text-light-grey small" style="max-width: 250px;">${order.shippingAddress}</td>
                                    <td class="fw-bold text-white"><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,###"/> VNĐ</td>
                                    
                                    <%-- FIX LỖI ICON Ở ĐÂY SẾP NHÉ --%>
                                    <td>
                                        <span class="badge badge-luxury">
                                            <c:choose>
                                                <c:when test="${order.status == 'Đang xử lý'}">
                                                    <i class="fa-solid fa-circle-notch fa-spin me-1 text-warning" style="font-size: 0.8rem;"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'Đã duyệt'}">
                                                    <i class="fa-solid fa-clipboard-check me-1 text-info" style="font-size: 0.8rem;"></i>
                                                </c:when>
                                                <c:when test="${order.status == 'Đang giao'}">
                                                    <i class="fa-solid fa-truck-fast me-1 text-primary" style="font-size: 0.8rem;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa-solid fa-circle-check me-1 text-success" style="font-size: 0.8rem;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            ${order.status}
                                        </span>
                                    </td>
                                    
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="OrderController?action=detail&id=${order.orderID}" class="btn btn-sm btn-outline-luxury px-3">
                                                Xem
                                            </a>

                                            <%-- KIỂM TRA TRẠNG THÁI: CHỈ CHO HỦY KHI CHƯA DUYỆT --%>
                                            <c:choose>
                                                <c:when test="${order.status == 'Đang xử lý'}">
                                                    <a href="OrderController?action=delete&id=${order.orderID}" class="btn btn-sm btn-outline-danger-lux px-3" onclick="xoaDonHang(event, this.href, '${order.orderID}')">
                                                        Hủy
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-outline-secondary px-3" disabled style="opacity: 0.5;" title="Admin đã xử lý đơn này, không thể hủy!">
                                                        <i class="fa-solid fa-lock"></i> Khóa
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <div class="mt-4 text-start">
        <a href="home.jsp" class="btn btn-outline-luxury px-4 py-2"><i class="fa-solid fa-arrow-left me-2"></i> Trở về Showroom</a>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>