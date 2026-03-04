<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

<style>
    /* Nền tổng thể: Trắng sứ pha ánh xanh Sapphire nhạt */
    body { 
        background: linear-gradient(135deg, #f0f7ff 0%, #e2eeff 100%);
        color: #2d3436;
        font-family: 'Inter', system-ui, -apple-system, sans-serif;
    }

    /* BANNER CINEMATIC - Porsche Modern Blue */
    .banner-container {
        height: 250px; border-radius: 24px; overflow: hidden; position: relative;
        box-shadow: 0 20px 40px rgba(0, 210, 255, 0.15);
    }
    .banner-img {
        width: 100%; height: 100%; object-fit: cover;
        background-image: url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
        background-size: cover; background-position: center; filter: brightness(0.55);
    }
    .banner-overlay {
        position: absolute; top: 0; left: 0; width: 100%; height: 100%;
        background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(0, 58, 123, 0.7) 100%);
        display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;
    }
    .supplier-main-title {
        color: #00d2ff; /* Màu Cyan đặc trưng */
        font-weight: 900; text-transform: uppercase; letter-spacing: 2px;
        font-size: 3rem; margin-bottom: 5px;
        text-shadow: 0 5px 15px rgba(0, 210, 255, 0.4);
    }

    /* Thẻ Aero Card Glassmorphism Blue */
    .aero-card {
        background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(20px);
        border: 1px solid rgba(0, 210, 255, 0.1); border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
    }

    /* Input & Button phong cách Modern Blue */
    .aero-input {
        background: #ffffff !important; border: 1px solid #cce5ff !important;
        border-radius: 14px !important; padding: 12px 16px; transition: all 0.3s ease;
    }
    .aero-input:focus { border-color: #00d2ff !important; box-shadow: 0 0 0 4px rgba(0, 210, 255, 0.1) !important; }

    .btn-supplier-gradient {
        background: linear-gradient(135deg, #00d2ff 0%, #3a7bd5 100%);
        border: none; color: #fff; font-weight: 700; border-radius: 14px; padding: 14px 30px;
        box-shadow: 0 8px 20px rgba(0, 210, 255, 0.2); transition: all 0.3s ease;
        text-transform: uppercase; letter-spacing: 1px;
    }
    .btn-supplier-gradient:hover { transform: translateY(-2px); box-shadow: 0 12px 25px rgba(0, 210, 255, 0.3); }

    /* Bảng dữ liệu Premium Blue */
    .aero-table thead th {
        background: #f0f7ff; color: #3a7bd5; font-size: 0.75rem;
        text-transform: uppercase; letter-spacing: 1px; padding: 20px; border: none;
    }
    .aero-table td { padding: 25px 20px; border-bottom: 1px solid #e1efff; }
    .aero-table tr:hover { background-color: rgba(0, 210, 255, 0.03); }

    .id-tag {
        background: #e1f5fe; color: #0288d1; padding: 6px 14px; border-radius: 10px;
        font-weight: 800; font-family: 'JetBrains Mono', monospace;
    }
</style>

<div class="container-fluid py-5 px-5">
    
    <div class="banner-container mb-5">
        <div class="banner-img"></div>
        <div class="banner-overlay">
            <h1 class="supplier-main-title">Hệ Thống Nhà Cung Cấp</h1>
            <p class="text-white-50 fs-5 fw-light m-0">F-AUTO | Quản trị mạng lưới đối tác chiến lược toàn cầu</p>
            
         <div class="mt-3 badge rounded-pill px-4 py-2 border border-info border-opacity-25 shadow-lg" 
     style="background: rgba(0, 184, 212, 0.15) !important; 
            backdrop-filter: blur(15px); 
            border: 1px solid rgba(0, 229, 255, 0.3) !important;
            box-shadow: 0 8px 32px 0 rgba(0, 184, 212, 0.3);">
    
    <i class="fa-solid fa-truck-fast me-2" style="color: #00e5ff;"></i> 
    
    <span id="digital-clock" class="fw-bold" 
          style="color: #ffffff; 
                 text-shadow: 0 0 12px rgba(0, 229, 255, 0.8); 
                 letter-spacing: 2px; 
                 font-family: 'JetBrains Mono', monospace;">
        00:00:00
    </span>
</div>
        </div>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger border-0 rounded-4 shadow-sm mb-4">
            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
        </div>
    </c:if>

    <div class="aero-card p-4 mb-5 border-start border-info border-5">
        <h5 class="fw-bold mb-4 d-flex align-items-center" style="color: #3a7bd5;">
            <span class="bg-info bg-opacity-10 p-2 rounded-3 me-3"><i class="fa-solid fa-building-shield text-info"></i></span>
            Thiết lập đối tác cung ứng mới
        </h5>
        <form action="SupplierController" method="POST">
            <input type="hidden" name="action" value="add"> 
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Tên doanh nghiệp</label>
                    <input type="text" name="supplierName" class="form-control aero-input" placeholder="VD: TOYOTA MOTOR..." required>
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Đường dây nóng</label>
                    <input type="text" name="phone" class="form-control aero-input" placeholder="Số điện thoại...">
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Trụ sở chính</label>
                    <input type="text" name="address" class="form-control aero-input" placeholder="Địa chỉ văn phòng...">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-supplier-gradient w-100 py-3" type="submit">ĐĂNG KÝ</button>
                </div>
            </div>
        </form>
    </div>

    <div class="aero-card overflow-hidden shadow-lg border-0 mb-5">
        <div class="table-responsive">
            <table class="table aero-table align-middle text-center mb-0">
                <thead>
                    <tr>
                        <th style="width: 10%;">Mã ID</th>
                        <th class="text-start" style="width: 35%;">Đối Tác Cung Ứng</th>
                        <th style="width: 20%;">Liên Hệ</th>
                        <th style="width: 20%;">Khu Vực</th>
                        <th style="width: 15%;">Điều Khiển</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listSupplier}" var="sup">
                        <tr>
                            <td><span class="id-tag">#SUP-${sup.supplierID}</span></td>
                            <td class="text-start fw-bold">
                                <div class="d-flex align-items-center">
                                    <div class="p-2 rounded-3 bg-primary bg-opacity-10 text-primary me-3"><i class="fa-solid fa-handshake"></i></div>
                                    <span class="fs-5 text-dark">${sup.supplierName}</span>
                                </div>
                            </td>
                            <td class="text-dark fw-bold">${sup.phone}</td>
                            <td class="text-muted small">${sup.address}</td>
                            <td>
                                <button type="button" class="btn btn-outline-info btn-sm rounded-pill px-3 me-2 border-0 fw-bold" 
                                        data-bs-toggle="modal" data-bs-target="#editModalSupplier${sup.supplierID}">Sửa</button>
                                <a href="SupplierController?action=delete&id=${sup.supplierID}" 
                                   class="btn btn-outline-danger btn-sm rounded-pill px-3 border-0 fw-bold" 
                                   onclick="return confirm('Ngừng hợp tác với đơn vị này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-5 mb-4 d-flex justify-content-between align-items-center border-top border-info border-opacity-10 pt-4">
        <h5 class="fw-bold text-muted text-uppercase" style="letter-spacing: 2px;"><i class="fa-solid fa-box-archive me-2"></i> Hồ sơ đối tác lưu trữ</h5>
        <button class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Mở Archive</button>
    </div>

    <div class="collapse" id="trashSection">
        <div class="aero-card p-0 overflow-hidden border-info border-opacity-10 mt-3">
            <table class="table aero-table align-middle text-center mb-0">
                <thead class="bg-info bg-opacity-10">
                    <tr>
                        <th style="width: 15%;">Mã ID</th>
                        <th class="text-start">Đối tác (Đã gỡ bỏ)</th>
                        <th style="width: 25%;">Hành động khôi phục</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listDeletedSupplier}" var="delSup">
                        <tr class="table-row-hover">
                            <td><span class="id-tag bg-secondary bg-opacity-10 text-muted">#${delSup.supplierID}</span></td>
                            <td class="text-start text-muted fw-light">
                                <del class="fw-bold">${delSup.supplierName}</del>
                            </td>
                            <td>
                                <a href="SupplierController?action=restore&id=${delSup.supplierID}" 
                                   class="btn btn-outline-success btn-sm rounded-pill px-4 border-0 fw-bold shadow-sm">
                                   <i class="fa-solid fa-rotate-left me-2"></i> KHÔI PHỤC
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:forEach items="${listSupplier}" var="sup">
    <div class="modal fade" id="editModalSupplier${sup.supplierID}" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content aero-card border-0 p-4" style="background: rgba(255,255,255,0.98);">
                <form action="SupplierController" method="POST">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="fw-bold fs-4 text-info">Cập nhật hồ sơ đối tác</h5>
                        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-start">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${sup.supplierID}">
                        
                        <div class="mb-4">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Tên Nhà Cung Cấp</label>
                            <input type="text" name="supplierName" class="form-control aero-input" value="${sup.supplierName}" required>
                        </div>
                        <div class="mb-4">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Điện Thoại</label>
                            <input type="text" name="phone" class="form-control aero-input" value="${sup.phone}">
                        </div>
                        <div class="mb-0">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Địa Chỉ</label>
                            <input type="text" name="address" class="form-control aero-input" value="${sup.address}">
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">ĐÓNG</button>
                        <button type="submit" class="btn btn-supplier-gradient px-5 shadow-sm">LƯU THAY ĐỔI</button>
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
        if(clockEl) clockEl.innerText = time;
    }
    setInterval(updateClock, 1000); updateClock();
</script>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>