<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/admin-header.jsp"></jsp:include>

<div class="container my-5">
    <h3 class="text-uppercase border-bottom pb-2">Quản lý Nhà Cung Cấp</h3>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>

    <div class="my-4 p-4 bg-light border rounded shadow-sm">
        <form action="SupplierController" method="POST">
            <input type="hidden" name="action" value="add"> 
            <h5 class="mb-3">Thêm Nhà Cung Cấp Mới</h5>
            
            <div class="row g-3">
                <div class="col-md-4">
                    <input type="text" name="supplierName" class="form-control" placeholder="Tên công ty/hãng..." required>
                </div>
                <div class="col-md-3">
                    <input type="text" name="phone" class="form-control" placeholder="Số điện thoại...">
                </div>
                <div class="col-md-4">
                    <input type="text" name="address" class="form-control" placeholder="Địa chỉ...">
                </div>
                <div class="col-md-1">
                    <button class="btn btn-primary w-100" type="submit">Thêm</button>
                </div>
            </div>
        </form>
    </div>

    <table class="table table-hover table-bordered shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>Mã ID</th>
                <th>Tên Nhà Cung Cấp</th>
                <th>Điện Thoại</th>
                <th>Địa Chỉ</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listSupplier}" var="sup">
                <tr>
                    <td>${sup.supplierID}</td>
                    <td class="fw-bold">${sup.supplierName}</td>
                    <td>${sup.phone}</td>
                    <td>${sup.address}</td>
                    <td>
                        <button type="button" class="btn btn-warning btn-sm text-dark fw-bold" data-bs-toggle="modal" data-bs-target="#editModal${sup.supplierID}">
                            <i class="fa-solid fa-pen-to-square"></i> Sửa
                        </button>
                        
                        <a href="SupplierController?action=delete&id=${sup.supplierID}" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Bạn có chắc muốn xóa nhà cung cấp này?')">
                           <i class="fa-solid fa-trash"></i> Xóa
                        </a>

                        <div class="modal fade" id="editModal${sup.supplierID}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header bg-warning text-dark">
                                        <h5 class="modal-title fw-bold">Sửa Thông Tin: ${sup.supplierName}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="SupplierController" method="POST">
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${sup.supplierID}">
                                            
                                            <div class="mb-3">
                                                <label class="form-label">Tên Nhà Cung Cấp:</label>
                                                <input type="text" name="supplierName" class="form-control" value="${sup.supplierName}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Điện Thoại:</label>
                                                <input type="text" name="phone" class="form-control" value="${sup.phone}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Địa Chỉ:</label>
                                                <input type="text" name="address" class="form-control" value="${sup.address}">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div> </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listSupplier}">
                 <tr><td colspan="5" class="text-center py-3">Không có nhà cung cấp nào.</td></tr>
            </c:if>
        </tbody>
    </table>

    <div class="mt-5 mb-3 d-flex justify-content-between align-items-center border-top pt-4">
        <h5 class="text-secondary"><i class="fa-solid fa-trash-can"></i> Thùng Rác (Đã xóa)</h5>
        <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">
            <i class="fa-solid fa-eye"></i> Hiện / Ẩn
        </button>
    </div>

    <div class="collapse" id="trashSection">
        <table class="table table-bordered text-muted table-sm">
            <thead class="table-secondary">
                <tr>
                    <th>ID</th>
                    <th>Tên (Đã xóa)</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listDeletedSupplier}" var="delSup">
                    <tr>
                        <td>${delSup.supplierID}</td>
                        <td><del>${delSup.supplierName}</del></td>
                        <td>
                            <a href="SupplierController?action=restore&id=${delSup.supplierID}" 
                               class="btn btn-success btn-sm" 
                               onclick="return confirm('Khôi phục nhà cung cấp này?')">
                               <i class="fa-solid fa-rotate-left"></i> Khôi phục
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listDeletedSupplier}">
                    <tr>
                        <td colspan="3" class="text-center font-italic py-2">Thùng rác trống.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</div> <jsp:include page="includes/admin-footer.jsp"></jsp:include>