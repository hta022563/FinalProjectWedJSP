<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

    <div class="container my-5">
        <h3 class="text-uppercase border-bottom pb-2">Quản lý danh mục</h3>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">
            ${errorMessage}
        </div>
    </c:if>
    <div class="my-4 p-3 bg-light border rounded">
        <form action="CategoryController" method="POST">
            <input type="hidden" name="action" value="add"> 

            <label class="form-label fw-bold">Thêm danh mục mới:</label>
            <div class="input-group" style="width: 500px;">
                <input type="text" name="categoryName" class="form-control" placeholder="Tên danh mục..." required>
                <button class="btn btn-primary" type="submit">Thêm mới</button>
            </div>
        </form>
    </div>

    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Mã ID</th>
                <th>Tên danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listCategory}" var="cat">
                <tr>
                    <td>${cat.categoryID}</td>
                    <td>${cat.categoryName}</td>
                   <td>
                        <button type="button" class="btn btn-warning btn-sm text-white" data-bs-toggle="modal" data-bs-target="#editModal${cat.categoryID}">Sửa</button>
                        
                        <a href="CategoryController?action=delete&id=${cat.categoryID}" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</a>

                        <div class="modal fade" id="editModal${cat.categoryID}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title">Sửa Danh Mục</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="CategoryController" method="POST">
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${cat.categoryID}">
                                            
                                            <div class="mb-3">
                                                <label class="form-label fw-bold">Tên danh mục mới:</label>
                                                <input type="text" name="newCategoryName" class="form-control" value="${cat.categoryName}" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </td>
                    
                </tr>
            </c:forEach>
        </tbody>
    </table>
        <div class="mt-5 mb-3 d-flex justify-content-between align-items-center border-top pt-4">
        <h4 class="text-secondary"><i class="fa-solid fa-trash-can"></i> Thùng Rác</h4>
        <button class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">
            <i class="fa-solid fa-eye"></i> Hiện / Ẩn Thùng Rác
        </button>
    </div>

    <div class="collapse" id="trashSection">
        <table class="table table-bordered text-muted">
            <thead class="table-secondary">
                <tr>
                    <th>Mã ID</th>
                    <th>Tên danh mục (Đã xóa)</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listDeleted}" var="delCat">
                    <tr>
                        <td>${delCat.categoryID}</td>
                        <td><del>${delCat.categoryName}</del></td>
                        <td>
                            <a href="CategoryController?action=restore&id=${delCat.categoryID}" 
                               class="btn btn-success btn-sm" 
                               onclick="return confirm('Bạn muốn khôi phục danh mục này?')">
                               <i class="fa-solid fa-rotate-left"></i> Khôi phục
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty listDeleted}">
                    <tr>
                        <td colspan="3" class="text-center font-italic">Thùng rác hiện đang trống.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>