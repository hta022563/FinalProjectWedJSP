<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;700;900&family=JetBrains+Mono:wght@700&display=swap" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f5f7ff 0%, #e8eaff 100%); color: #2d3436; font-family: 'Inter', sans-serif; }
        .banner-container { height: 280px; border-radius: 24px; overflow: hidden; position: relative; box-shadow: 0 20px 40px rgba(108, 92, 231, 0.15); }
        .banner-img { width: 100%; height: 100%; object-fit: cover; background-image: url('IMG/Cha.jpg'); background-size: cover; background-position: center; filter: brightness(0.6); }
        .banner-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(30, 30, 80, 0.6) 100%); display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; }
        .cat-main-title { background: linear-gradient(45deg, #6c5ce7, #a29bfe); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900; text-transform: uppercase; letter-spacing: 3px; font-size: 3.5rem; margin-bottom: 5px; font-family: 'Be Vietnam Pro', sans-serif !important; text-shadow: 0 10px 20px rgba(108, 92, 231, 0.3); }
        .aero-card { background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.6); border-radius: 20px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05); }
        .aero-input { background: #ffffff !important; border: 1px solid #d1d9ff !important; border-radius: 14px !important; padding: 12px 16px; transition: all 0.3s ease; }
        .aero-input:focus { border-color: #6c5ce7 !important; box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1) !important; }
        .btn-cat-gradient { background: linear-gradient(135deg, #6c5ce7 0%, #a29bfe 100%); border: none; color: #fff; font-weight: 700; border-radius: 14px; padding: 14px 30px; box-shadow: 0 8px 20px rgba(108, 92, 231, 0.3); transition: all 0.3s ease; text-transform: uppercase; letter-spacing: 1px; }
        .btn-cat-gradient:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(108, 92, 231, 0.5); }
        .aero-table thead th { background: #f0f2ff; color: #5f27cd; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; padding: 20px; border: none; }
        .aero-table td { padding: 25px 20px; border-bottom: 1px solid #eef0ff; }
        .aero-table tr:hover { background-color: rgba(108, 92, 231, 0.03); }
        .id-tag { background: #f0f2ff; color: #6c5ce7; padding: 6px 14px; border-radius: 10px; font-weight: 800; font-family: 'JetBrains Mono', monospace; }
        .icon-box { width: 45px; height: 45px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(108, 92, 231, 0.1); color: #6c5ce7; font-size: 1.2rem; }
    </style>

    <div class="container-fluid py-5 px-5">

        <div class="banner-container mb-5">
            <div class="banner-img"></div>
            <div class="banner-overlay">
                <h1 class="cat-main-title">Phân Loại Hệ Sinh Thái</h1>
                <p class="text-white-50 fs-5 fw-light m-0">F-AUTO | Quản trị cấu trúc danh mục sản phẩm chiến lược</p>
                <div class="mt-3 badge rounded-pill px-4 py-2 border border-primary border-opacity-25" style="background: rgba(108, 92, 231, 0.15) !important; backdrop-filter: blur(15px); border: 1px solid rgba(162, 155, 254, 0.2) !important; box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);">
                    <i class="fa-solid fa-clock-rotate-left me-2" style="color: #a29bfe;"></i> 
                    <span id="digital-clock" class="fw-bold" style="color: #ffffff; text-shadow: 0 0 10px rgba(108, 92, 231, 0.8); letter-spacing: 2px; font-family: 'JetBrains Mono', monospace;">00:00:00</span>
                </div>
            </div>
        </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger border-0 rounded-4 shadow-sm mb-4"><i class="fa-solid fa-layer-group me-2"></i> ${errorMessage}</div>
    </c:if>

    <div class="aero-card p-4 mb-5 border-start border-primary border-5">
        <h5 class="fw-bold mb-4 d-flex align-items-center" style="color: #6c5ce7;">
            <span class="bg-primary bg-opacity-10 p-2 rounded-3 me-3"><i class="fa-solid fa-folder-plus text-primary"></i></span> Khởi tạo phân loại hàng hóa mới
        </h5>
        <form action="MainController" method="POST">
            <input type="hidden" name="target" value="Category">
            <input type="hidden" name="action" value="add"> 
            <div class="row g-4 align-items-end">
                <div class="col-md-9">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Tên danh mục (VD: Xe Sedan, Phụ kiện nội thất...)</label>
                    <input type="text" name="categoryName" class="form-control aero-input" placeholder="Nhập tên danh mục..." required>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-cat-gradient w-100 py-3 shadow-sm" type="submit"><i class="fa-solid fa-plus me-2"></i> THIẾT LẬP</button>
                </div>
            </div>
        </form>
    </div>

    <div class="aero-card overflow-hidden shadow-lg border-0 mb-5">
        <div class="table-responsive">
            <table class="table aero-table align-middle text-center mb-0">
                <thead>
                    <tr><th style="width: 15%;">Mã Định Danh</th> <th class="text-start">Tên Danh Mục Hệ Thống</th> <th style="width: 25%;">Trạng Thái</th> <th style="width: 20%;">Thao Tác</th></tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listCategory}" var="cat">
                        <tr>
                            <td><span class="id-tag">#CAT-${cat.categoryID}</span></td>
                            <td class="text-start fw-bold">
                                <div class="d-flex align-items-center">
                                    <div class="icon-box me-3">
                                        <c:choose>
                                            <c:when test="${cat.categoryName.toLowerCase().contains('xe')}"><i class="fa-solid fa-car-side"></i></c:when>
                                            <c:when test="${cat.categoryName.toLowerCase().contains('phụ kiện')}"><i class="fa-solid fa-screwdriver-wrench"></i></c:when>
                                            <c:otherwise><i class="fa-solid fa-layer-group"></i></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="text-dark fs-5">${cat.categoryName}</span>
                                </div>
                            </td>
                            <td><span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 fw-bold"><i class="fa-solid fa-check-double me-1"></i> ACTIVE</span></td>
                            <td>
                                <button type="button" class="btn btn-outline-primary btn-sm rounded-pill px-3 me-2 border-0 fw-bold" data-bs-toggle="modal" data-bs-target="#editModalCat${cat.categoryID}">SỬA</button>
                                <a href="MainController?target=Category&action=delete&id=${cat.categoryID}" class="btn btn-outline-danger btn-sm rounded-pill px-3 border-0 fw-bold" onclick="return confirm('Tạm ẩn danh mục [${cat.categoryName}]?')">XÓA</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-5 mb-4 d-flex justify-content-between align-items-center border-top border-primary border-opacity-10 pt-4">
        <h5 class="fw-bold text-muted text-uppercase" style="letter-spacing: 2px;"><i class="fa-solid fa-box-archive me-2"></i> Lưu trữ phân loại</h5>
        <button class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Mở Archive</button>
    </div>

    <div class="collapse" id="trashSection">
        <div class="aero-card p-0 overflow-hidden border-danger border-opacity-10 mt-3">
            <table class="table aero-table align-middle text-center mb-0">
                <thead class="bg-danger bg-opacity-10">
                    <tr><th style="width: 15%;">Mã ID</th> <th class="text-start">Danh mục đã ẩn</th> <th style="width: 20%;">Hành động</th></tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listDeleted}" var="delCat">
                        <tr>
                            <td><span class="id-tag bg-secondary bg-opacity-10 text-muted">#${delCat.categoryID}</span></td>
                            <td class="text-start text-muted"><del class="fw-bold">${delCat.categoryName}</del></td>
                            <td>
                                <a href="MainController?target=Category&action=restore&id=${delCat.categoryID}" class="btn btn-outline-success btn-sm rounded-pill px-4 border-0 fw-bold shadow-sm">
                                    <i class="fa-solid fa-rotate-left"></i> KHÔI PHỤC
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:forEach items="${listCategory}" var="cat">
    <div class="modal fade" id="editModalCat${cat.categoryID}" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content aero-card border-0 p-4" style="background: rgba(255,255,255,0.98);">
                <form action="MainController" method="POST">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="fw-bold fs-4 text-primary">Hiệu chỉnh cấu trúc</h5>
                        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-start">
                        <input type="hidden" name="target" value="Category">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${cat.categoryID}">
                        <div class="mb-4">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Tên danh mục mới</label>
                            <input type="text" name="newCategoryName" class="form-control aero-input fw-bold" value="${cat.categoryName}" required>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">ĐÓNG</button>
                        <button type="submit" class="btn btn-cat-gradient px-5 shadow-sm">CẬP NHẬT NGAY</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<script>
    function updateClock() {
        const now = new Date();
        const time = now.getHours().toString().padStart(2, '0') + ":" +
                now.getMinutes().toString().padStart(2, '0') + ":" +
                now.getSeconds().toString().padStart(2, '0');
        const clockEl = document.getElementById('digital-clock');
        if (clockEl)
            clockEl.innerText = time;
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>