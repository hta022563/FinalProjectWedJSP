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
                        <small class="text-white fw-bold d-block mt-1">KHO XE SẴN SÀNG</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric">
                        <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-4 d-inline-block mb-3"><i class="fa-solid fa-toolbox fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">1,450</h2>
                        <small class="text-white fw-bold d-block mt-1">VẬT PHẨM KHO</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric">
                        <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-4 d-inline-block mb-3"><i class="fa-solid fa-users fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">1.05k</h2>
                        <small class="text-white fw-bold d-block mt-1">KHÁCH HÀNG VIP</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="cyber-metric" style="border-bottom: 3px solid var(--m-cyan);">
                        <div class="p-3 bg-success bg-opacity-10 text-success rounded-4 d-inline-block mb-3"><i class="fa-solid fa-vault fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">3.24B</h2>
                        <small class="text-white fw-bold d-block mt-1">DOANH THU MỤC TIÊU</small>
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
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold m-0 text-white"><i class="fa-solid fa-bolt text-warning me-3"></i>Giao Dịch Gần Đây</h5>
                            <a href="DashboardController" class="btn btn-sm btn-outline-info rounded-pill px-3 shadow-sm" title="Làm mới dữ liệu">
                                <i class="fa-solid fa-rotate"></i>
                            </a>
                        </div>

                        <div class="feed-list" style="max-height: 280px; overflow-y: auto;">
                        <c:choose>
                            <%-- TRƯỜNG HỢP 1: CÓ DỮ LIỆU --%>
                            <c:when test="${not empty listActivities}">
                                <c:forEach items="${listActivities}" var="act">
                                    <div class="d-flex align-items-center p-3 rounded-4 bg-white bg-opacity-5 mb-3 transition-all table-row-hover border border-white border-opacity-10">

                                        <%-- Cấu hình màu sắc & icon dựa trên Type --%>
                                        <c:choose>
                                            <c:when test="${act.type == 'IMPORT'}">
                                                <div class="p-3 bg-success bg-opacity-10 text-success rounded-circle me-3"><i class="fa-solid fa-check"></i></div>
                                                    <c:set var="titleColor" value="text-info" />
                                                    <c:set var="rightTag"><span class="text-info fw-bold small">#${act.referenceCode}</span></c:set>
                                            </c:when>
                                            <c:when test="${act.type == 'SECURITY'}">
                                                <div class="p-3 bg-danger bg-opacity-10 text-danger rounded-circle me-3"><i class="fa-solid fa-shield-halved"></i></div>
                                                    <c:set var="titleColor" value="text-danger" />
                                                    <c:set var="rightTag"><span class="badge bg-danger text-white px-2 py-1 rounded-pill small">BLOCKED</span></c:set>
                                            </c:when>
                                            <c:when test="${act.type == 'ORDER'}">
                                                <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-circle me-3"><i class="fa-solid fa-cart-shopping"></i></div>
                                                    <c:set var="titleColor" value="text-warning" />
                                                    <c:set var="rightTag"><span class="text-success fw-bold small">+ <fmt:formatNumber value="${act.amount}" type="currency" currencySymbol="đ"/></span></c:set>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-circle me-3"><i class="fa-solid fa-terminal"></i></div>
                                                    <c:set var="titleColor" value="text-muted" />
                                                    <c:set var="rightTag"><span class="text-muted small">#${act.referenceCode}</span></c:set>
                                            </c:otherwise>
                                        </c:choose>

                                        <%-- Nội dung chính --%>
                                        <div class="flex-grow-1">
                                            <h6 class="m-0 ${titleColor} fw-bold small">${act.title}</h6>
                                            <small class="text-muted" style="font-size: 0.7rem;">Node: ${act.createdBy} | ${act.timeAgo}</small>
                                        </div>

                                        <%-- [U] UPDATE & [D] DELETE --%>
                                        <div class="d-flex align-items-center ms-2">
                                            ${rightTag}

                                            <%-- Nút Chỉnh sửa (Update) --%>
                                            <button class="btn btn-link text-info ms-2 p-0 opacity-50 hover-opacity-100" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#editLogModal"
                                                    onclick="prepareEditModal('${act.logId}', '${act.title}', '${act.type}', '${act.referenceCode}', '${act.amount}')">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>

                                            <%-- Nút Xóa (Delete) --%>
                                            <a href="DashboardController?action=deleteLog&id=${act.logId}" 
                                               class="text-danger ms-2 opacity-50 hover-opacity-100" 
                                               onclick="return confirm('Xác nhận xóa log?');">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%-- Giao diện khi trống (giữ nguyên như cũ) --%>
                                <div class="text-center p-4 mt-3 border border-danger border-opacity-25 rounded-4" style="background: rgba(220, 53, 69, 0.05);">
                                    <div class="p-4 bg-danger bg-opacity-10 rounded-circle d-inline-flex mb-3 shadow-sm">
                                        <i class="fa-solid fa-satellite-dish text-danger fs-1"></i>
                                    </div>
                                    <h5 class="text-danger fw-bold">Mất kết nối luồng dữ liệu</h5>
                                    <a href="DashboardController" class="btn btn-danger rounded-pill px-5 py-2 fw-bold shadow-lg small">KÍCH HOẠT</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="editLogModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark text-white border-secondary">
                        <div class="modal-header border-secondary">
                            <h5 class="modal-title"><i class="fa-solid fa-pen-to-square text-info me-2"></i>Chỉnh sửa Nhật ký</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="DashboardController" method="POST">
                            <input type="hidden" name="action" value="updateLog">
                            <input type="hidden" name="id" id="editLogId">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label small text-white">Tiêu đề hoạt động</label>
                                    <input type="text" name="title" id="editLogTitle" class="form-control bg-transparent text-white border-secondary" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small text-white">Loại (Type)</label>
                                        <select name="type" id="editLogType" class="form-select bg-transparent text-white border-secondary">
                                            <option value="IMPORT" class="bg-dark">IMPORT</option>
                                            <option value="SECURITY" class="bg-dark">SECURITY</option>
                                            <option value="ORDER" class="bg-dark">ORDER</option>
                                            <option value="SYSTEM" class="bg-dark">SYSTEM</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small text-white">Mã tham chiếu</label>
                                        <input type="text" name="refCode" id="editLogRef" class="form-control bg-transparent text-white border-secondary">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-secondary">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-info px-4">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                function prepareEditModal(id, title, type, ref, amount) {
                    document.getElementById('editLogId').value = id;
                    document.getElementById('editLogTitle').value = title;
                    document.getElementById('editLogType').value = type;
                    document.getElementById('editLogRef').value = ref;
                }
            </script>
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
    window.onload = function () {
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
                responsive: true, maintainAspectRatio: false, cutout: '75%',
                plugins: {legend: {position: 'bottom', labels: {color: '#94a3b8', font: {family: 'Inter', size: 12}}}}
            }
        });
    };
</script>
<script>
    function refreshLogs() {
        // Gọi Servlet với tham số type=ajax
        fetch('DashboardController?type=ajax')
            .then(response => response.text())
            .then(html => {
                // Tìm đến cái div chứa danh sách và thay ruột của nó
                const feedList = document.querySelector('.feed-list');
                // Nếu không bị lỗi "Mất kết nối", thì mới cập nhật
                if (html.trim() !== "") {
                    feedList.innerHTML = html;
                }
            })
            .catch(err => console.warn('Lỗi auto-reload:', err));
    }

    // Tự động chạy mỗi 5 giây (5000ms)
    setInterval(refreshLogs, 5000);
</script>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>