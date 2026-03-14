<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <style>
        body {
            background: linear-gradient(135deg, #f0fdf4 0%, #e2eeff 100%);
            color: #2d3436;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }
        .banner-container {
            height: 250px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 20px 40px rgba(17, 153, 142, 0.15);
        }
        .banner-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            background-image: url('IMG/porche.jpg'); /* Đảm bảo sếp có ảnh này trong folder IMG */
            background-size: cover;
            background-position: center;
            filter: brightness(0.5);
        }
        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(11, 44, 30, 0.7) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .money-title {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-size: 3rem;
            margin-bottom: 5px;
            text-shadow: 0 5px 15px rgba(56, 239, 125, 0.2);
        }
        .aero-card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(17, 153, 142, 0.1);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
        }
        .aero-input {
            background: #ffffff !important;
            border: 1px solid #c8e6c9 !important;
            border-radius: 14px !important;
            padding: 14px 18px;
            transition: all 0.3s ease;
        }
        .aero-input:focus {
            border-color: #11998e !important;
            box-shadow: 0 0 0 4px rgba(17, 153, 142, 0.1) !important;
        }
        .btn-money-gradient {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            color: #fff;
            font-weight: 700;
            border-radius: 14px;
            padding: 14px 30px;
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.2);
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-money-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(17, 153, 142, 0.3);
        }
        .aero-table thead th {
            background: #f1fcf4;
            color: #11998e;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 20px;
            border: none;
        }
        .aero-table td {
            padding: 25px 20px;
            border-bottom: 1px solid #e8f5e9;
        }
        .aero-table tr:hover {
            background-color: rgba(56, 239, 125, 0.03);
        }
        .id-tag {
            background: #eafaf1;
            color: #11998e;
            padding: 6px 14px;
            border-radius: 10px;
            font-weight: 800;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.9rem;
            border: 1px solid rgba(17, 153, 142, 0.1);
        }
    </style>

    <div class="container-fluid py-5 px-5">

        <div class="banner-container mb-5">
            <div class="banner-img"></div>
            <div class="banner-overlay">
                <h1 class="money-title">Hệ Thống Thanh Toán</h1>
                <p class="text-white-50 fs-5 fw-light m-0">F-AUTO | Tối ưu hóa dòng tiền và quản trị lợi nhuận</p>
                
                <div class="mt-3 badge rounded-pill px-4 py-2 border border-success border-opacity-25 shadow-lg" 
                     style="background: rgba(17, 153, 142, 0.15) !important; backdrop-filter: blur(15px); border: 1px solid rgba(56, 239, 125, 0.3) !important; box-shadow: 0 8px 32px 0 rgba(17, 153, 142, 0.3);">
                    <i class="fa-solid fa-money-bill-transfer me-2" style="color: #38ef7d;"></i> 
                    <span id="digital-clock" class="fw-bold" style="color: #ffffff; text-shadow: 0 0 12px rgba(56, 239, 125, 0.8); letter-spacing: 2px; font-family: 'JetBrains Mono', monospace;">00:00:00</span>
                </div>
            </div>
        </div>

        <%-- FORM THÊM MỚI --%>
        <div class="aero-card p-4 mb-5 border-start border-success border-5">
            <h5 class="fw-bold mb-4 d-flex align-items-center" style="color: #11998e;">
                <span class="bg-success bg-opacity-10 p-2 rounded-3 me-3"><i class="fa-solid fa-sack-dollar text-success"></i></span>
                Phát hành phương thức giao dịch mới
            </h5>
            <form action="PaymentMethodController" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add"> 
                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="small fw-bold text-muted mb-2 text-uppercase">Danh xưng phương thức</label>
                        <input type="text" name="methodName" class="form-control aero-input" placeholder="VD: Chuyển khoản QR..." required>
                    </div>
                    <div class="col-md-4">
                        <label class="small fw-bold text-muted mb-2 text-uppercase">Mã hệ thống (QR, CARD, CASH)</label>
                        <select name="methodCode" id="addMethodCode" class="form-select aero-input" onchange="toggleBankInfo('add')">
                            <option value="QR">Mã QR (Chuyển khoản)</option>
                            <option value="CARD">Thẻ tín dụng (Visa/Master)</option>
                            <option value="CASH">Tiền mặt tại Showroom</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="small fw-bold text-muted mb-2 text-uppercase">Icon hiển thị (FontAwesome)</label>
                        <input type="text" name="iconClass" class="form-control aero-input" placeholder="fa-solid fa-qrcode">
                    </div>
                    <div class="col-md-12">
                        <label class="small fw-bold text-muted mb-2 text-uppercase">Mô tả ngắn</label>
                        <input type="text" name="description" class="form-control aero-input" placeholder="Nhập mô tả hiển thị cho khách hàng...">
                    </div>
                </div>

                <%-- KHUNG NHẬP THÔNG TIN NGÂN HÀNG (Mặc định sẽ hiện vì option đầu là QR) --%>
                <div id="addBankInfoBox" class="row g-3 p-3 bg-success bg-opacity-10 rounded-3 mb-4 border border-success border-opacity-25" style="display: flex;">
                    <h6 class="text-success fw-bold m-0"><i class="fa-solid fa-building-columns me-2"></i>Cấu hình tài khoản nhận tiền</h6>
                    <div class="col-md-3">
                        <input type="text" name="bankName" class="form-control aero-input" placeholder="Tên Ngân hàng (VD: Vietcombank)">
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="accountNo" class="form-control aero-input" placeholder="Số tài khoản">
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="accountName" class="form-control aero-input" placeholder="Tên chủ thẻ">
                    </div>
                    <div class="col-md-3">
                        <input type="file" name="qrCodeFile" class="form-control aero-input" accept="image/*">
                        <small class="text-muted mt-1 d-block">Tải lên ảnh mã QR</small>
                    </div>
                </div>

                <div class="text-end">
                    <button class="btn btn-money-gradient px-5 shadow-sm" type="submit">
                        <i class="fa-solid fa-plus me-2"></i> THIẾT LẬP
                    </button>
                </div>
            </form>
        </div>

        <%-- BẢNG PHƯƠNG THỨC ĐANG HOẠT ĐỘNG --%>
        <div class="aero-card overflow-hidden shadow-lg border-0 mb-5">
            <div class="table-responsive">
                <table class="table aero-table align-middle text-center mb-0">
                    <thead>
                        <tr>
                            <th style="width: 15%;">Mã Định Danh</th>
                            <th class="text-start">Cổng Thanh Toán</th>
                            <th style="width: 25%;">Trạng Thái</th>
                            <th style="width: 20%;">Điều Khiển</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white">
                        <c:forEach items="${listPaymentMethod}" var="pm">
                            <tr>
                                <td><span class="id-tag">#PM-${pm.methodID}</span></td>
                                <td class="text-start fw-bold">
                                    <div class="d-flex align-items-center">
                                        <div class="p-2 rounded-3 bg-success bg-opacity-10 text-success me-3">
                                            <i class="${pm.iconClass != null ? pm.iconClass : 'fa-solid fa-wallet'} fs-4"></i>
                                        </div>
                                        <div>
                                            <span class="fs-5 text-dark d-block">${pm.methodName}</span>
                                            <small class="text-muted fw-normal">${pm.methodCode}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2 fw-bold">
                                        <i class="fa-solid fa-circle-check me-1"></i> ĐANG MỞ
                                    </span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline-success btn-sm rounded-pill px-3 me-2 border-0 fw-bold" 
                                            data-bs-toggle="modal" data-bs-target="#editModalPM${pm.methodID}">SỬA</button>
                                    <a href="PaymentMethodController?action=delete&id=${pm.methodID}" 
                                       class="btn btn-outline-danger btn-sm rounded-pill px-3 border-0 fw-bold" 
                                       onclick="return confirm('Tạm ngưng cổng thanh toán này?')">DỪNG</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- KHU VỰC THÙNG RÁC (ĐÃ ẨN) --%>
        <div class="mt-5 mb-4 d-flex justify-content-between align-items-center border-top border-success border-opacity-10 pt-4">
            <h5 class="fw-bold text-muted text-uppercase" style="letter-spacing: 2px;"><i class="fa-solid fa-box-archive me-2"></i> Hồ sơ giao dịch đã đóng</h5>
            <button class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#trashSection">Mở Archive</button>
        </div>

        <div class="collapse" id="trashSection">
            <div class="aero-card p-0 overflow-hidden border-success border-opacity-10 mt-3">
                <table class="table aero-table align-middle text-center mb-0">
                    <thead class="bg-success bg-opacity-10">
                        <tr>
                            <th style="width: 15%;">Mã ID</th>
                            <th class="text-start">Cổng đã dừng</th>
                            <th style="width: 20%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white">
                        <c:forEach items="${listDeletedPaymentMethod}" var="delPM">
                            <tr>
                                <td><span class="id-tag bg-secondary bg-opacity-5 text-muted">#${delPM.methodID}</span></td>
                                <td class="text-start text-muted"><del class="fw-bold">${delPM.methodName}</del></td>
                                <td>
                                    <a href="PaymentMethodController?action=restore&id=${delPM.methodID}" class="btn btn-outline-success btn-sm rounded-pill px-4 border-0 fw-bold shadow-sm">
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

    <%-- MODAL CHỈNH SỬA (LẶP THEO SỐ LƯỢNG PHƯƠNG THỨC) --%>
    <c:forEach items="${listPaymentMethod}" var="pm">
        <div class="modal fade" id="editModalPM${pm.methodID}" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content aero-card border-0 p-4" style="background: rgba(255,255,255,0.98);">
                    <form action="PaymentMethodController" method="POST" enctype="multipart/form-data">
                        <div class="modal-header border-0 pb-0">
                            <h5 class="fw-bold fs-4 text-success">Hiệu chỉnh phương thức</h5>
                            <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body text-start">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${pm.methodID}">

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="fw-bold text-muted small mb-2 text-uppercase">Tên phương thức</label>
                                    <input type="text" name="methodName" class="form-control aero-input fw-bold" value="${pm.methodName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="fw-bold text-muted small mb-2 text-uppercase">Mã hệ thống</label>
                                    <select name="methodCode" id="editCode${pm.methodID}" class="form-select aero-input" onchange="toggleBankInfo('edit', ${pm.methodID})">
                                        <option value="QR" ${pm.methodCode == 'QR' ? 'selected' : ''}>Mã QR (Chuyển khoản)</option>
                                        <option value="CARD" ${pm.methodCode == 'CARD' ? 'selected' : ''}>Thẻ tín dụng (Visa/Master)</option>
                                        <option value="CASH" ${pm.methodCode == 'CASH' ? 'selected' : ''}>Tiền mặt tại Showroom</option>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <label class="fw-bold text-muted small mb-2 text-uppercase">Icon hiển thị</label>
                                    <input type="text" name="iconClass" class="form-control aero-input" value="${pm.iconClass}">
                                </div>
                                <div class="col-md-12">
                                    <label class="fw-bold text-muted small mb-2 text-uppercase">Mô tả</label>
                                    <input type="text" name="description" class="form-control aero-input" value="${pm.description}">
                                </div>
                            </div>

                            <%-- KHUNG THÔNG TIN NGÂN HÀNG (TRONG MODAL SỬA) --%>
                            <div id="editBankInfoBox${pm.methodID}" class="row g-3 p-3 bg-success bg-opacity-10 rounded-3" style="display: ${pm.methodCode == 'QR' ? 'flex' : 'none'};">
                                <h6 class="text-success fw-bold m-0 w-100"><i class="fa-solid fa-building-columns me-2"></i>Cấu hình tài khoản nhận tiền</h6>
                                <div class="col-md-6">
                                    <label class="small text-muted mb-1">Ngân hàng</label>
                                    <input type="text" name="bankName" class="form-control aero-input" value="${pm.bankName}">
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-muted mb-1">Số TK</label>
                                    <input type="text" name="accountNo" class="form-control aero-input" value="${pm.accountNo}">
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-muted mb-1">Chủ thẻ</label>
                                    <input type="text" name="accountName" class="form-control aero-input" value="${pm.accountName}">
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-muted mb-1">Cập nhật Ảnh QR</label>
                                    <input type="hidden" name="oldQrCodeURL" value="${pm.qrCodeURL}">
                                    <input type="file" name="qrCodeFile" class="form-control aero-input" accept="image/*">
                                    <small class="text-muted mt-1 d-block">Để trống nếu muốn giữ nguyên ảnh hiện tại.</small>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 mt-3">
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">ĐÓNG</button>
                            <button type="submit" class="btn btn-money-gradient px-5 shadow-sm">LƯU THAY ĐỔI</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <%-- SCRIPT ĐÃ ĐƯỢC TỐI ƯU SẠCH SẼ --%>
    <script>
        // Đồng hồ thời gian thực
        function updateClock() {
            const now = new Date();
            const clockEl = document.getElementById('digital-clock');
            if (clockEl) {
                clockEl.innerText = now.getHours().toString().padStart(2, '0') + ":" +
                                    now.getMinutes().toString().padStart(2, '0') + ":" +
                                    now.getSeconds().toString().padStart(2, '0');
            }
        }
        setInterval(updateClock, 1000);
        updateClock();

        // Đóng/Mở form Ngân hàng dựa trên việc chọn QR hay không
        function toggleBankInfo(mode, id = '') {
            let selectBox, bankBox;

            if (mode === 'add') {
                selectBox = document.getElementById('addMethodCode');
                bankBox = document.getElementById('addBankInfoBox');
            } else {
                selectBox = document.getElementById('editCode' + id);
                bankBox = document.getElementById('editBankInfoBox' + id);
            }

            if (selectBox && bankBox) {
                if (selectBox.value === 'QR') {
                    bankBox.style.display = 'flex';
                } else {
                    bankBox.style.display = 'none';
                }
            }
        }

        // Tự động kích hoạt hàm ẩn/hiện form ngay khi trang load xong
        document.addEventListener("DOMContentLoaded", function() {
            toggleBankInfo('add');
        });
    </script>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>