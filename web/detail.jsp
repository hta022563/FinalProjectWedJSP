<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>
<%-- File: web/detail.jsp --%>
<%-- File: web/detail.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.ReviewDAO, model.ReviewDTO, java.util.List"%>

<%
    String carIdStr = request.getParameter("id");
    if (carIdStr == null) { carIdStr = "1"; }
    int cId = Integer.parseInt(carIdStr);
    ReviewDAO reviewDAO = new ReviewDAO();
    List<ReviewDTO> reviewList = reviewDAO.getReviewsByProduct(cId);
    request.setAttribute("reviewList", reviewList);
    request.setAttribute("reviewDAO", reviewDAO);
%>

<c:choose>
    <c:when test="${param.id == '2'}">
        <c:set var="carName" value="Audi R8 V10" /><c:set var="carCode" value="#AUDI-R8-002" />
        <c:set var="carPrice" value="4,500,000,000" /><c:set var="carImg" value="IMG/OIP.webp" />
        <c:set var="carDesc" value="Siêu xe thể thao mang động cơ V10 mạnh mẽ, thiết kế khí động học hoàn hảo." />
        <c:set var="carId" value="2" />
    </c:when>
    <c:when test="${param.id == '3'}">
        <c:set var="carName" value="Mercedes C300" /><c:set var="carCode" value="#MER-C300-003" />
        <c:set var="carPrice" value="1,500,000,000" /><c:set var="carImg" value="IMG/Mec300.webp" />
        <c:set var="carDesc" value="Mẫu Sedan hạng sang cỡ nhỏ, thiết kế thanh lịch, nội thất hiện đại." />
        <c:set var="carId" value="3" />
    </c:when>
    <c:otherwise>
        <c:set var="carName" value="Mercedes-Benz G63 AMG" /><c:set var="carCode" value="#MER-G63-001" />
        <c:set var="carPrice" value="5,000,000,000" /><c:set var="carImg" value="IMG/OIP (2).webp" />
        <c:set var="carDesc" value="Chiếc SUV địa hình mang tính biểu tượng, kết hợp giữa sức mạnh vượt trội và sự sang trọng tuyệt đối." />
        <c:set var="carId" value="1" />
    </c:otherwise>
</c:choose>

<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    .luxury-title { font-family: 'Playfair Display', serif; color: #D4AF37; text-transform: uppercase; letter-spacing: 2px; }
    .text-gold { color: #D4AF37 !important; }
    .text-light-grey { color: #cccccc !important; }
    
    /* Giao diện khung chứa Dark Theme */
    .luxury-container { background: #111; border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5); padding: 30px; }
    .review-card { background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(212, 175, 55, 0.1); border-radius: 10px; transition: 0.3s; }
    .review-card:hover { border-color: rgba(212, 175, 55, 0.4); background: rgba(255, 255, 255, 0.05); }
    
    /* Giao diện form nhập liệu Dark Theme */
    .form-control-luxury, .form-select-luxury { background-color: rgba(0, 0, 0, 0.5) !important; border: 1px solid rgba(212, 175, 55, 0.3) !important; color: #fff !important; }
    .form-control-luxury:focus, .form-select-luxury:focus { border-color: #D4AF37 !important; box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25) !important; }
    .form-control-luxury::placeholder { color: #888; }
    
    /* Nút bấm Vàng F-AUTO */
    .btn-luxury { background: linear-gradient(135deg, #D4AF37, #FFD700); color: #000 !important; font-weight: bold; border: none; transition: 0.3s; }
    .btn-luxury:hover { background: #f1c40f; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3); }
    
    .swal-luxury-popup { border: 1px solid rgba(212, 175, 55, 0.3) !important; border-radius: 12px !important; box-shadow: 0 15px 40px rgba(0,0,0,0.8) !important; }
</style>

<div class="container my-5">
    
    <c:if test="${not empty msg}">
        <script>
            Swal.fire({
                title: '<span style="font-family: \'Playfair Display\', serif; color: #D4AF37;">Thành Công</span>',
                html: '<span style="color: #e0e0e0; font-family: \'Montserrat\', sans-serif;">${msg}</span>',
                icon: 'success', iconColor: '#D4AF37', background: '#121212',
                customClass: { popup: 'swal-luxury-popup', confirmButton: 'btn btn-outline-warning px-4 py-2 rounded-pill fw-bold' },
                buttonsStyling: false, confirmButtonText: 'Đóng'
            });
        </script>
        <c:remove var="msg" />
    </c:if>

    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-gold">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="MainController?target=Product" class="text-decoration-none text-light-grey">Kho xe</a></li>
            <li class="breadcrumb-item active text-white fw-bold" aria-current="page">${carName}</li>
        </ol>
    </nav>

    <div class="row luxury-container mb-5 align-items-center">
        <div class="col-md-7 mb-4 mb-md-0">
            <img src="${carImg}" class="img-fluid rounded-3 shadow-lg" alt="${carName}" style="height: 450px; object-fit: cover; width: 100%; border: 1px solid rgba(212, 175, 55, 0.2);">
        </div>

        <div class="col-md-5 ps-md-4 d-flex flex-column">
            <h2 class="luxury-title mb-2 fs-3">${carName}</h2>
            <p class="text-light-grey mb-3 fs-6">Mã xe: <span class="fw-bold text-white">${carCode}</span></p>
            <h1 class="text-gold fw-bold mb-4">${carPrice} VNĐ</h1>

            <div class="p-3 mb-4" style="background: rgba(255,255,255,0.03); border-left: 4px solid #D4AF37; border-radius: 4px;">
                <div class="d-flex align-items-center mb-2"><i class="fa-solid fa-check text-success fs-5 me-3"></i><span class="fs-6 text-white">Tình trạng: <strong class="text-success">Sẵn sàng giao xe</strong></span></div>
                <div class="d-flex align-items-center"><i class="fa-solid fa-car text-light-grey fs-5 me-3"></i><span class="fs-6 text-white">Odo: <strong>0 km (Mới 100%)</strong></span></div>
            </div>

            <p class="fs-6 lh-base text-light-grey mb-5">${carDesc}</p>

            <form action="MainController" method="POST" class="d-grid mt-auto">
                <input type="hidden" name="target" value="Cart">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="productId" value="${carId}">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="returnUrl" value="detail.jsp?id=${carId}">
                <button type="submit" class="btn btn-luxury py-3 fs-5 rounded-pill shadow-lg">
                    <i class="fa-solid fa-cart-plus me-2"></i> ĐẶT CỌC NGAY
                </button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="luxury-container">
                <div class="d-flex align-items-center border-bottom border-warning border-opacity-25 pb-3 mb-4">
                    <h4 class="luxury-title mb-0 fs-4">ĐÁNH GIÁ TỪ KHÁCH HÀNG</h4>
                    <span class="ms-3 badge bg-warning text-dark rounded-pill px-3 py-2 fs-6 fw-bold">${reviewList.size()}</span>
                </div>

                <div class="row">
                    <div class="col-md-5 mb-5 mb-md-0 border-end border-secondary border-opacity-25 pe-md-4">
                        <h5 class="fw-bold mb-4 text-white"><i class="fa-solid fa-pen-to-square me-2 text-gold"></i>Trải nghiệm của bạn</h5>
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="target" value="Review">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${carId}">
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-bold text-light-grey small">Mức độ hài lòng</label>
                                        <select name="rating" class="form-select form-select-luxury p-2">
                                            <option value="5" style="color: black;">⭐⭐⭐⭐⭐ Tuyệt vời</option>
                                            <option value="4" style="color: black;">⭐⭐⭐⭐ Rất tốt</option>
                                            <option value="3" style="color: black;">⭐⭐⭐ Hài lòng</option>
                                            <option value="2" style="color: black;">⭐⭐ Tạm được</option>
                                            <option value="1" style="color: black;">⭐ Không hài lòng</option>
                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label fw-bold text-light-grey small">Nội dung đánh giá</label>
                                        <textarea name="comment" class="form-control form-control-luxury p-3" rows="4" placeholder="Nhập cảm nhận của bạn về siêu xe..." required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-outline-warning w-100 fw-bold py-2 rounded-pill">
                                        <i class="fa-regular fa-paper-plane me-1"></i> GỬI ĐÁNH GIÁ
                                    </button>
                                </form>
                            </c:when>
                            
                            <c:otherwise>
                                <div class="p-4 rounded-3 text-center border border-secondary border-opacity-25" style="background: rgba(255,255,255,0.02);">
                                    <i class="fa-solid fa-lock fs-1 text-gold mb-3 opacity-75"></i>
                                    <h6 class="text-white fw-bold mb-3">Vui lòng đăng nhập!</h6>
                                    <p class="text-light-grey small mb-4">Bạn cần đăng nhập tài khoản để có thể gửi đánh giá cho siêu xe này.</p>
                                    <a href="login.jsp" class="btn btn-outline-warning fw-bold w-100 py-2 rounded-pill">
                                        <i class="fa-solid fa-right-to-bracket me-2"></i> Đăng Nhập Ngay
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-md-7 ps-md-4" style="max-height: 500px; overflow-y: auto;">
                        <c:choose>
                            <c:when test="${empty reviewList}">
                                <div class="text-center py-5">
                                    <i class="fa-regular fa-comments fs-1 text-secondary mb-3 opacity-50"></i>
                                    <h6 class="text-secondary">Chưa có đánh giá nào. Hãy là người đầu tiên!</h6>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="rev" items="${reviewList}">
                                    <div class="card review-card mb-3 border-0">
                                        <div class="card-body p-3 p-md-4">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 40px; height: 40px;"><i class="fa-solid fa-user"></i></div>
                                                    <div>
                                                        <h6 class="fw-bold mb-0 text-white">${reviewDAO.getUsername(rev.userID)}</h6>
                                                        <div class="text-warning" style="font-size: 0.85rem;"><c:forEach begin="1" end="${rev.rating}">⭐</c:forEach></div>
                                                    </div>
                                                </div>
                                                <small class="text-light-grey"><fmt:formatDate value="${rev.reviewDate}" pattern="dd/MM/yyyy" /></small>
                                            </div>

                                            <p class="mt-3 mb-0 text-white fs-6" style="line-height: 1.6;">${rev.comment}</p>

                                            <c:if test="${sessionScope.user != null && (sessionScope.user.userID == rev.userID || sessionScope.user.role == 1)}">
                                                <div class="mt-3 pt-3 border-top border-secondary border-opacity-25 d-flex justify-content-end gap-2">
                                                    <c:if test="${sessionScope.user.userID == rev.userID}">
                                                        <button class="btn btn-sm btn-outline-light rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editModal${rev.reviewID}">
                                                            <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                                                        </button>
                                                    </c:if>
                                                    <a href="MainController?target=Review&action=delete&reviewId=${rev.reviewID}&productId=${carId}" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?');">
                                                        <i class="fa-solid fa-trash me-1"></i> Xóa
                                                    </a>
                                                </div>

                                                <div class="modal fade" id="editModal${rev.reviewID}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content" style="background: #1a1a1a; border: 1px solid #D4AF37;">
                                                            <form action="MainController" method="POST">
                                                                <div class="modal-header border-bottom border-secondary pb-3 pt-4 px-4">
                                                                    <h5 class="modal-title fw-bold text-gold">Sửa Đánh Giá</h5>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>

                                                                <div class="modal-body px-4 py-4 text-start">
                                                                    <input type="hidden" name="target" value="Review">
                                                                    <input type="hidden" name="action" value="update">
                                                                    <input type="hidden" name="reviewId" value="${rev.reviewID}">
                                                                    <input type="hidden" name="productId" value="${carId}">

                                                                    <div class="mb-4">
                                                                        <label class="form-label text-light-grey small fw-bold">Mức độ hài lòng</label>
                                                                        <select name="rating" class="form-select form-select-luxury p-2">
                                                                            <option value="5" style="color: black;" ${rev.rating == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐ Tuyệt vời</option>
                                                                            <option value="4" style="color: black;" ${rev.rating == 4 ? 'selected' : ''}>⭐⭐⭐⭐ Rất tốt</option>
                                                                            <option value="3" style="color: black;" ${rev.rating == 3 ? 'selected' : ''}>⭐⭐⭐ Hài lòng</option>
                                                                            <option value="2" style="color: black;" ${rev.rating == 2 ? 'selected' : ''}>⭐⭐ Tạm được</option>
                                                                            <option value="1" style="color: black;" ${rev.rating == 1 ? 'selected' : ''}>⭐ Không hài lòng</option>
                                                                        </select>
                                                                    </div>

                                                                    <div>
                                                                        <label class="form-label text-light-grey small fw-bold">Nội dung đánh giá</label>
                                                                        <textarea name="comment" class="form-control form-control-luxury p-3" rows="3">${rev.comment}</textarea>
                                                                    </div>
                                                                </div>

                                                                <div class="modal-footer border-top border-secondary pt-3 px-4 pb-4">
                                                                    <button type="button" class="btn btn-outline-light rounded-pill px-4" data-bs-dismiss="modal">Hủy</button>
                                                                    <button type="submit" class="btn btn-warning rounded-pill px-4 fw-bold">Lưu thay đổi</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>