<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>
 <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;700;900&family=JetBrains+Mono:wght@700&display=swap" rel="stylesheet">
<style>
    /* Nền tổng thể: Trắng sứ pha ánh hồng ngoại nhẹ */
    body { 
        background: linear-gradient(135deg, #fff5f5 0%, #f0f4f8 100%);
        color: #2d3436;
        font-family: 'Inter', sans-serif;
    }

    /* BANNER CINEMATIC - Siêu xe Đỏ rực tạo cảm giác KHUYẾN MÃI HOT */
    .banner-container {
        height: 280px; border-radius: 24px; overflow: hidden; position: relative;
        box-shadow: 0 20px 40px rgba(255, 75, 43, 0.2);
    }
    .banner-img {
        width: 100%; height: 100%; object-fit: cover;
        background-image: url('IMG/ferari.jpg');
        background-size: cover; background-position: center; filter: brightness(0.65) contrast(1.1);
    }
    .banner-overlay {
        position: absolute; top: 0; left: 0; width: 100%; height: 100%;
        background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(139, 0, 0, 0.6) 100%);
        display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;
    }
    .promo-main-title {
        background: linear-gradient(45deg, #ff416c, #ff4b2b);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        font-weight: 900; text-transform: uppercase; letter-spacing: 3px;
        font-size: 3.5rem; margin-bottom: 5px;
        font-family: 'Be Vietnam Pro', sans-serif !important;
        text-shadow: 0 10px 20px rgba(255, 65, 108, 0.3);
    }

    /* Aero Card Glassmorphism với viền ánh hồng */
    .aero-card {
        background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.6); border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
    }

    /* Input & Button phong cách "Hot Deal" */
    .aero-input {
        background: #ffffff !important; border: 1px solid #ffcccc !important;
        border-radius: 14px !important; padding: 12px 16px; transition: all 0.3s ease;
    }
    .aero-input:focus { border-color: #ff416c !important; box-shadow: 0 0 0 4px rgba(255, 65, 108, 0.1) !important; }

    .btn-promo-gradient {
        background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
        border: none; color: #fff; font-weight: 700; border-radius: 14px; padding: 14px 30px;
        box-shadow: 0 8px 20px rgba(255, 65, 108, 0.3); transition: all 0.3s ease;
        text-transform: uppercase; letter-spacing: 1px;
    }
    .btn-promo-gradient:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(255, 65, 108, 0.5); }

    /* Bảng dữ liệu Premium */
    .aero-table thead th {
        background: #fff5f5; color: #d63031; font-size: 0.75rem;
        text-transform: uppercase; letter-spacing: 1px; padding: 20px; border: none;
    }
    .aero-table td { padding: 25px 20px; border-bottom: 1px solid #fceaea; }
    .aero-table tr:hover { background-color: rgba(255, 65, 108, 0.02); }

    .discount-badge {
        background: linear-gradient(45deg, #d63031, #ff7675);
        color: #fff; padding: 8px 16px; border-radius: 12px;
        font-weight: 900; font-size: 1.1rem; box-shadow: 0 4px 10px rgba(214, 48, 49, 0.2);
    }
    .id-tag {
        background: #f0f7ff; color: #3a7bd5; padding: 6px 14px; border-radius: 10px;
        font-weight: 800; font-family: 'JetBrains Mono', monospace;
    }
</style>

<div class="container-fluid py-5 px-5">
    
    <div class="banner-container mb-5">
        <div class="banner-img"></div>
        <div class="banner-overlay">
            <h1 class="promo-main-title">Chương Trình Khuyến Mãi</h1>
            <p class="text-white-50 fs-5 fw-light m-0">F-AUTO | Kích cầu mua sắm - Tri ân khách hàng đặc quyền</p>
            <div class="mt-3 badge rounded-pill px-4 py-2 border border-danger border-opacity-25 shadow-lg" 
     style="background: rgba(255, 65, 108, 0.12) !important; 
            backdrop-filter: blur(15px); 
            border: 1px solid rgba(255, 75, 43, 0.25) !important;
            box-shadow: 0 8px 25px 0 rgba(214, 48, 49, 0.3);">
    
    <i class="fa-solid fa-fire-flame-curved me-2" style="color: #ff4b2b;"></i> 
    
    <span id="digital-clock" class="fw-bold" 
          style="color: #ffffff; 
                 text-shadow: 0 0 12px rgba(255, 65, 108, 0.8); 
                 letter-spacing: 2px; 
                 font-family: 'JetBrains Mono', monospace;">
        00:00:00
    </span>
</div>
        </div>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger border-0 rounded-4 shadow-sm mb-4"><i class="fa-solid fa-fire-flame-curved me-2"></i> ${errorMessage}</div>
    </c:if>

    <div class="aero-card p-4 mb-5 border-start border-danger border-5">
        <h5 class="fw-bold mb-4 d-flex align-items-center" style="color: #d63031;">
            <span class="bg-danger bg-opacity-10 p-2 rounded-3 me-3"><i class="fa-solid fa-ticket text-danger"></i></span>
            Phát hành mã ưu đãi mới
        </h5>
        <form action="PromotionController" method="POST">
            <input type="hidden" name="action" value="add"> 
            <div class="row g-4">
                <div class="col-md-3">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Mã Code Niêm Yết</label>
                    <input type="text" name="promoCode" class="form-control aero-input fw-bold text-success" style="letter-spacing: 2px;" placeholder="VD: F-AUTO-2026" required>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Mức Giảm (%)</label>
                    <input type="number" name="discountPercent" class="form-control aero-input fw-bold text-danger" min="1" max="100" placeholder="%" required>
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Ngày Kích Hoạt</label>
                    <input type="date" name="startDate" class="form-control aero-input" required>
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-muted mb-2 text-uppercase">Ngày Hết Hạn</label>
                    <input type="date" name="endDate" class="form-control aero-input" required>
                </div>
                <div class="col-md-1 d-flex align-items-end">
                    <button class="btn btn-promo-gradient w-100 py-3" type="submit"><i class="fa-solid fa-bolt"></i></button>
                </div>
            </div>
        </form>
    </div>

    <div class="aero-card overflow-hidden shadow-lg border-0 mb-5">
        <div class="table-responsive">
            <table class="table aero-table align-middle text-center mb-0">
                <thead>
                    <tr>
                        <th style="width: 10%;">ID</th>
                        <th class="text-start" style="width: 25%;">Chiến Dịch Khuyến Mãi</th>
                        <th style="width: 15%;">Mức Giảm</th>
                        <th style="width: 15%;">Bắt Đầu</th>
                        <th style="width: 15%;">Kết Thúc</th>
                        <th style="width: 20%;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listPromotion}" var="pro">
                        <tr>
                            <td><span class="id-tag">#PRO-${pro.promotionID}</span></td>
                            <td class="text-start fw-bold fs-5">
                                <div class="d-flex align-items-center">
                                    <div class="p-2 rounded-3 bg-danger bg-opacity-10 text-danger me-3"><i class="fa-solid fa-tags"></i></div>
                                    <span class="text-dark">${pro.promoCode}</span>
                                </div>
                            </td>
                            <td><span class="discount-badge">-${pro.discountPercent}%</span></td>
                            <td class="text-muted fw-bold">${pro.startDate}</td>
                            <td class="text-muted fw-bold">${pro.endDate}</td>
                            <td>
                                <button type="button" class="btn btn-outline-warning btn-sm rounded-pill px-3 me-2 border-0 fw-bold" 
                                        data-bs-toggle="modal" data-bs-target="#editModalPromo${pro.promotionID}">Sửa</button>
                                <a href="PromotionController?action=delete&id=${pro.promotionID}" 
                                   class="btn btn-outline-danger btn-sm rounded-pill px-3 border-0 fw-bold" 
                                   onclick="return confirm('Gỡ bỏ chiến dịch khuyến mãi này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-5 mb-4 d-flex justify-content-between align-items-center border-top border-danger border-opacity-10 pt-4">
        <h5 class="fw-bold text-muted text-uppercase" style="letter-spacing: 2px;"><i class="fa-solid fa-calendar-xmark me-2"></i> Lịch sử chiến dịch đã đóng</h5>
        <button class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Xem Archive</button>
    </div>

    <div class="collapse" id="trashSection">
        <div class="aero-card p-0 overflow-hidden border-danger border-opacity-10">
            <table class="table aero-table align-middle text-center mb-0">
                <thead class="bg-dark bg-opacity-5">
                    <tr>
                        <th style="width: 15%;">Mã ID</th>
                        <th class="text-start">Mã đã gỡ bỏ</th>
                        <th style="width: 20%;">Hành động</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    <c:forEach items="${listDeletedPromotion}" var="delPro">
                        <tr>
                            <td><span class="id-tag bg-secondary bg-opacity-10 text-muted">#${delPro.promotionID}</span></td>
                            <td class="text-start text-muted fw-light"><del class="fw-bold">${delPro.promoCode}</del></td>
                            <td>
                                <a href="PromotionController?action=restore&id=${delPro.promotionID}" 
                                   class="btn btn-outline-success btn-sm rounded-pill px-4 border-0 fw-bold">
                                   <i class="fa-solid fa-rotate-left me-2"></i> Khôi phục
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listDeletedPromotion}">
                        <tr><td colspan="3" class="py-4 text-muted small italic">Thùng rác trống.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:forEach items="${listPromotion}" var="pro">
    <div class="modal fade" id="editModalPromo${pro.promotionID}" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content aero-card border-0 p-4" style="background: rgba(255,255,255,0.98);">
                <form action="PromotionController" method="POST">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="fw-bold fs-4 text-danger">Hiệu chỉnh chiến dịch</h5>
                        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-start">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${pro.promotionID}">
                        <div class="mb-4">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Mã Code Mới</label>
                            <input type="text" name="promoCode" class="form-control aero-input fw-bold" value="${pro.promoCode}" required>
                        </div>
                        <div class="mb-4">
                            <label class="fw-bold text-muted small mb-2 text-uppercase">Giảm Giá (%)</label>
                            <input type="number" name="discountPercent" class="form-control aero-input fw-bold" value="${pro.discountPercent}" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="fw-bold text-muted small mb-2 text-uppercase">Bắt Đầu</label>
                                <input type="date" name="startDate" class="form-control aero-input" value="${pro.startDate}" required>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="fw-bold text-muted small mb-2 text-uppercase">Kết Thúc</label>
                                <input type="date" name="endDate" class="form-control aero-input" value="${pro.endDate}" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-promo-gradient px-5 shadow-sm">LƯU THAY ĐỔI</button>
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