<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <h3 class="text-uppercase border-bottom pb-2">
        <i class="fa-solid fa-credit-card"></i> Quản lý Phương thức thanh toán
    </h3>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center shadow-sm">
            <i class="fa-solid fa-triangle-exclamation"></i> ${errorMessage}
        </div>
    </c:if>

    <div class="my-4 p-4 bg-light border rounded shadow-sm">
        <form action="PaymentMethodController" method="POST">
            <input type="hidden" name="action" value="add"> 
            <label class="form-label fw-bold">Thêm phương thức thanh toán mới:</label>
            <div class="input-group" style="max-width: 600px;">
                <input type="text" name="methodName" class="form-control" placeholder="Tiền mặt, VNPay, Thẻ tín dụng..." required>
                <button class="btn btn-primary fw-bold" type="submit">
                    <i class="fa-solid fa-plus"></i> Thêm mới
                </button>
            </div>
        </form>
    </div>

    <div class="card shadow-sm border-0">
        <table class="table table-hover mb-0">
            <thead class="table-dark">
                <tr>
                    <th style="width: 100px;">Mã ID</th>
                    <th>Tên phương thức</th>
                    <th style="width: 200px;" class="text-center">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listPaymentMethod}" var="pm">
                    <tr>
                        <td class="align-middle text-secondary fw-bold">${pm.methodID}</td>
                        <td class="align-middle fw-bold">${pm.methodName}</td>
                        <td class="text-center">
                            <button type="button" class="btn btn-warning btn-sm text-dark fw-bold" 
                                    data-bs-toggle="modal" data-bs-target="#editModal${pm.methodID}">
                                <i class="fa-solid fa-pen"></i> Sửa
                            </button>
                            
                            <a href="PaymentMethodController?action=delete&id=${pm.methodID}" 
                               class="btn btn-danger btn-sm fw-bold" 
                               onclick="return confirm('Bạn có chắc muốn ẩn phương thức này?')">
                               <i class="fa-solid fa-trash"></i> Xóa
                            </a>

                            <div class="modal fade" id="editModal${pm.methodID}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header bg-warning text-dark">
                                            <h5 class="modal-title fw-bold">Sửa Phương Thức: ${pm.methodName}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="PaymentMethodController" method="POST">
                                            <div class="modal-body text-start">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" value="${pm.methodID}">
                                                
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Tên phương thức mới:</label>
                                                    <input type="text" name="methodName" class="form-control" value="${pm.methodName}" required>
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
                <c:if test="${empty listPaymentMethod}">
                    <tr>
                        <td colspan="3" class="text-center py-4 text-muted font-italic">Không có phương thức nào đang hoạt động.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="mt-5 mb-3 d-flex justify-content-between align-items-center border-top pt-4">
        <h5 class="text-secondary"><i class="fa-solid fa-trash-arrow-up"></i> Thùng Rác (Đã ẩn)</h5>
        <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">
            <i class="fa-solid fa-eye"></i> Hiện / Ẩn Thùng Rác
        </button>
    </div>

    <div class="collapse" id="trashSection">
        <div class="card card-body bg-light border-0">
            <table class="table table-sm table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th>Tên (Đã ẩn)</th>
                        <th style="width: 150px;" class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listDeletedPaymentMethod}" var="delPM">
                        <tr>
                            <td class="text-muted">${delPM.methodID}</td>
                            <td><del class="text-muted">${delPM.methodName}</del></td>
                            <td class="text-center">
                                <a href="PaymentMethodController?action=restore&id=${delPM.methodID}" 
                                   class="btn btn-success btn-sm fw-bold" 
                                   onclick="return confirm('Khôi phục phương thức này?')">
                                   <i class="fa-solid fa-rotate-left"></i> Khôi phục
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listDeletedPaymentMethod}">
                        <tr>
                            <td colspan="3" class="text-center py-2 text-muted font-italic small">Thùng rác trống.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</div>

<jsp:include page="includes/footer.jsp"></jsp:include>