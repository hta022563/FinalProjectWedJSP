<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;700;900&family=JetBrains+Mono:wght@700&display=swap" rel="stylesheet">
<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <style>
        /* Nền tổng thể: Vân gỗ Walnut sâu thẳm phối màu tối cao cấp */
        body {
            background: radial-gradient(circle at center, #3d2b1f 0%, #1a120b 100%);
            color: #dcdde1;
            font-family: 'Inter', sans-serif;
        }

        /* BANNER CINEMATIC - Không gian trưng bày xe sang */
        .banner-container {
            height: 280px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
        }
        .banner-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            /* Dán link ảnh mới bạn chọn vào đây */
            background-image: url('https://images.unsplash.com/photo-1542282088-72c9c27ed0cd?auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            filter: brightness(0.4) sepia(0.3); /* Giữ filter này để màu ảnh tệp với màu gỗ */
        }
        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(26, 18, 11, 0.9) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .showroom-title {
            color: #d4af37;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 5px;
            font-size: 3.2rem;
            font-family: 'Be Vietnam Pro', sans-serif !important;
            margin-bottom: 5px;
            text-shadow: 0 0 20px rgba(212, 175, 55, 0.3);
        }

        /* Thẻ Card Gỗ - Glassmorphism ấm áp */
        .wood-card {
            background: rgba(44, 30, 20, 0.6);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(212, 175, 55, 0.15);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
           
        }

        /* Ô nhập liệu Bespoke */
        .wood-input {
       
        border: 1px solid #5d4037 !important;
        border-radius: 12px !important; 
        padding: 14px 18px; 
        color:black !important; /* Ép chữ nhập vào phải là màu trắng */
        transition: all 0.3s ease;
    }
        .wood-input:focus {
            
            border-color: #d4af37 !important;
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.1) !important;
        }

        /* Nút bấm Vàng Đồng (Brass) */
        .btn-brass {
            background: linear-gradient(135deg, #d4af37 0%, #aa8928 100%);
            border: none;
            color: #1a120b;
            font-weight: 800;
            border-radius: 12px;
            padding: 12px 25px;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }
        .btn-brass:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
        }

        /* Bảng dữ liệu Showroom */
        .aero-table thead th {
            background: rgba(0, 0, 0, 0.4);
            color: #d4af37;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            padding: 22px;
            border: none;
        }
        .aero-table td {
            padding: 25px 22px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.05);
            vertical-align: middle;
        }
        .aero-table tr:hover {
            background-color: rgba(212, 175, 55, 0.03);
        }

        .id-tag {
            background: rgba(212, 175, 55, 0.1);
            color: #d4af37;
            padding: 6px 12px;
            border-radius: 8px;
            font-weight: 800;
            font-family: 'JetBrains Mono', monospace;
            border: 1px solid rgba(212, 175, 55, 0.2);
        }
    </style>

    <div class="container-fluid py-5 px-5">

        <div class="banner-container mb-5">
            <div class="banner-img"></div>
            <div class="banner-overlay">
                <h1 class="showroom-title">Hệ Thống Showroom</h1>
                <p class="text-white-50 fs-5 fw-light m-0">F-AUTO | Không gian nghệ thuật trưng bày đẳng cấp</p>
                <div class="mt-3 badge rounded-pill bg-white bg-opacity-10 px-4 py-2" style="backdrop-filter: blur(5px);">
                    <i class="fa-solid fa-clock me-2 text-warning"></i> <span id="digital-clock" class="fw-bold text-white">00:00:00</span>
                </div>
            </div>
        </div>

        <div class="wood-card p-4 mb-5 border-start border-warning border-5">
            <h5 class="fw-bold mb-4 d-flex align-items-center" style="color: #d4af37;">
                <span class="bg-warning bg-opacity-10 p-2 rounded-3 me-3"><i class="fa-solid fa-location-dot"></i></span>
                Thiết lập điểm trưng bày mới
            </h5>
            <form action="ShowroomController" method="POST">
                <input type="hidden" name="action" value="add"> 
                <div class="row g-4 align-items-end">
                    <div class="col-md-3">
                        <label class="small fw-bold text-warning mb-2 text-uppercase">Tên chi nhánh</label>
                        <input type="text" name="name" class="form-control wood-input" placeholder="VD: F-AUTO Tây Ninh..." required>
                    </div>
                    <div class="col-md-5">
                        <label class="small fw-bold text-warning mb-2 text-uppercase">Vị trí tọa lạc</label>
                        <input type="text" name="address" class="form-control wood-input" placeholder="Địa chỉ chi nhánh..." required>
                    </div>
                    <div class="col-md-3">
                        <label class="small fw-bold text-warning mb-2 text-uppercase">Hotline kinh doanh</label>
                        <input type="text" name="hotline" class="form-control wood-input" placeholder="Số điện thoại..." required>
                    </div>
                    <div class="col-md-1">
                        <button class="btn btn-brass w-100 py-3 shadow-sm" type="submit"><i class="fa-solid fa-plus"></i></button>
                    </div>
                </div>
            </form>
        </div>

        <div class="wood-card overflow-hidden shadow-lg border-0 mb-5">
            <div class="table-responsive">
                <table class="table aero-table align-middle text-center mb-0">
                    <thead>
                        <tr>
                            <th style="width: 12%;">Mã ID</th>
                            <th class="text-start" style="width: 25%;">Tên Showroom</th>
                            <th style="width: 35%;">Địa Chỉ Hoạt Động</th>
                            <th style="width: 15%;">Hotline</th>
                            <th style="width: 13%;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listShowroom}" var="s">
                        <tr>
                            <td><span class="id-tag">#SR-${s.showroomID}</span></td>
                            <td class="text-start fw-bold">
                                <div class="d-flex align-items-center">
                                    <div class="p-2 rounded-3 bg-warning bg-opacity-10 text-warning me-3"><i class="fa-solid fa-hotel"></i></div>
                                    <span class="fs-5 text-warning" ">${s.showroomName}</span>
                                </div>
                            </td>
                            <td class="text-warning fw-light italic">${s.address}</td>
                            <td class="text-warning fw-bold">${s.hotline}</td>
                            <td>
                                <div class="d-flex gap-2 justify-content-center">
                                    <button class="btn btn-outline-warning btn-sm rounded-pill border-0 fw-bold px-3" 
                                            data-bs-toggle="modal" data-bs-target="#editModalSR${s.showroomID}">SỬA</button>
                                    <a href="ShowroomController?action=delete&id=${s.showroomID}" 
                                       class="btn btn-outline-danger btn-sm rounded-pill border-0 fw-bold px-3" 
                                       onclick="return confirm('Gỡ bỏ chi nhánh này?')">XÓA</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listShowroom}">
                        <tr><td colspan="5" class="py-5 text-muted">Hệ thống đang chờ thiết lập showroom mới từ Hảo...</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-5 mb-4 d-flex justify-content-between align-items-center border-top border-warning border-opacity-10 pt-4">
        <h5 class="fw-bold text-warning text-uppercase" style="letter-spacing: 2px;"><i class="fa-solid fa-box-archive me-2"></i> Lưu trữ Archive</h5>
        <button class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Hiện / Ẩn Archive</button>
    </div>

    <div class="collapse" id="trashSection">
        <div class="wood-card p-0 overflow-hidden border-dark border-opacity-10">
            <table class="table aero-table align-middle text-center mb-0">
                <thead class="bg-dark bg-opacity-20">
                    <tr>
                        <th style="width: 15%;">Mã ID</th>
                        <th class="text-start">Chi nhánh đã gỡ bỏ</th>
                        <th style="width: 20%;">Hành động</th>
                    </tr>
                </thead>
                <tbody class="bg-white bg-opacity-5">
                    <c:forEach items="${listDeleted}" var="delShowroom">
                        <tr>
                            <td><span class="id-tag bg-secondary bg-opacity-10 text-muted">#${delShowroom.showroomID}</span></td>
                            <td class="text-start text-muted fw-light"><del class="fw-bold">${delShowroom.showroomName}</del></td>
                            <td>
                                <a href="ShowroomController?action=restore&id=${delShowroom.showroomID}" 
                                   class="btn btn-outline-success btn-sm rounded-pill px-4 border-0 fw-bold">
                                    <i class="fa-solid fa-rotate-left me-2"></i> KHÔI PHỤC
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listDeleted}">
                        <tr><td colspan="3" class="py-4 text-center text-muted">Thùng rác hiện đang trống.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:forEach items="${listShowroom}" var="s">
    <div class="modal fade" id="editModalSR${s.showroomID}" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content wood-card border-0 p-4" style="background: rgba(26, 18, 11, 0.98);">
                <form action="ShowroomController" method="POST">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="fw-bold fs-4 text-warning">Hiệu chỉnh chi nhánh</h5>
                        <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-start">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${s.showroomID}">
                        <div class="mb-4">
                            <label class="fw-bold text-warning small mb-2 text-uppercase">Tên chi nhánh</label>
                            <input type="text" name="name" class="form-control wood-input" value="${s.showroomName}" required>
                        </div>
                        <div class="mb-4">
                            <label class="fw-bold text-warning small mb-2 text-uppercase">Vị trí địa chỉ</label>
                            <input type="text" name="address" class="form-control wood-input" value="${s.address}" required>
                        </div>
                        <div class="mb-0">
                            <label class="fw-bold text-warning small mb-2 text-uppercase">Hotline</label>
                            <input type="text" name="hotline" class="form-control wood-input" value="${s.hotline}" required>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">ĐÓNG</button>
                        <button type="submit" class="btn btn-brass px-5 shadow-sm">LƯU THAY ĐỔI</button>
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