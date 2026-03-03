<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <style>
        /* Nền tổng thể sáng và hiện đại */
        body {
            background-color: #f4f7f6;
        }

        /* Hiệu ứng chữ màu Gradient chuyển động */
        .gradient-text {
            background: linear-gradient(45deg, #ff6b6b, #feca57, #1dd1a1, #5f27cd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-size: 300% 300%;
            animation: gradientUI 5s ease infinite;
        }
        @keyframes gradientUI {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        /* Hiệu ứng nổi bật khi rê chuột vào hàng của bảng */
        .table-row-hover {
            transition: all 0.3s ease;
        }
        .table-row-hover:hover {
            background-color: #ffffff !important;
            transform: scale(1.01);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            border-radius: 10px;
        }

        /* Nút bấm Gradient siêu mượt */
        .btn-gradient {
            background: linear-gradient(45deg, #dce4e4 0%, #81c0f3 100%);
            border: none;
            color: #2b2b2b;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-gradient:hover {
            transform: translateY(-2px);

            color: #000;
        }

        /* Thẻ Card hiệu ứng kính (Glassmorphism) */
        .glass-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.5);
            border-radius: 15px;
        }

    </style>

    <div class="container-fluid py-4">

        <div class="card border-0 shadow-lg mb-4 rounded-4 overflow-hidden position-relative">
            <img src="https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80" 
                 class="card-img" alt="Banner" style="height: 200px; object-fit: cover; filter: brightness(0.4);">
            <div class="card-img-overlay d-flex flex-column justify-content-center align-items-center text-center">
                <h1 class="fw-bolder display-5 gradient-text text-uppercase" style="text-shadow: 2px 2px 10px rgba(0,0,0,0.5);">Quản Lý Danh Mục</h1>
                <p class="text-light fs-5 fw-light">Sắp xếp hệ thống sinh thái F-AUTO</p>
            </div>
        </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 rounded-4" role="alert">
            <i class="fa-solid fa-triangle-exclamation fa-beat me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card glass-card shadow-sm mb-5">
        <div class="card-body p-4">
            <form action="CategoryController" method="POST" class="row align-items-center gx-3">
                <input type="hidden" name="action" value="add"> 

                <div class="col-auto">
                    <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center shadow" style="width: 45px; height: 45px;">
                        <i class="fa-solid fa-folder-plus fs-5"></i>
                    </div>
                </div>
                <div class="col-md-6">
                    <input type="text" name="categoryName" class="form-control form-control-lg border-primary shadow-sm" placeholder="Nhập tên danh mục (VD: Xe Điện, Phụ Kiện...)" required>
                </div>
                <div class="col-auto">
                    <button class="btn btn-gradient btn-lg px-5" type="submit">
                        Thêm mới
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card glass-card shadow-lg border-0 mb-5 overflow-hidden">
        <div class="card-header bg-dark bg-gradient py-3 border-bottom-0">
            <h5 class="m-0 fw-bold text-white"><i class="fa-solid fa-list text-warning me-2"></i>DANH MỤC HIỆN CÓ</h5>
        </div>
        <div class="table-responsive p-2">
            <table class="table align-middle text-center mb-0 border-white">
                <thead class="text-secondary">
                    <tr>
                        <th style="width: 15%;">Mã ID</th>
                        <th class="text-start" style="width: 55%;">Tên danh mục</th>
                        <th style="width: 30%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listCategory}" var="cat">
                        <tr class="table-row-hover">
                            <td>
                                <span class="badge bg-secondary bg-gradient rounded-pill px-3 py-2 shadow-sm fs-6">
                                    <i class="fa-solid fa-hashtag me-1"></i>${cat.categoryID}
                                </span>
                            </td>
                            <td class="text-start fw-bold fs-5 text-dark">
                                <c:choose>
                                    <c:when test="${cat.categoryName.toLowerCase().contains('xe')}">
                                        <i class="fa-solid fa-car-side text-info me-2"></i>
                                    </c:when>
                                    <c:when test="${cat.categoryName.toLowerCase().contains('phụ kiện')}">
                                        <i class="fa-solid fa-screwdriver-wrench text-warning me-2"></i>
                                    </c:when>
                                    <c:when test="${cat.categoryName.toLowerCase().contains('lốp') || cat.categoryName.toLowerCase().contains('mâm')}">
                                        <i class="fa-solid fa-circle-dot text-secondary me-2"></i>
                                    </c:when>
                                    <c:when test="${cat.categoryName.toLowerCase().contains('nội thất')}">
                                        <i class="fa-solid fa-couch text-success me-2"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-box-open text-muted me-2"></i>
                                    </c:otherwise>
                                </c:choose>
                                ${cat.categoryName}
                            </td>
                            <td>
                                <button type="button" class="btn btn-warning text-dark fw-bold btn-sm shadow-sm me-2 rounded-3" data-bs-toggle="modal" data-bs-target="#editModal${cat.categoryID}">
                                    <i class="fa-solid fa-pen-nib"></i> Sửa đổi
                                </button>

                                <a href="CategoryController?action=delete&id=${cat.categoryID}" 
                                   class="btn btn-danger bg-gradient btn-sm fw-bold shadow-sm rounded-3" 
                                   onclick="return confirm('Chuyển danh mục [${cat.categoryName}] vào thùng rác?')">
                                    <i class="fa-solid fa-trash-can"></i> Gỡ bỏ
                                </a>

                                <div class="modal fade" id="editModal${cat.categoryID}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                                            <form action="CategoryController" method="POST">
                                                <div class="modal-header bg-warning bg-gradient border-bottom-0">
                                                    <h5 class="modal-title fw-bold text-dark"><i class="fa-solid fa-pen-to-square me-2"></i>Chỉnh sửa Danh mục</h5>
                                                    <button type="button" class="btn-close bg-white rounded-circle p-2" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body text-start p-4">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="id" value="${cat.categoryID}">

                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold text-muted small text-uppercase">Mã Danh Mục</label>
                                                        <input type="text" class="form-control bg-light border-0 fw-bold text-primary" value="# ${cat.categoryID}" disabled>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold text-dark">Tên danh mục mới <span class="text-danger">*</span></label>
                                                        <input type="text" name="newCategoryName" class="form-control form-control-lg border-warning shadow-sm" value="${cat.categoryName}" required>
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-top-0 bg-light">
                                                    <button type="button" class="btn btn-outline-secondary fw-bold rounded-pill px-4" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-warning fw-bold rounded-pill px-4 shadow-sm"><i class="fa-solid fa-floppy-disk me-1"></i> Cập nhật ngay</button>
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
        </div>
    </div>

    <div class="card glass-card shadow-sm border-0 border-start border-danger border-5">
        <div class="card-header bg-transparent py-3 d-flex justify-content-between align-items-center">
            <h5 class="m-0 fw-bold text-danger"><i class="fa-solid fa-dumpster-fire me-2"></i>THÙNG RÁC</h5>
            <button class="btn btn-danger bg-gradient btn-sm fw-bold rounded-pill px-3 shadow" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">
                <i class="fa-solid fa-eye-slash me-1"></i> Ẩn / Hiện
            </button>
        </div>

        <div class="collapse" id="trashSection">
            <div class="card-body p-2">
                <table class="table align-middle text-center mb-0">
                    <thead class="text-muted">
                        <tr>
                            <th style="width: 15%;">Mã ID</th>
                            <th class="text-start" style="width: 55%;">Tên danh mục (Đã xóa)</th>
                            <th style="width: 30%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listDeleted}" var="delCat">
                            <tr class="table-row-hover">
                                <td><span class="badge bg-secondary rounded-pill px-3 py-2"># ${delCat.categoryID}</span></td>
                                <td class="text-start text-muted"><del class="fw-bold">${delCat.categoryName}</del></td>
                                <td>
                                    <a href="CategoryController?action=restore&id=${delCat.categoryID}" 
                                       class="btn btn-success bg-gradient btn-sm fw-bold rounded-3 shadow-sm" 
                                       onclick="return confirm('Khôi phục danh mục [${delCat.categoryName}]?')">
                                        <i class="fa-solid fa-trash-arrow-up me-1"></i> Khôi phục
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listDeleted}">
                            <tr>
                                <td colspan="3" class="text-center py-5 text-muted">
                                    <div class="display-1 opacity-25 mb-3"><i class="fa-solid fa-seedling"></i></div>
                                    <h5 class="fw-light m-0">Môi trường sạch sẽ, không có rác!</h5>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>