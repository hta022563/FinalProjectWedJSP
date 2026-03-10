<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <h2 class="fw-bold mb-4 border-bottom pb-2 text-uppercase luxury-logo">Tin tức & Sự kiện</h2>
    
    <%-- DANH SÁCH BÀI VIẾT --%>
    <div class="row">
        <c:forEach items="${listN}" var="n">
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100 border-0 overflow-hidden" style="border-radius: 15px;">
                    <div class="row g-0 h-100">
                        <div class="col-md-5">
                            <img src="${n.thumbnail}" class="img-fluid h-100 w-100" style="object-fit: cover; min-height: 200px;" alt="${n.title}" onerror="this.src='https://via.placeholder.com/400x300?text=F-AUTO+News'">
                        </div>
                        <div class="col-md-7">
                            <div class="card-body d-flex flex-column h-100">
                                <small class="text-muted">
                                    <i class="fa-regular fa-calendar-check"></i> 
                                    <fmt:formatDate value="${n.publishDate}" pattern="dd/MM/yyyy"/>
                                </small>
                                <h5 class="card-title fw-bold mt-2 text-dark">${n.title}</h5>
                                <p class="card-text text-muted mb-3" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">
                                    ${n.content}
                                </p>
                                
                                <div class="mt-auto">
                                    <a href="${n.externalLink}" target="_blank" class="btn btn-outline-warning btn-sm fw-bold">
                                        Đọc tiếp <i class="fa-solid fa-arrow-up-right-from-square ms-1"></i>
                                    </a>
                                    
                                    <%-- NÚT XÓA/SỬA CHỈ HIỂN THỊ KHI LÀ ADMIN (role == 1) --%>
                                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                                        <div class="mt-2 pt-2 border-top">
                                            <a href="NewsController?action=edit&id=${n.newsID}#admin-form" class="btn btn-primary btn-sm"><i class="fa-solid fa-pen"></i> Sửa</a>
                                            <a href="NewsController?action=delete&id=${n.newsID}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa bài báo này?');"><i class="fa-solid fa-trash"></i> Xóa</a>
                                        </div>
                                    </c:if>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <%-- FORM THÊM/SỬA TIN TỨC CHỈ HIỂN THỊ KHI LÀ ADMIN --%>
    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
        <hr class="my-5 border-2 border-dark">
        <div class="card shadow border-0" id="admin-form">
            <div class="card-header bg-dark text-warning fw-bold fs-5 text-uppercase">
                <i class="fa-solid fa-newspaper"></i> ${empty editNews ? 'THÊM TIN TỨC MỚI' : 'CẬP NHẬT TIN TỨC'}
            </div>
            <div class="card-body bg-light">
                <form action="NewsController" method="POST">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="newsID" value="${editNews.newsID}">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Tiêu đề bài báo</label>
                            <input type="text" name="title" class="form-control" value="${editNews.title}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Link Ảnh (VD: IMG/xe.jpg hoặc URL)</label>
                            <input type="text" name="thumbnail" class="form-control" value="${editNews.thumbnail}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Link Báo Gốc (VNExpress, AutoPro...)</label>
                        <input type="text" name="externalLink" class="form-control" value="${editNews.externalLink}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Nội dung tóm tắt hiển thị trên web</label>
                        <textarea name="content" class="form-control" rows="4" required>${editNews.content}</textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <c:if test="${not empty editNews}">
                            <a href="NewsController" class="btn btn-secondary fw-bold">Hủy Sửa</a>
                        </c:if>
                        <button type="submit" class="btn btn-warning fw-bold text-dark">
                            <i class="fa-solid fa-floppy-disk"></i> LƯU THÔNG TIN
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>