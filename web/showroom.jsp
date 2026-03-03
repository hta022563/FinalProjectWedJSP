<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

    <div class="container my-5">
        <h3>Quản lý Chi nhánh Showroom</h3>

        <div class="card p-4 bg-light my-4 shadow-sm">
            <form action="ShowroomController" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="row g-3">
                    <div class="col-md-3"><input type="text" name="name" class="form-control" placeholder="Tên chi nhánh..." required></div>
                    <div class="col-md-5"><input type="text" name="address" class="form-control" placeholder="Địa chỉ..." required></div>
                    <div class="col-md-3"><input type="text" name="hotline" class="form-control" placeholder="Hotline..." required></div>
                    <div class="col-md-1"><button class="btn btn-primary w-100" type="submit">Thêm</button></div>
                </div>
            </form>
        </div>

        <table class="table table-hover table-bordered shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>ID</th><th>Tên Chi Nhánh</th><th>Địa Chỉ</th><th>Hotline</th><th>Hành động</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${listShowroom}" var="s">
                <tr>
                    <td>${s.showroomID}</td><td class="fw-bold">${s.showroomName}</td>
                    <td>${s.address}</td><td>${s.hotline}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#edit${s.showroomID}">Sửa</button>
                        <a href="ShowroomController?action=delete&id=${s.showroomID}" class="btn btn-danger btn-sm" onclick="return confirm('Xóa chi nhánh này?')">Xóa</a>

                        <div class="modal fade" id="edit${s.showroomID}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog"><div class="modal-content">
                                    <form action="ShowroomController" method="POST">
                                        <div class="modal-header bg-warning"><h5>Sửa Chi Nhánh</h5></div>
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${s.showroomID}">
                                            <div class="mb-3"><label>Tên:</label><input type="text" name="name" class="form-control" value="${s.showroomName}" required></div>
                                            <div class="mb-3"><label>Địa chỉ:</label><input type="text" name="address" class="form-control" value="${s.address}" required></div>
                                            <div class="mb-3"><label>Hotline:</label><input type="text" name="hotline" class="form-control" value="${s.hotline}" required></div>
                                        </div>
                                        <div class="modal-footer"><button type="submit" class="btn btn-success">Lưu</button></div>
                                    </form>
                                </div></div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

  <div class="mt-5 mb-3 d-flex justify-content-between align-items-center border-top pt-4">
        <h5 class="text-secondary"><i class="fa-solid fa-trash-can"></i> Thùng Rác (Đã xóa)</h5>
        <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">
            <i class="fa-solid fa-eye"></i> Hiện / Ẩn
        </button>
    </div>

    <div class="collapse" id="trashSection">
        <table class="table table-sm table-bordered text-center shadow-sm">
            <thead class="table-secondary">
                <tr>
                    <th style="width: 80px;">ID</th>
                    <th>Tên Chi Nhánh (Đã xóa)</th>
                    <th style="width: 150px;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listDeleted}" var="delShowroom">
                    <tr class="align-middle">
                        <td class="text-muted">${delShowroom.showroomID}</td>
                        <td><del class="text-muted">${delShowroom.showroomName}</del></td>
                        <td>
                            <a href="ShowroomController?action=restore&id=${delShowroom.showroomID}" 
                               class="btn btn-success btn-sm fw-bold" 
                               onclick="return confirm('Khôi phục chi nhánh này?')">
                               <i class="fa-solid fa-rotate-left"></i> Khôi phục
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty listDeleted}">
                    <tr><td colspan="3" class="text-center py-3 text-muted font-italic">Thùng rác hiện đang trống.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>