<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.ReviewDAO, model.ReviewDTO, java.util.List"%>

<%
    String carIdStr = request.getParameter("id");
    if(carIdStr == null) carIdStr = "1";
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

<div class="container my-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-dark fw-bold">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="#" class="text-decoration-none text-muted">Sản phẩm</a></li>
            <li class="breadcrumb-item active text-danger fw-bold" aria-current="page">${carName}</li>
        </ol>
    </nav>

    <div class="row bg-white p-4 rounded-4 shadow-sm mb-5">
        <div class="col-md-7 mb-4 mb-md-0">
            <img src="${carImg}" class="img-fluid rounded-3" alt="${carName}" style="height: 450px; object-fit: cover; width: 100%;">
        </div>

        <div class="col-md-5 ps-md-4 d-flex flex-column">
            <h2 class="fw-bold mb-2 text-uppercase">${carName}</h2>
            <p class="text-muted mb-3 fs-6">Mã xe: <span class="fw-bold text-dark">${carCode}</span></p>
            <h1 class="text-danger fw-bold mb-4">${carPrice} VNĐ</h1>
            
            <div class="p-3 bg-light border-start border-danger border-4 rounded-end mb-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="fa-solid fa-check text-success fs-5 me-3"></i>
                    <span class="fs-6">Tình trạng: <strong>Sẵn sàng giao xe</strong></span>
                </div>
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-car text-secondary fs-5 me-3"></i>
                    <span class="fs-6">Odo: <strong>0 km (Mới 100%)</strong></span>
                </div>
            </div>
            
            <p class="fs-6 lh-base text-secondary mb-4">${carDesc}</p>
            
            <form action="CartController" method="POST" class="d-grid mt-auto">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="productId" value="${carId}">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="returnUrl" value="detail.jsp?id=${carId}">
                
                <button type="submit" class="btn btn-danger btn-lg py-3 fw-bold text-uppercase rounded-3 shadow-sm">
                    <i class="fa-solid fa-cart-plus me-2"></i> Đặt Cọc Ngay
                </button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="bg-white p-4 p-md-5 rounded-4 shadow-sm">
                <div class="d-flex align-items-center border-bottom pb-3 mb-4">
                    <h4 class="fw-bold text-uppercase mb-0 text-dark">Đánh Giá Khách Hàng</h4>
                    <span class="ms-3 badge bg-danger rounded-pill px-3 py-2 fs-6">${reviewList.size()}</span>
                </div>
                
                <div class="row">
                    <div class="col-md-5 mb-5 mb-md-0 border-end pe-md-4">
                        <h5 class="fw-bold mb-3"><i class="fa-solid fa-pen-to-square me-2 text-danger"></i>Gửi đánh giá của bạn</h5>
                        <form action="ReviewController" method="POST">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${carId}">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Đánh giá sao</label>
                                <select name="rating" class="form-select bg-light border-0 text-warning fw-bold shadow-none p-2">
                                    <option value="5">⭐⭐⭐⭐⭐ Tuyệt vời</option>
                                    <option value="4">⭐⭐⭐⭐ Rất tốt</option>
                                    <option value="3">⭐⭐⭐ Hài lòng</option>
                                    <option value="2">⭐⭐ Tạm được</option>
                                    <option value="1">⭐ Không hài lòng</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Nội dung đánh giá</label>
                                <textarea name="comment" class="form-control bg-light border-0 shadow-none p-3" rows="4" placeholder="Nhập trải nghiệm của bạn về chiếc xe..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-dark w-100 fw-bold py-2 rounded-3">Gửi Đánh Giá</button>
                        </form>
                    </div>

                    <div class="col-md-7 ps-md-4">
                        <c:choose>
                            <c:when test="${empty reviewList}">
                                <div class="text-center py-5">
                                    <i class="fa-regular fa-comments fs-1 text-muted mb-3 opacity-50"></i>
                                    <h6 class="text-muted">Chưa có đánh giá nào. Khởi xướng ngay nhé!</h6>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="rev" items="${reviewList}">
                                    <div class="card border-0 bg-light rounded-3 mb-3">
                                        <div class="card-body p-3 p-md-4">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center me-2" style="width: 36px; height: 36px;">
                                                        <i class="fa-solid fa-user fs-6"></i>
                                                    </div>
                                                    <div>
                                                        <h6 class="fw-bold mb-0 text-dark">${reviewDAO.getUsername(rev.userID)}</h6>
                                                        <div class="text-warning" style="font-size: 0.8rem;">
                                                            <c:forEach begin="1" end="${rev.rating}">⭐</c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <small class="text-muted"><fmt:formatDate value="${rev.reviewDate}" pattern="dd/MM/yyyy" /></small>
                                            </div>
                                            
                                            <p class="mt-2 mb-0 text-dark fs-6">${rev.comment}</p>
                                            
                                            <c:if test="${sessionScope.user == null || sessionScope.user.userID == rev.userID || sessionScope.user.role == 1}">
                                                <div class="mt-3 pt-3 border-top border-secondary border-opacity-25 d-flex justify-content-end gap-2">
                                                    <c:if test="${sessionScope.user == null || sessionScope.user.userID == rev.userID}">
                                                        <button class="btn btn-sm btn-outline-dark border-0 fw-medium" data-bs-toggle="modal" data-bs-target="#editModal${rev.reviewID}">
                                                            <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                                                        </button>
                                                    </c:if>
                                                    <a href="ReviewController?action=delete&reviewId=${rev.reviewID}&productId=${carId}" class="btn btn-sm btn-outline-danger border-0 fw-medium" onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?');">
                                                        <i class="fa-solid fa-trash me-1"></i> Xóa
                                                    </a>
                                                </div>

                                                <div class="modal fade" id="editModal${rev.reviewID}" tabindex="-1" aria-hidden="true">
                                                  <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content border-0 shadow">
                                                      <form action="ReviewController" method="POST">
                                                          <div class="modal-header border-bottom-0 pb-0 pt-4 px-4">
                                                            <h5 class="modal-title fw-bold text-dark">Sửa Đánh Giá</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                          </div>
                                                          
                                                          <div class="modal-body px-4 py-3">
                                                              <input type="hidden" name="action" value="update">
                                                              <input type="hidden" name="reviewId" value="${rev.reviewID}">
                                                              <input type="hidden" name="productId" value="${carId}">
                                                              
                                                              <div class="mb-3">
                                                                  <label class="form-label text-muted small fw-bold">Mức độ hài lòng</label>
                                                                  <select name="rating" class="form-select text-warning fw-bold bg-light border-0 shadow-none p-2">
                                                                      <option value="5" ${rev.rating == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐ Tuyệt vời</option>
                                                                      <option value="4" ${rev.rating == 4 ? 'selected' : ''}>⭐⭐⭐⭐ Rất tốt</option>
                                                                      <option value="3" ${rev.rating == 3 ? 'selected' : ''}>⭐⭐⭐ Hài lòng</option>
                                                                      <option value="2" ${rev.rating == 2 ? 'selected' : ''}>⭐⭐ Tạm được</option>
                                                                      <option value="1" ${rev.rating == 1 ? 'selected' : ''}>⭐ Không hài lòng</option>
                                                                  </select>
                                                              </div>
                                                              
                                                              <div>
                                                                  <label class="form-label text-muted small fw-bold">Nội dung đánh giá</label>
                                                                  <textarea name="comment" class="form-control bg-light border-0 shadow-none p-3" rows="3">${rev.comment}</textarea>
                                                              </div>
                                                          </div>
                                                          
                                                          <div class="modal-footer border-top-0 pt-0 px-4 pb-4">
                                                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                                                            <button type="submit" class="btn btn-danger px-4">Lưu lại</button>
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