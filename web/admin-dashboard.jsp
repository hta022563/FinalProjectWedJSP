<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700;800&family=Inter:wght@300;400;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --m-cyan: #06b6d4;
            --m-indigo: #6366f1;
            --dark-void: #020617;
            --m-glass: rgba(15, 23, 42, 0.8);
        }
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
        .main-viewport {
            flex: 1;
            min-width: 0;
            padding: 40px !important;
            background: radial-gradient(circle at top right, rgba(6, 182, 212, 0.05), transparent 40%) !important;
        }
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
            filter: brightness(0.2) contrast(1.2);
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
        .cyber-feed::-webkit-scrollbar {
            width: 6px;
        }
        .cyber-feed::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.02);
            border-radius: 10px;
        }
        .cyber-feed::-webkit-scrollbar-thumb {
            background: rgba(251, 191, 36, 0.3);
            border-radius: 10px;
        }
        .cyber-feed::-webkit-scrollbar-thumb:hover {
            background: rgba(251, 191, 36, 0.8);
        }
        .log-row {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease;
        }
        .log-row:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.15);
            transform: translateX(5px);
            box-shadow: -5px 0 15px rgba(0,0,0,0.2);
        }
        .log-actions {
            opacity: 0;
            transition: 0.3s;
        }
        .log-row:hover .log-actions {
            opacity: 1;
        }
        @keyframes blink {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.3;
            }
        }
        .swal-cyber-popup {
            border: 1px solid var(--m-cyan) !important;
            border-radius: 15px !important;
            box-shadow: 0 0 30px rgba(6, 182, 212, 0.2) !important;
        }
    </style>

    <script>
        function dieuPhoiDon(event, url, actionType, orderId) {
            event.preventDefault();

            let titleText = '';
            let htmlText = '';
            let confirmColor = '';
            let btnClass = '';
            if (actionType === 'duyet') {
                titleText = 'XÁC NHẬN DUYỆT ĐƠN';
                htmlText = 'Kích hoạt hợp đồng mã <b style="color: #06b6d4;">#' + orderId + '</b>?';
                confirmColor = '#06b6d4';
                btnClass = 'btn-outline-info';
            } else if (actionType === 'giao') {
                titleText = 'BÀN GIAO XE';
                htmlText = 'Chuyển hợp đồng mã <b style="color: #6366f1;">#' + orderId + '</b> sang trạng thái ĐANG GIAO?';
                confirmColor = '#6366f1';
                btnClass = 'btn-outline-primary';
            } else if (actionType === 'chot') {
                titleText = 'HOÀN TẤT GIAO DỊCH';
                htmlText = 'Xác nhận hợp đồng mã <b style="color: #10b981;">#' + orderId + '</b> đã giao thành công?';
                confirmColor = '#10b981';
                btnClass = 'btn-outline-success';
            } else if (actionType === 'tuchoi') {
                titleText = 'TỪ CHỐI HỢP ĐỒNG';
                htmlText = 'Từ chối và hủy bỏ hợp đồng mã <b style="color: #ef4444;">#' + orderId + '</b>?';
                confirmColor = '#ef4444';
                btnClass = 'btn-outline-danger';
            }

            Swal.fire({
                title: '<span style="font-family: \'JetBrains Mono\', monospace; color: ' + confirmColor + ';">' + titleText + '</span>',
                html: '<span style="color: #ccc; font-family: \'Inter\', sans-serif;">' + htmlText + '</span>',
                icon: 'warning', iconColor: confirmColor, background: '#020617',
                showCancelButton: true, confirmButtonText: 'Tiến Hành', cancelButtonText: 'Hủy Bỏ',
                customClass: {popup: 'swal-cyber-popup', confirmButton: 'btn ' + btnClass + ' rounded-pill px-4 mx-2 fw-bold', cancelButton: 'btn btn-outline-secondary text-white rounded-pill px-4 mx-2 fw-bold border-secondary'},
                buttonsStyling: false
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: '<span style="color: ' + confirmColor + '; font-family: \'JetBrains Mono\', monospace;">Đang đồng bộ Data...</span>',
                        background: '#020617', allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                            setTimeout(() => {
                                window.location.href = url;
                            }, 800);
                        }
                    });
                }
            });
        }
    </script>

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
                        <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-4 d-inline-block mb-3"><i class="fa-solid fa-toolbox fs-4"></i></div>
                        <h2 class="fw-bold m-0 text-white">
                        <c:choose>
                            <c:when test="${not empty totalAccessories and totalAccessories > 0}"><fmt:formatNumber value="${totalAccessories}" type="number" pattern="#,###"/></c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </h2>
                    <small class="text-white fw-bold d-block mt-1">PHỤ KIỆN KÈM THEO</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="cyber-metric">
                    <div class="p-3 bg-info bg-opacity-10 text-info rounded-4 d-inline-block mb-3"><i class="fa-solid fa-car-side fs-4"></i></div>
                    <h2 class="fw-bold m-0 text-white">
                        <c:choose>
                            <c:when test="${not empty totalStock and totalStock > 0}"><fmt:formatNumber value="${totalStock}" type="number" pattern="#,###"/></c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </h2>
                    <small class="text-white fw-bold d-block mt-1">KHO XE SẴN SÀNG</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="cyber-metric">
                    <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-4 d-inline-block mb-3"><i class="fa-solid fa-users fs-4"></i></div>
                    <h2 class="fw-bold m-0 text-white">
                        <c:choose>
                            <c:when test="${not empty totalCustomers and totalCustomers > 0}"><fmt:formatNumber value="${totalCustomers}" type="number" pattern="#,###"/></c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </h2>
                    <small class="text-white fw-bold d-block mt-1">KHÁCH HÀNG VIP</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="cyber-metric">
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-4 d-inline-block mb-3"><i class="fa-solid fa-vault fs-4"></i></div>
                    <h2 class="fw-bold m-0 text-white">
                        <c:choose>
                            <c:when test="${not empty totalRevenue}">${totalRevenue}</c:when>
                            <c:otherwise>0.00B</c:otherwise>
                        </c:choose>
                    </h2>
                    <small class="text-white fw-bold d-block mt-1">DOANH THU MỤC TIÊU</small>
                </div>
            </div>
        </div>

        <div class="row g-5 mb-5">
            <div class="col-12">
                <div class="module-panel h-100 p-4 rounded-4 shadow-lg" style="background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.05);">
                    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary border-opacity-25 pb-3">
                        <h5 class="fw-bold m-0 text-white" style="letter-spacing: 1px;">
                            <i class="fa-solid fa-bolt text-warning me-2" style="text-shadow: 0 0 10px rgba(251, 191, 36, 0.8);"></i> LUỒNG GIAO DỊCH
                        </h5>
                        <div class="d-flex gap-2">
                            <a href="MainController?target=Dashboard" class="btn btn-sm btn-outline-warning rounded-pill px-3 transition-all" title="Làm mới dữ liệu">
                                <i class="fa-solid fa-rotate-right"></i> Đồng bộ
                            </a>
                            <a href="ExportController" class="btn btn-sm btn-success rounded-pill px-3 fw-bold shadow-sm">
                                <i class="fa-solid fa-file-excel me-1"></i> Xuất Excel Báo Cáo
                            </a>
                        </div>
                    </div>
                    <div class="cyber-feed pe-2" style="max-height: 350px; overflow-y: auto; overflow-x: hidden;">
                        <c:choose>
                            <c:when test="${not empty listActivities}">
                                <c:forEach items="${listActivities}" var="act">
                                    <div class="log-row d-flex align-items-center p-3 rounded-4 mb-3 position-relative">
                                        <c:choose>
                                            <c:when test="${act.type == 'IMPORT'}"><c:set var="titleColor" value="text-white" /> <c:set var="rightTag"><span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1">#${act.referenceCode}</span></c:set></c:when>
                                            <c:when test="${act.type == 'SECURITY'}"><c:set var="titleColor" value="text-danger" /> <c:set var="rightTag"><span class="badge bg-danger text-white px-2 py-1 rounded-1 shadow-sm"><i class="fa-solid fa-ban me-1"></i>BLOCKED</span></c:set></c:when>
                                            <c:when test="${act.type == 'ORDER'}"><c:set var="titleColor" value="text-warning" /> <c:set var="rightTag"><span class="text-success fw-bold fs-6">+ <fmt:formatNumber value="${act.amount}" type="number" pattern="#,###"/> ₫</span></c:set></c:when>
                                            <c:otherwise><c:set var="titleColor" value="text-info" /> <c:set var="rightTag"><span class="text-white small font-monospace">#${act.referenceCode}</span></c:set></c:otherwise>
                                        </c:choose>

                                        <div class="flex-grow-1">
                                            <h6 class="m-0 ${titleColor} fw-bold mb-1" style="font-size: 0.9rem;">${act.title}</h6>
                                            <small class="text-white d-flex align-items-center" style="font-size: 0.75rem;">
                                                <i class="fa-solid fa-network-wired me-1 opacity-50"></i> Node: ${act.createdBy} <span class="mx-2 opacity-25">|</span> <i class="fa-regular fa-clock me-1 opacity-50"></i> ${act.timeAgo}
                                            </small>
                                        </div>

                                        <div class="d-flex flex-column align-items-end justify-content-center ms-3">
                                            ${rightTag}
                                            <div class="log-actions mt-2 d-flex gap-2">
                                                <button class="btn btn-sm btn-outline-info rounded-circle d-flex align-items-center justify-content-center" style="width: 28px; height: 28px;" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#editLogModal" 
                                                        data-id="${act.logId}" 
                                                        data-title="${act.title}" 
                                                        data-type="${act.type}" 
                                                        data-ref="${act.referenceCode}" 
                                                        onclick="prepareEditModal(this)">
                                                    <i class="fa-solid fa-pen" style="font-size: 0.7rem;"></i>
                                                </button>
                                                <a href="MainController?target=Dashboard&action=deleteLog&id=${act.logId}" class="btn btn-sm btn-outline-danger rounded-circle d-flex align-items-center justify-content-center" style="width: 28px; height: 28px;" onclick="return confirm('Cảnh báo: Xác nhận tiêu hủy dòng nhật ký hệ thống này?');">
                                                    <i class="fa-solid fa-trash" style="font-size: 0.7rem;"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center p-5 mt-2 border border-danger border-opacity-50 rounded-4 position-relative overflow-hidden" style="background: rgba(220, 53, 69, 0.05);">
                                    <div class="position-absolute top-0 start-0 w-100 h-100 opacity-10" style="background: repeating-linear-gradient(45deg, transparent, transparent 10px, #dc3545 10px, #dc3545 20px);"></div>
                                    <div class="position-relative z-index-2">
                                        <div class="p-4 bg-danger bg-opacity-10 rounded-circle d-inline-flex mb-3 shadow-lg" style="border: 1px solid rgba(220, 53, 69, 0.3);"><i class="fa-solid fa-satellite-dish text-danger fs-1 heartbeat-animation"></i></div>
                                        <h5 class="text-danger fw-bold text-uppercase" style="letter-spacing: 2px;">Mất tín hiệu radar</h5>
                                        <p class="text-muted small mb-4">Hệ thống chưa ghi nhận giao dịch nào hoặc đường truyền bị gián đoạn.</p>
                                        <a href="MainController?target=Dashboard" class="btn btn-outline-danger rounded-pill px-5 py-2 fw-bold small"><i class="fa-solid fa-plug me-2"></i> KÍCH HOẠT LẠI</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="module-panel mb-5" style="border-top: 4px solid var(--m-indigo);">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary border-opacity-25 pb-3">
                <h4 class="fw-bold m-0 text-white" style="letter-spacing: 1px;"><i class="fa-solid fa-file-contract text-info me-3" style="text-shadow: 0 0 10px rgba(6, 182, 212, 0.8);"></i> TRẠM ĐIỀU PHỐI HỢP ĐỒNG</h4>
                <span class="badge bg-dark border border-info text-info px-3 py-2 rounded-pill shadow-sm">ĐƠN HÀNG LIVE</span>
            </div>

            <div class="table-responsive cyber-feed pe-2" style="max-height: 450px; overflow-y: auto;">
                <table class="table matrix-table mb-0">
    <thead style="position: sticky; top: 0; z-index: 10; background: var(--dark-void); box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);">
        <tr>
            <th class="text-start">MÃ HỢP ĐỒNG</th> 
            <th class="text-center">NGÀY THIẾT LẬP</th> 
            <th class="text-end">GIÁ TRỊ (VND)</th> 
            <th class="text-center">TÌNH TRẠNG</th> 
            <th class="text-center">TÁC VỤ ĐIỀU PHỐI</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty listAllOrders}">
                <tr><td colspan="5" class="text-center py-5 text-muted"><i class="fa-solid fa-satellite fa-spin fs-1 mb-3 opacity-50 text-warning"></i><br>Đang chờ tín hiệu giao dịch mới từ Radar...</td></tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${listAllOrders}">
                    <tr>
                        <td class="text-start">
                            <span class="fw-bold text-white fs-6">#${order.orderID}</span><br>
                            <span class="id-mono" style="font-family: 'JetBrains Mono', monospace; font-size: 0.75rem; color: #94a3b8;">UID Khách: ${order.userID}</span>
                        </td>
                        
                        <td class="text-center text-light opacity-75">
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                        </td>
                        
                        <td class="text-end fw-bold" style="color: var(--m-cyan);">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,###"/> đ
                        </td>
                        
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${order.status == 'Pending'}"><span class="badge bg-warning bg-opacity-10 text-warning border border-warning px-3 py-2 rounded-pill"><i class="fa-solid fa-circle-notch fa-spin me-1"></i>CHỜ DUYỆT</span></c:when>
                                <c:when test="${order.status == 'Approved'}"><span class="badge bg-info bg-opacity-10 text-info border border-info px-3 py-2 rounded-pill"><i class="fa-solid fa-check-double me-1"></i>ĐÃ DUYỆT</span></c:when>
                                <c:when test="${order.status == 'Shipping'}"><span class="badge bg-primary bg-opacity-10 text-primary border border-primary px-3 py-2 rounded-pill"><i class="fa-solid fa-truck-fast me-1"></i>ĐANG GIAO</span></c:when>
                                <c:when test="${order.status == 'Rejected'}"><span class="badge bg-danger bg-opacity-10 text-danger border border-danger px-3 py-2 rounded-pill"><i class="fa-solid fa-ban me-1"></i>ĐÃ TỪ CHỐI</span></c:when>
                                <c:when test="${order.status == 'Completed'}"><span class="badge bg-success bg-opacity-10 text-success border border-success px-3 py-2 rounded-pill"><i class="fa-solid fa-shield-check me-1"></i>HOÀN TẤT</span></c:when>
                                <c:otherwise><span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary px-3 py-2 rounded-pill">KHÔNG XÁC ĐỊNH</span></c:otherwise>
                            </c:choose>
                        </td>
                        
                        <td class="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <c:choose>
                                    <c:when test="${order.status == 'Pending'}">
                                        <a href="MainController?target=Order&action=updateStatus&orderId=${order.orderID}&status=Approved" class="btn btn-sm btn-outline-info rounded-pill px-3 fw-bold" onclick="dieuPhoiDon(event, this.href, 'duyet', '${order.orderID}')">DUYỆT</a>
                                        <a href="MainController?target=Order&action=updateStatus&orderId=${order.orderID}&status=Rejected" class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-bold" onclick="dieuPhoiDon(event, this.href, 'tuchoi', '${order.orderID}')">TỪ CHỐI</a>
                                    </c:when>
                                    
                                    <c:when test="${order.status == 'Approved'}">
                                        <a href="MainController?target=Order&action=updateStatus&orderId=${order.orderID}&status=Shipping" class="btn btn-sm btn-outline-primary rounded-pill px-4 fw-bold" onclick="dieuPhoiDon(event, this.href, 'giao', '${order.orderID}')">GIAO XE</a>
                                    </c:when>
                                    
                                    <c:when test="${order.status == 'Shipping'}">
                                        <a href="MainController?target=Order&action=updateStatus&orderId=${order.orderID}&status=Completed" class="btn btn-sm btn-outline-success rounded-pill px-4 fw-bold" onclick="dieuPhoiDon(event, this.href, 'chot', '${order.orderID}')">CHỐT</a>
                                    </c:when>
                                    
                                    <c:otherwise>
                                        <button class="btn btn-sm btn-outline-secondary rounded-pill px-4" disabled style="opacity: 0.5;"><i class="fa-solid fa-lock"></i> ĐÓNG LẠI</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
            </div>
        </div>

        <div class="module-panel mb-5 border-info border-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold m-0 text-white"><i class="fa-solid fa-crown text-gold me-3"></i>CHIẾN ĐỘI XE SANG ĐẶC QUYỀN</h4>
                <span class="badge bg-dark border border-info text-info px-3 py-2 rounded-pill">PHÂN KHÚC LUXURY</span>
            </div>
            <div class="table-responsive cyber-feed pe-2" style="max-height: 450px; overflow-y: auto;">
                <table class="table matrix-table mb-0">
                    <thead style="position: sticky; top: 0; z-index: 10; background: var(--dark-void); box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);">
                        <tr>
                            <th class="text-start">PHƯƠNG TIỆN</th> <th class="text-center">PHÂN KHÚC</th> <th class="text-end">NIÊM YẾT (VND)</th> <th class="text-center">KHO VẬN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <c:if test="${p.categoryID == 1 || p.categoryID == 2 || p.categoryID == 3}">
                                <tr>
                                    <td class="text-start">
                                        <div class="d-flex align-items-center">
                                            <img src="${p.imageURL}" class="car-snap me-4 shadow-lg" alt="car" style="width: 80px; height: 50px; object-fit: cover; border-radius: 8px;">
                                            <div>
                                                <div class="fw-bold text-white fs-6 mb-1">${p.productName}</div>
                                                <span class="id-mono" style="font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; color: var(--m-cyan);">VIN: FA-${p.productID}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-dark border border-info text-info rounded-pill px-3 py-1 text-uppercase">
                                            <c:choose>
                                                <c:when test="${p.categoryID == 1}">SUV LUXURY</c:when>
                                                <c:when test="${p.categoryID == 2}">SPORT CAR</c:when>
                                                <c:when test="${p.categoryID == 3}">SEDAN PREMIUM</c:when>
                                                <c:otherwise>XE SANG</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td class="text-end fw-bold text-white fs-5"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ</td>
                                    <td class="text-center fw-bold fs-5 text-white">${p.stockQuantity}</td>
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
    // Cập nhật đồng hồ HUD
    function updateClock() {
        const now = new Date();
        document.getElementById('digital-clock').innerText =
                now.getHours().toString().padStart(2, '0') + ":" +
                now.getMinutes().toString().padStart(2, '0') + ":" +
                now.getSeconds().toString().padStart(2, '0');
    }
    setInterval(updateClock, 1000);
    updateClock();

    // Auto reload bảng Log (Radar)
    function refreshLogs() {
        fetch('MainController?target=Dashboard&type=ajax')
                .then(response => response.text())
                .then(html => {
                    const feedList = document.querySelector('.cyber-feed');
                    if (html.trim() !== "" && feedList) {
                        feedList.innerHTML = html;
                    }
                })
                .catch(err => console.warn('Lỗi auto-reload:', err));
    }
    setInterval(refreshLogs, 5000);

    // Nạp data vào form Sửa Nhật Ký
    function prepareEditModal(btnElement) {
        document.getElementById('editLogId').value = btnElement.getAttribute('data-id');
        document.getElementById('editLogTitle').value = btnElement.getAttribute('data-title');
        document.getElementById('editLogType').value = btnElement.getAttribute('data-type');
        document.getElementById('editLogRef').value = btnElement.getAttribute('data-ref');
    }
</script>

<div class="modal fade" id="editLogModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white border-secondary">
            <div class="modal-header border-secondary">
                <h5 class="modal-title"><i class="fa-solid fa-pen-to-square text-info me-2"></i>Chỉnh sửa Nhật ký</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="MainController" method="POST">
                <input type="hidden" name="target" value="Dashboard">
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

<jsp:include page="includes/admin-footer.jsp"></jsp:include>