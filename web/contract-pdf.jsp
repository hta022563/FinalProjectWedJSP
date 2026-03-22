<%-- 
    Document   : contract-pdf
    Created on : Mar 13, 2026, 1:41:46 PM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hợp Đồng Mua Bán - F-AUTO (#${contractOrder.orderID})</title>
    
    <link rel="icon" href="IMG/logo.jpg" type="image/jpeg">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@700&display=swap" rel="stylesheet">
    
    <style>
        
        body { 
            background: #e9ecef; 
            color: #000; 
            font-family: "Times New Roman", Times, serif; 
            font-size: 13pt; /* Cỡ chữ chuẩn hợp đồng */
        }
        
        .contract-paper { 
            background: #fff;
            width: 100%; 
            max-width: 210mm; /* Kích thước chuẩn A4 */
            min-height: 297mm;
            margin: 20px auto; 
            padding: 20mm 15mm; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .logo-text { font-size: 20px; font-weight: bold; letter-spacing: 1px; color: #000; }
        
        
        .table-contract th, .table-contract td { 
            border: 1px solid #000 !important; 
            padding: 10px;
            vertical-align: middle;
        }
        .table-contract thead th { background-color: #f8f9fa !important; }

        
        .stamp-container {
            position: relative;
            display: inline-block;
            width: 200px;
            height: 150px;
        }
        .stamp-logo {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px; 
            height: 100px; 
            border-radius: 50%; 
            opacity: 0.15; /* Làm mờ để làm dấu chìm */
            object-fit: cover;
            z-index: 1;
        }
        .signature-text {
            font-family: 'Caveat', cursive; /* Font chữ ký tay */
            font-size: 2rem;
            color: #dc3545 !important;
            transform: rotate(-10deg);
            position: absolute;
            top: 50px;
            left: 10px;
            z-index: 2;
        }

        
        @media print {
            @page { margin: 0; size: A4; }
            body { background: #fff; margin: 0; padding: 0; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .contract-paper { box-shadow: none; margin: 0; padding: 15mm; min-height: auto; }
            .no-print { display: none !important; }
        }
    </style>
</head>
<body onload="window.print()">

    <div class="no-print text-center bg-dark p-3 text-white sticky-top shadow">
        <h5 class="mb-2 text-warning fw-bold"><i class="fa-solid fa-print"></i> TRÌNH XUẤT BẢN HỢP ĐỒNG F-AUTO</h5>
        <p class="mb-3 small">Vui lòng chọn <b>"Lưu dưới dạng PDF" (Save as PDF)</b> trong cửa sổ in vừa hiện ra.</p>
        <button onclick="window.print()" class="btn btn-warning fw-bold px-4 me-2">Tải xuống / In Hợp Đồng</button>
        <button onclick="window.close()" class="btn btn-outline-light fw-bold px-4">Đóng cửa sổ</button>
    </div>

    <div class="contract-paper">
        
        <div class="row align-items-start mb-4">
            <div class="col-5 text-center">
                <div class="d-flex align-items-center justify-content-center">
                    <img src="IMG/logo.jpg" alt="Logo" style="width: 50px; height: 50px; border-radius: 50%; border: 1px solid #000; object-fit: cover; margin-right: 10px;">
                    <div>
                        <div class="logo-text">F-AUTO GROUP</div>
                        <div style="border-top: 1px solid #000; width: 100%; margin: 2px 0;"></div>
                        <small class="fw-bold">Số: ${contractOrder.orderID}/HĐMB-FAUTO</small>
                    </div>
                </div>
            </div>
            <div class="col-7 text-center">
                <h5 class="fw-bold mb-1">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h5>
                <h6 class="fw-bold" style="text-decoration: underline;">Độc lập - Tự do - Hạnh phúc</h6>
                <div class="fst-italic mt-2" style="font-size: 11pt;">
                    TP. Hồ Chí Minh, ngày <fmt:formatDate value="${contractOrder.orderDate}" pattern="dd" /> tháng <fmt:formatDate value="${contractOrder.orderDate}" pattern="MM" /> năm <fmt:formatDate value="${contractOrder.orderDate}" pattern="yyyy" />
                </div>
            </div>
        </div>

        <h2 class="fw-bold text-center mt-5 mb-5" style="letter-spacing: 1px;">HỢP ĐỒNG MUA BÁN PHƯƠNG TIỆN</h2>

        <div class="mb-4">
            <p class="fw-bold text-uppercase mb-2">BÊN BÁN (BÊN A): CÔNG TY TNHH PHÂN PHỐI SIÊU XE F-AUTO</p>
            <p class="mb-1">- <b>Đại diện:</b> Ông/Bà Giám Đốc F-AUTO</p>
            <p class="mb-1">- <b>Trụ sở chính:</b> Khu Công Nghệ Cao, TP. Thủ Đức, TP. Hồ Chí Minh.</p>
            <p class="mb-1">- <b>Điện thoại:</b> 1900 9999 (Hotline VIP)</p>
            <p class="mb-1">- <b>Mã số thuế:</b> 0123456789</p>
        </div>

        <div class="mb-4">
            <p class="fw-bold text-uppercase mb-2">BÊN MUA (BÊN B): ÔNG/BÀ ${sessionScope.user.fullName}</p>
            <p class="mb-1">- <b>Điện thoại:</b> ${sessionScope.user.phone != null ? sessionScope.user.phone : "..........................................."}</p>
            <p class="mb-1">- <b>Email:</b> ${sessionScope.user.email != null ? sessionScope.user.email : "..........................................."}</p>
            <p class="mb-1">- <b>Nơi nhận bàn giao xe:</b> ${contractOrder.shippingAddress}</p>
        </div>

        <p class="mb-3 mt-4">Hôm nay, thông qua hệ thống thương mại điện tử F-AUTO, hai bên thống nhất ký kết hợp đồng mua bán phương tiện với chi tiết như sau:</p>

        <table class="table table-contract text-center w-100 mb-4">
            <thead>
                <tr>
                    <th style="width: 8%;">STT</th> 
                    <th style="width: 40%; text-align: left;">Tên Phương Tiện / Thuộc Tính</th> 
                    <th style="width: 12%;">Số Lượng</th> 
                    <th style="width: 20%;">Đơn Giá (VNĐ)</th> 
                    <th style="width: 20%;">Thành Tiền (VNĐ)</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="count" value="1"/>
                <c:forEach var="item" items="${listDetails}">
                    <tr>
                        <td>${count}</td>
                        <td class="text-start">
                            <b>${productNames[item.productID]}</b><br>
                            <small>Mã Hệ Thống: SP00${item.productID}</small>
                        </td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.unitPrice}" type="number" pattern="#,###"/></td>
                        <td class="fw-bold"><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" pattern="#,###"/></td>
                    </tr>
                    <c:set var="count" value="${count + 1}"/>
                </c:forEach>
                <tr>
                    <td colspan="4" class="text-end fw-bold">TỔNG GIÁ TRỊ HỢP ĐỒNG (Đã bao gồm VAT):</td>
                    <td class="fw-bold fs-6"><fmt:formatNumber value="${contractOrder.totalAmount}" type="number" pattern="#,###"/></td>
                </tr>
            </tbody>
        </table>

        <div class="mb-5">
            <p class="fw-bold mb-2">ĐIỀU KHOẢN THỎA THUẬN:</p>
            <ol style="line-height: 1.6; text-align: justify; padding-left: 20px;">
                <li>Bên A cam kết bàn giao phương tiện mới 100%, đúng theo thông số kỹ thuật đã công bố trên hệ thống và đầy đủ phụ kiện kèm theo.</li>
                <li>Bên B có nghĩa vụ thanh toán đầy đủ giá trị hợp đồng trước hoặc ngay tại thời điểm nhận bàn giao xe.</li>
                <li>Hợp đồng này được tạo và phê duyệt tự động từ Hệ Thống Quản Trị F-AUTO, có giá trị pháp lý tương đương bản cứng (Theo Luật Giao dịch điện tử 2023).</li>
            </ol>
        </div>

        <div class="row text-center mt-5">
            <div class="col-6">
                <p class="fw-bold mb-5">ĐẠI DIỆN BÊN MUA</p>
                <p class="mt-5 pt-4 fst-italic">(Ký và ghi rõ họ tên)</p>
                <p class="fw-bold mt-2 text-uppercase">${sessionScope.user.fullName}</p>
            </div>
            <div class="col-6">
                <p class="fw-bold mb-2">ĐẠI DIỆN BÊN BÁN</p>
                
                <div class="stamp-container">
                    <img src="IMG/logo.jpg" class="stamp-logo" alt="Stamp">
                    <span class="signature-text">F-AUTO Approved</span>
                </div>
                
                <p class="fw-bold mt-2">HỆ THỐNG SHOWROOM F-AUTO</p>
            </div>
        </div>

    </div>
</body>
</html>