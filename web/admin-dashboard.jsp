<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700;800&family=Inter:wght@300;400;700;900&display=swap" rel="stylesheet">

    <style>
        /* ==========================================================
           1. CHIẾN DỊCH DIỆT KHOẢNG TRẮNG (GLOBAL RESET)
           ========================================================== */
        :root {
            --m-cyan: #06b6d4;
            --m-indigo: #6366f1;
            --dark-void: #020617; /* Màu đen sâu thẳm */
            --m-glass: rgba(15, 23, 42, 0.8);
        }

        /* ÉP TOÀN BỘ HỆ THỐNG SANG DARK MODE - KHÔNG CHỪA KHOẢNG TRẮNG */
        html, body, .grand-wrapper, .main-viewport, .container-fluid {
            background-color: var(--dark-void) !important;
            color: #f1f5f9 !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        .grand-wrapper {
            display: flex;
            min-height: 100vh;
            width: 100vw;
            background: var(--dark-void) !important;
        }

        /* VÙNG NỘI DUNG CHÍNH - TỰ ĐỘNG LẤP ĐẦY KHOẢNG TRỐNG */
        .main-viewport {
            flex: 1; /* Ép nó chiếm toàn bộ phần còn lại bên phải Sidebar */
            min-width: 0;
            padding: 40px !important;
            background: radial-gradient(circle at top right, rgba(6, 182, 212, 0.05), transparent 40%) !important;
        }

        /* ==========================================================
           2. HERO TERMINAL: PHỤC HỒI ẢNH XE CHÌM (DƯỚI CHỮ)
           ========================================================== */
        .terminal-hero {
            position: relative;
            border-radius: 35px;
            padding: 60px;
            margin-bottom: 40px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.05);
            box-shadow: 0 25px 50px rgba(0,0,0,0.8);
        }

        .hero-bg-car {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('IMG/Por.jpg');
            background-size: cover;
            background-position: center;
            z-index: 0;
            filter: brightness(0.2) contrast(1.2); /* Làm xe chìm sâu để nổi chữ */
            transform: scale(1.02);
            transition: 15s linear;
        }
        .terminal-hero:hover .hero-bg-car {
            transform: scale(1.1);
        }

        .hero-mask {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
           background: linear-gradient(90deg, #2e3241 30%, transparent);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            width: 100%;
        }

        .hud-clock {
            font-family: 'JetBrains Mono', monospace;
            font-size: 4rem;
            font-weight: 800;
            letter-spacing: -2px;
            background: linear-gradient(to bottom right, #fff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* ==========================================================
           3. MODULE CARDS & TABLES (CYBER DARK STYLE)
           ========================================================== */
        .cyber-metric {
            background: rgba(255,255,255,0.02);
            border: 1px solid rgba(255,255,255,0.05);
            border-radius: 25px;
            padding: 35px 30px;
            transition: 0.3s;
        }
        .cyber-metric:hover {
            border-color: var(--m-cyan);
            transform: translateY(-5px);
        }

        .module-panel {
            background: var(--m-glass);
            border-radius: 35px;
            border: 1px solid rgba(255,255,255,0.05);
            padding: 35px;
        }

        .matrix-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }
        .matrix-table thead th {
            color: #94a3b8;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            padding: 20px;
            border: none;
            background: transparent !important;
        }
        .matrix-table tbody tr {
            background: rgba(255, 255, 255, 0.02) !important;
            transition: 0.2s;
        }
        .matrix-table td {
            padding: 20px;
            border: none;
            vertical-align: middle;
            background: transparent !important;
        }

        .car-snap {
            width: 120px;
            height: 70px;
            object-fit: cover;
            border-radius: 15px;
            border: 1px solid rgba(255,255,255,0.1);
        }
        .pulse {
            width: 10px;
            height: 10px;
            background: #10b981;
            border-radius: 50%;
            animation: blink 2s infinite;
        }
        @keyframes blink {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.3;
            }
        }
    </style>

    <div class="grand-wrapper">
        <div class="main-viewport">

            <div class="terminal-hero">
                <div class="hero-bg-car"></div>
                <div class="hero-mask"></div>
                <div class="hero-content row align-items-center">
                    <div class="col-lg-7">
                        <div class="d-flex align-items-center gap-3 mb-4">
                            <div class="pulse"></div>
                            <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill fw-bold" style="letter-spacing: 1px;">ENCRYPTED NODE: TLS 1.3</span>
                        </div>
                        <h1 class="display-3 fw-bold mb-2">Command <span style="color: var(--m-cyan);">Matrix</span></h1>
                        <p class="fs-5 opacity-75 mb-0 text-light">Chào admin, hệ thống đang quản trị 45 đầu xe chiến lược.</p>
                    </div>
                    <div class="col-lg-5 text-end">
                        <div class="hud-clock" id="digital-clock">00:00:00</div>
                        <div class="d-flex justify-content-end gap-4 mt-2 opacity-50 text-light">
                            <small class="fw-bold" style="letter-spacing: 2px;">THỦ ĐỨC, HCM</small>
                            <small class="fw-bold" style="letter-spacing: 2px;">| NETWORK STATUS: ACTIVE</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5 text-center">
                <div class="col-md-3">
                    <div class="cyber-metric">
                        <div class="p-3 bg-info bg-opacity-10 text-info rounded-4 d-inline-block mb-3"><i class="fa-solid fa-car-side fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">45</h2>
                        <small class="text-muted fw-bold d-block mt-1">KHO XE SẴN SÀNG</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric">
                        <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-4 d-inline-block mb-3"><i class="fa-solid fa-toolbox fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">1,450</h2>
                        <small class="text-muted fw-bold d-block mt-1">VẬT PHẨM KHO</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric">
                        <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-4 d-inline-block mb-3"><i class="fa-solid fa-users fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">1.05k</h2>
                        <small class="text-muted fw-bold d-block mt-1">KHÁCH HÀNG VIP</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric" style="border-bottom: 3px solid var(--m-cyan);">
                        <div class="p-3 bg-success bg-opacity-10 text-success rounded-4 d-inline-block mb-3"><i class="fa-solid fa-vault fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">3.24B</h2>
                        <small class="text-muted fw-bold d-block mt-1">DOANH THU MỤC TIÊU</small>
                    </div>
                </div>
            </div>

            <div class="row g-5 mb-5">
                <div class="col-lg-5">
                    <div class="module-panel h-100 text-center">
                        <h5 class="fw-bold text-start mb-5 text-white"><i class="fa-solid fa-chart-pie text-info me-3"></i>Phân Bổ Tài Sản</h5>
                        <div style="height: 250px;"><canvas id="inventoryChart"></canvas></div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="module-panel h-100">
                        <h5 class="fw-bold mb-4 text-white"><i class="fa-solid fa-bolt text-warning me-3"></i>Giao Dịch Gần Đây</h5>
                        <div class="feed-list" style="max-height: 280px; overflow-y: auto;">
                            <div class="d-flex align-items-center p-3 rounded-4 bg-white bg-opacity-5 mb-3">
                                <div class="p-3 bg-success bg-opacity-10 text-success rounded-circle me-3"><i class="fa-solid fa-check"></i></div>
                                <div class="flex-grow-1">
                                    <h6 class="m-0 text-info">Nhập kho thành công 05 Mercedes S450</h6>
                                    <small class="text-muted">Bởi Admin | 10 phút trước</small>
                                </div>
                                <span class="text-info fw-bold">#AUTO-091</span>
                            </div>
                            <div class="d-flex align-items-center p-3 rounded-4 bg-white bg-opacity-5">
                                <div class="p-3 bg-info bg-opacity-10 text-info rounded-circle me-3"><i class="fa-solid fa-shield-halved"></i></div>
                                <div class="flex-grow-1">
                                    <h6 class="m-0 text-danger">Đã chặn 12 truy cập IP bất thường</h6>
                                    <small class="text-muted">Nginx Firewall | 2 giờ trước</small>
                                </div>
                                <span class="badge bg-danger text-white">BLOCKED</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="module-panel mb-5 border-info border-5">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold m-0 text-white"><i class="fa-solid fa-crown text-gold me-3"></i>CHIẾN ĐỘI XE SANG ĐẶC QUYỀN</h4>
                    <span class="badge bg-dark border border-info text-info px-3 py-2 rounded-pill">PHÂN KHÚC LUXURY</span>
                </div>
                <div class="table-responsive">
                    <table class="table matrix-table">
                        <thead>
                            <tr>
                                <th class="text-start">PHƯƠNG TIỆN</th>
                                <th class="text-center">PHÂN KHÚC</th>
                                <th class="text-end">NIÊM YẾT (VND)</th>
                                <th class="text-center">KHO VẬN</th>
                                <th class="text-center">HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${productList}" var="p">
                            <c:if test="${p.categoryID == 1 || p.categoryID == 2}">
                                <tr>
                                    <td class="text-start">
                                        <div class="d-flex align-items-center">
                                            <img src="${p.imageURL}" class="car-snap me-4 shadow-lg" alt="car">
                                            <div>
                                                <div class="fw-bold text-white fs-6 mb-1">${p.productName}</div>
                                                <span class="id-mono" style="font-family: 'JetBrains Mono'; font-size: 0.8rem; color: var(--m-cyan);">VIN: FA-${p.productID}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-dark border border-info text-info rounded-pill px-3 py-1">
                                            ${p.categoryID == 1 ? 'SUV LUX' : 'SEDAN PRO'}
                                        </span>
                                    </td>
                                    <td class="text-end fw-bold text-white fs-5">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                    </td>
                                    <td class="text-center fw-bold fs-5 text-white">${p.stockQuantity}</td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-light rounded-circle shadow-sm"><i class="fa-solid fa-gear"></i></button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="module-panel border-top border-info border-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold m-0 text-white"><i class="fa-solid fa-screwdriver-wrench text-warning me-3"></i>KHO VẬT PHẨM KỸ THUẬT</h4>
                <button class="btn btn-info btn-sm rounded-pill px-4 fw-bold shadow-lg">NHẬP HÀNG MỚI</button>
            </div>
            <div class="table-responsive">
                <table class="table matrix-table">
                    <thead>
                        <tr>
                            <th class="text-start">DANH MỤC VẬT PHẨM</th>
                            <th>MÔ TẢ KỸ THUẬT</th>
                            <th class="text-end">ĐƠN GIÁ (VND)</th>
                            <th class="text-center">TỒN KHO</th>
                            <th class="text-center">THAO TÁC</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <c:if test="${p.categoryID >= 3}">
                                <tr>
                                    <td class="text-start">
                                        <div class="d-flex align-items-center">
                                            <div class="p-3 bg-dark border border-secondary rounded-3 me-3 text-warning shadow-sm">
                                                <i class="fa-solid ${p.categoryID == 4 ? 'fa-circle-dot' : 'fa-toolbox'}"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold text-white mb-1">${p.productName}</div>
                                                <span class="id-mono" style="font-family: 'JetBrains Mono'; font-size: 0.8rem; color: #94a3b8;">PART-${p.productID}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-muted small italic" style="max-width: 280px;">${p.description}</td>
                                    <td class="text-end fw-bold text-white">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                    </td>
                                    <td class="text-center fw-bold fs-5 text-white">${p.stockQuantity}</td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <button class="btn btn-sm btn-outline-warning rounded-circle shadow-sm"><i class="fa-solid fa-pen"></i></button>
                                            <button class="btn btn-sm btn-outline-danger rounded-circle shadow-sm"><i class="fa-solid fa-trash"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script>
    function updateClock() {
        const now = new Date();
        document.getElementById('digital-clock').innerText =
                now.getHours().toString().padStart(2, '0') + ":" +
                now.getMinutes().toString().padStart(2, '0') + ":" +
                now.getSeconds().toString().padStart(2, '0');
    }
    setInterval(updateClock, 1000);
    updateClock();

    const ctx = document.getElementById('inventoryChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Xe', 'Linh kiện', 'Khác'],
            datasets: [{
                    data: [45, 1450, 120],
                    backgroundColor: ['#06b6d4', '#6366f1', '#1e293b'],
                    borderWidth: 0, hoverOffset: 15
                }]
        },
        options: {
            responsive: true, maintainAspectRatio: false, cutout: '80%',
            plugins: {legend: {position: 'bottom', labels: {color: '#94a3b8', font: {family: 'Inter', size: 12}}}}
        }
    });
</script>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>