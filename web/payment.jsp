<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.PaymentMethodDAO, model.PaymentMethodDTO, java.util.List"%>

<%
    PaymentMethodDAO pmDAO = new PaymentMethodDAO();
    List<PaymentMethodDTO> listMethods = pmDAO.getAllActive();
    request.setAttribute("listMethods", listMethods);
%>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    .luxury-title { font-family: 'Playfair Display', serif; color: #D4AF37; text-transform: uppercase; letter-spacing: 2px; }
    .text-gold { color: #D4AF37 !important; }

    .payment-container {
        background: linear-gradient(145deg, #141414, #0d0d0d); border: 1px solid rgba(212, 175, 55, 0.3);
        border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.8); padding: 40px;
    }

    .pay-radio { display: none; }
    .pay-method-card {
        border: 2px solid #333; background: #1a1a1a; border-radius: 12px; padding: 20px;
        cursor: pointer; transition: all 0.3s ease; display: flex; align-items: center;
    }
    .pay-method-card:hover { border-color: rgba(212, 175, 55, 0.5); background: #222; }
    .pay-icon { font-size: 2.5rem; color: #aaa; margin-right: 20px; transition: 0.3s; width: 50px; text-align: center; }
    
    .pay-radio:checked + .pay-method-card {
        border-color: #D4AF37; background: rgba(212, 175, 55, 0.05); box-shadow: 0 0 20px rgba(212, 175, 55, 0.2);
    }
    .pay-radio:checked + .pay-method-card .pay-icon { color: #D4AF37; }
    .pay-radio:checked + .pay-method-card .check-circle { background: #D4AF37; color: #000; border-color: #D4AF37; }

    .check-circle {
        width: 25px; height: 25px; border-radius: 50%; border: 2px solid #555;
        margin-left: auto; display: flex; align-items: center; justify-content: center; color: transparent; transition: 0.3s;
    }

    .form-dark { background: rgba(0, 0, 0, 0.5) !important; border: 1px solid rgba(212, 175, 55, 0.3) !important; color: #fff !important; }
    .form-dark:focus { border-color: #D4AF37 !important; box-shadow: 0 0 10px rgba(212, 175, 55, 0.2) !important; }
    .form-dark::placeholder { color: rgba(255, 255, 255, 0.3); }

    /* Custom CSS cho thẻ Select Option (Dropdown) */
    .custom-select-qr {
        background-color: #1a1a1a;
        color: #D4AF37;
        font-weight: 600;
        font-size: 1.1rem;
        padding: 12px 20px;
        border: 2px solid #D4AF37;
        border-radius: 10px;
        cursor: pointer;
    }
    .custom-select-qr option { background-color: #111; color: #fff; }

    .btn-luxury {
        background: linear-gradient(45deg, #B8860B, #FFD700, #B8860B); background-size: 200% auto; color: #000 !important; font-weight: 700; text-transform: uppercase; border: none; border-radius: 50px; transition: 0.5s;
    }
    .btn-luxury:hover { background-position: right center; transform: translateY(-3px); box-shadow: 0 0 30px rgba(212, 175, 55, 0.8); }
</style>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <h2 class="luxury-title text-center mb-4">CỔNG THANH TOÁN F-AUTO</h2>
            
            <div class="payment-container">
                <div class="d-flex justify-content-between border-bottom border-secondary pb-3 mb-4">
                    <span class="fs-5 text-light">Mã hợp đồng:</span>
                    <span class="fs-5 fw-bold text-white">#${param.orderId != null ? param.orderId : 'FAUTO-XXX'}</span>
                </div>

                <h5 class="fw-bold text-gold mb-4">CHỌN PHƯƠNG THỨC THANH TOÁN</h5>
                
                <form action="OrderController" method="POST">
                    <input type="hidden" name="action" value="processPayment">
                    <input type="hidden" name="orderId" value="${param.orderId}">
                    
                    <%-- BIẾN ẨN LƯU ID PHƯƠNG THỨC CUỐI CÙNG ĐỂ GỬI VỀ CONTROLLER --%>
                    <input type="hidden" name="paymentMethod" id="finalPaymentMethod" value="">
                    
                    <%-- KIỂM TRA XEM CÓ TỒN TẠI PHƯƠNG THỨC QR NÀO KHÔNG ĐỂ TẠO NHÓM CHUNG --%>
                    <c:set var="hasQR" value="false" />
                    <c:forEach var="method" items="${listMethods}">
                        <c:if test="${method.methodCode == 'QR'}"><c:set var="hasQR" value="true" /></c:if>
                    </c:forEach>

                    <%-- 1. NÚT GOM NHÓM: CHUYỂN KHOẢN NGÂN HÀNG (Nếu có ít nhất 1 mã QR) --%>
                    <c:if test="${hasQR}">
                        <label class="d-block mb-3">
                            <%-- Lưu ý: name của thẻ radio giờ là ui_selector, nó chỉ dùng để điều khiển UI --%>
                            <input type="radio" name="ui_selector" value="GROUP_QR" class="pay-radio" checked>
                            <div class="pay-method-card">
                                <i class="fa-solid fa-qrcode pay-icon"></i>
                                <div>
                                    <h5 class="mb-1 fw-bold text-white">Chuyển khoản / Quét mã QR</h5>
                                    <small class="text-muted">Lựa chọn các Ngân hàng hoặc Ví điện tử.</small>
                                </div>
                                <div class="check-circle"><i class="fa-solid fa-check fs-6"></i></div>
                            </div>
                        </label>
                    </c:if>

                    <%-- 2. CÁC NÚT CHO PHƯƠNG THỨC KHÁC (THẺ VISA, TIỀN MẶT...) --%>
                    <c:forEach var="method" items="${listMethods}">
                        <c:if test="${method.methodCode != 'QR'}">
                            <label class="d-block mb-3">
                                <input type="radio" name="ui_selector" value="${method.methodID}" data-code="${method.methodCode}" class="pay-radio" ${!hasQR && loop.first ? 'checked' : ''}>
                                <div class="pay-method-card">
                                    <i class="${not empty method.iconClass ? method.iconClass : 'fa-solid fa-money-check-dollar'} pay-icon"></i>
                                    <div>
                                        <h5 class="mb-1 fw-bold text-white">${method.methodName}</h5>
                                        <small class="text-muted">${method.description}</small>
                                    </div>
                                    <div class="check-circle"><i class="fa-solid fa-check fs-6"></i></div>
                                </div>
                            </label>
                        </c:if>
                    </c:forEach>


                    <%-- ======================================================= --%>
                    <%-- KHU VỰC HIỂN THỊ CHI TIẾT TƯƠNG ỨNG VỚI NÚT ĐƯỢC CHỌN   --%>
                    <%-- ======================================================= --%>
                    <div id="dynamic-payment-section" class="mb-5 pt-4 border-top border-secondary">
                        
                        <%-- KHUNG A: DÀNH RIÊNG CHO NHÓM CHUYỂN KHOẢN (GROUP_QR) --%>
                        <c:if test="${hasQR}">
                            <div id="pane-GROUP_QR" class="payment-info-pane">
                                
                                <%-- THẺ SELECT ĐỂ KHÁCH CHỌN NGÂN HÀNG --%>
                                <div class="mb-4 text-center">
                                    <label class="form-label text-muted small fw-bold">Chọn ngân hàng thụ hưởng:</label>
                                    <select id="qrBankSelector" class="form-select custom-select-qr shadow-sm mx-auto" style="max-width: 380px;">
                                        <c:forEach var="method" items="${listMethods}">
                                            <c:if test="${method.methodCode == 'QR'}">
                                                <option value="${method.methodID}">${method.bankName} - ${method.methodName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>

                                <%-- TẠO CÁC KHUNG CHỨA ẢNH QR & STK (Sẽ dùng JS để ẩn/hiện theo Select ở trên) --%>
                                <c:forEach var="method" items="${listMethods}">
                                    <c:if test="${method.methodCode == 'QR'}">
                                        <div id="qr-detail-box-${method.methodID}" class="qr-detail-box text-center" style="display: none;">
                                            <div class="bg-light p-3 rounded-3 d-inline-block border border-warning mb-3">
                                                <img src="${not empty method.qrCodeURL ? method.qrCodeURL : 'IMG/qr-sample.png'}" alt="QR Code" style="width: 200px; height: 200px; object-fit: contain; border-radius: 8px;">
                                            </div>
                                            <div class="text-start mx-auto p-3 shadow" style="max-width: 380px; background: rgba(255,255,255,0.05); border-radius: 10px;">
                                                <p class="mb-1 text-light">Ngân hàng: <strong class="text-white fs-6">${method.bankName}</strong></p>
                                                <p class="mb-1 text-light">Số tài khoản: <strong class="text-gold fs-5">${method.accountNo}</strong></p>
                                                <p class="mb-1 text-light">Chủ tài khoản: <strong class="text-white text-uppercase">${method.accountName}</strong></p>
                                                <div class="mt-3 pt-3 border-top border-secondary text-center">
                                                    <p class="mb-0 text-light small">Nội dung chuyển khoản:</p>
                                                    <h4 class="text-warning fw-bold mt-1 mb-0" style="letter-spacing: 1px;">FAUTO ${param.orderId}</h4>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>


                        <%-- KHUNG B: DÀNH CHO CÁC PHƯƠNG THỨC KHÁC (THẺ VISA, TIỀN MẶT...) --%>
                        <c:forEach var="method" items="${listMethods}">
                            <c:if test="${method.methodCode != 'QR'}">
                                <div id="pane-${method.methodID}" class="payment-info-pane" style="display: none;">
                                    
                                    <c:choose>
                                        <%-- Form nhập thẻ --%>
                                        <c:when test="${method.methodCode == 'CARD'}">
                                            <h6 class="text-gold mb-3 fw-bold">THÔNG TIN THẺ (${method.methodName})</h6>
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label class="form-label text-muted small">Tên in trên thẻ</label>
                                                    <input type="text" class="form-control form-dark card-input-req" placeholder="NGUYEN VAN A">
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label text-muted small">Số thẻ</label>
                                                    <input type="text" class="form-control form-dark card-input-req" placeholder="0000 0000 0000 0000">
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label text-muted small">Ngày hết hạn</label>
                                                    <input type="text" class="form-control form-dark card-input-req" placeholder="MM/YY">
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label text-muted small">Mã CVV</label>
                                                    <input type="password" class="form-control form-dark card-input-req" placeholder="123">
                                                </div>
                                            </div>
                                        </c:when>

                                        <%-- Tiền mặt --%>
                                        <c:when test="${method.methodCode == 'CASH'}">
                                            <div class="alert alert-dark border-secondary text-center text-light mb-0 p-4">
                                                <i class="fa-solid fa-money-bill-1-wave text-warning mb-3" style="font-size: 3rem;"></i><br>
                                                Giao dịch sẽ được ghi nhận là <strong>Thanh toán sau</strong>.<br>Vui lòng chuẩn bị sẵn tiền mặt khi đến Showroom F-AUTO.
                                            </div>
                                        </c:when>
                                    </c:choose>

                                </div>
                            </c:if>
                        </c:forEach>

                    </div>

                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-luxury btn-lg py-3 shadow-lg fs-5">
                            <i class="fa-solid fa-shield-halved me-2"></i> XÁC NHẬN THANH TOÁN
                        </button>
                        <a href="javascript:history.back()" class="btn btn-outline-secondary mt-2 border-0 rounded-pill">Quay lại chi tiết</a>
                    </div>
                </form>

            </div>
            
            <div class="text-center mt-4 text-muted small">
                <i class="fa-solid fa-lock text-success me-1"></i> Giao dịch của bạn được mã hóa bảo mật 256-bit SSL.
            </div>
        </div>
    </div>
</div>

<%-- SCRIPT BỘ NÃO ĐIỀU KHIỂN GIAO DIỆN --%>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const radios = document.querySelectorAll('.pay-radio');
        const allPanes = document.querySelectorAll('.payment-info-pane');
        const allQrDetails = document.querySelectorAll('.qr-detail-box');
        const cardInputs = document.querySelectorAll('.card-input-req');
        const hiddenFinalInput = document.getElementById('finalPaymentMethod');
        const qrBankSelector = document.getElementById('qrBankSelector');

        function updatePaymentView() {
            // 1. Ẩn toàn bộ khung thông tin và tắt Required của thẻ
            allPanes.forEach(pane => pane.style.display = 'none');
            cardInputs.forEach(input => input.required = false);

            // 2. Tìm nút radio lớn đang được tick
            const checkedRadio = document.querySelector('.pay-radio:checked');
            if(checkedRadio) {
                const selectedVal = checkedRadio.value; // Là "GROUP_QR" hoặc ID của Card/Cash
                const selectedCode = checkedRadio.getAttribute('data-code'); 
                
                // 3. Hiển thị khung to tương ứng
                const targetPane = document.getElementById('pane-' + selectedVal);
                if (targetPane) targetPane.style.display = 'block';
                
                // 4. Xử lý Logic gán ID cuối cùng để nộp Form
                if (selectedVal === 'GROUP_QR') {
                    // Nếu chọn nhóm QR, ID thực sự sẽ lấy từ cái Dropdown Ngân hàng
                    if(qrBankSelector) {
                        hiddenFinalInput.value = qrBankSelector.value;
                        
                        // Ẩn tất cả ảnh QR cũ, chỉ hiện cái QR của Ngân hàng đang chọn trong Dropdown
                        allQrDetails.forEach(box => box.style.display = 'none');
                        const activeQrBox = document.getElementById('qr-detail-box-' + qrBankSelector.value);
                        if(activeQrBox) activeQrBox.style.display = 'block';
                    }
                } else {
                    // Nếu chọn thẻ hoặc tiền mặt, ID chính là value của nút radio đó luôn
                    hiddenFinalInput.value = selectedVal;
                    
                    // Nếu là form Thẻ, bật bắt buộc nhập
                    if (selectedCode === 'CARD') {
                        cardInputs.forEach(input => input.required = true);
                    }
                }
            }
        }

        // Bắt sự kiện khi click đổi các Radio lớn (QR chung, Thẻ, Tiền mặt)
        radios.forEach(radio => radio.addEventListener('change', updatePaymentView));
        
        // Bắt sự kiện khi khách xổ Dropdown chọn Ngân hàng khác
        if(qrBankSelector) {
            qrBankSelector.addEventListener('change', updatePaymentView);
        }
        
        // Kích hoạt hàm ngay khi vừa tải trang xong
        if(document.querySelector('.pay-radio:checked')) {
            updatePaymentView(); 
        }
    });
</script>

<jsp:include page="includes/footer.jsp"></jsp:include>