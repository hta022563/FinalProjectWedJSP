<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/admin-header.jsp"></jsp:include>

<div class="container my-5">
    <h3 class="text-uppercase border-bottom pb-2">
        <i class="fa-solid fa-tags"></i> Quản lý Khuyến Mãi
    </h3>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center shadow-sm">${errorMessage}</div>
    </c:if>

    <div class="my-4 p-4 bg-light border rounded shadow-sm">
        <form action="PromotionController" method="POST">
            <input type="hidden" name="action" value="add"> 
            <h5 class="mb-3 fw-bold">Thêm Mã Khuyến Mãi Mới</h5>
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Mã Code:</label>
                    <input type="text" name="promoCode" class="form-control" placeholder="VD: SALE50..." required>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Giảm giá (%):</label>
                    <input type="number" name="discountPercent" class="form-control" min="1" max="100" placeholder="%" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Ngày bắt đầu:</label>
                    <input type="date" name="startDate" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Ngày kết thúc:</label>
                    <input type="date" name="endDate" class="form-control" required>
                </div>
                <div class="col-md-1 d-flex align-items-end">
                    <button class="btn btn-primary w-100 fw-bold" type="submit">Thêm</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card shadow-sm border-0">
        <table class="table table-hover table-bordered mb-0">
            <thead class="table-dark text-center">
                <tr>
                    <th style="width: 80px;">ID</th>
                    <th>Mã Code</th>
                    <th>Giảm giá</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th style="width: 200px;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listPromotion}" var="pro">
                    <tr class="text-center align-middle">
                        <td class="text-secondary fw-bold">${pro.promotionID}</td>
                        <td class="fw-bold text-success">${pro.promoCode}</td>
                        <td class="fw-bold text-danger">${pro.discountPercent}%</td>
                        <td>${pro.startDate}</td>
                        <td>${pro.endDate}</td>
                        <td>
                            <button type="button" class="btn btn-warning btn-sm text-dark fw-bold" 
                                    data-bs-toggle="modal" data-bs-target="#editModal${pro.promotionID}">Sửa</button>
                            <a href="PromotionController?action=delete&id=${pro.promotionID}" 
                               class="btn btn-danger btn-sm fw-bold" 
                               onclick="return confirm('Bạn có chắc muốn xóa mã khuyến mãi này?')">Xóa</a>

                            <div class="modal fade" id="editModal${pro.promotionID}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content text-start">
                                        <div class="modal-header bg-warning text-dark">
                                            <h5 class="modal-title fw-bold">Sửa Khuyến Mãi: ${pro.promoCode}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form action="PromotionController" method="POST">
                                            <div class="modal-body">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" value="${pro.promotionID}">
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">Mã Code:</label>
                                                    <input type="text" name="promoCode" class="form-control" value="${pro.promoCode}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Giảm giá (%):</label>
                                                    <input type="number" name="discountPercent" class="form-control" min="1" max="100" value="${pro.discountPercent}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày bắt đầu:</label>
                                                    <input type="date" name="startDate" class="form-control" value="${pro.startDate}" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày kết thúc:</label>
                                                    <input type="date" name="endDate" class="form-control" value="${pro.endDate}" required>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-success fw-bold">Lưu thay đổi</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listPromotion}">
                    <tr><td colspan="6" class="text-center py-4">Chưa có mã khuyến mãi nào.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="mt-5 mb-3 d-flex justify-content-between align-items-center border-top pt-4">
        <h5 class="text-secondary"><i class="fa-solid fa-trash-can"></i> Thùng Rác</h5>
        <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Hiện / Ẩn</button>
    </div>

    <div class="collapse" id="trashSection">
        <table class="table table-sm table-bordered text-center">
            <thead class="table-secondary">
                <tr>
                    <th style="width: 80px;">ID</th>
                    <th>Mã (Đã xóa)</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listDeletedPromotion}" var="delPro">
                    <tr class="align-middle">
                        <td class="text-muted">${delPro.promotionID}</td>
                        <td><del>${delPro.promoCode}</del></td>
                        <td>
                            <a href="PromotionController?action=restore&id=${delPro.promotionID}" 
                               class="btn btn-success btn-sm fw-bold" 
                               onclick="return confirm('Khôi phục mã này?')">Khôi phục</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listDeletedPromotion}">
                    <tr><td colspan="3" class="text-center py-2 text-muted">Thùng rác trống.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>