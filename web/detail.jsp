<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="model.ReviewDAO, model.ReviewDTO, java.util.List"%>

<%
   
    String carIdStr = request.getParameter("id");
    if (carIdStr == null || carIdStr.trim().isEmpty() || carIdStr.equalsIgnoreCase("null")) {
        carIdStr = request.getParameter("pid");
    }
    
    int cId = 1;
    try {
        if (carIdStr != null && !carIdStr.trim().isEmpty() && !carIdStr.equalsIgnoreCase("null")) {
            cId = Integer.parseInt(carIdStr.trim());
        }
    } catch (Exception e) {
        cId = 1; 
    }

    ReviewDAO reviewDAO = new ReviewDAO();
    List<ReviewDTO> reviewList = reviewDAO.getReviewsByProduct(cId);
    request.setAttribute("reviewList", reviewList);
    request.setAttribute("reviewDAO", reviewDAO);
%>

<%-- PHÂN TÍCH CATEGORY & SUPPLIER TỪ DB --%>
<c:choose>
    <c:when test="${product.categoryID == 1}"><c:set var="catName" value="Sedan Cao Cấp" /></c:when>
    <c:when test="${product.categoryID == 2}"><c:set var="catName" value="Siêu Xe Thể Thao" /></c:when>
    <c:when test="${product.categoryID == 3}"><c:set var="catName" value="SUV & CUV" /></c:when>
    <c:when test="${product.categoryID == 4}"><c:set var="catName" value="Bán Tải" /></c:when>
    <c:when test="${product.categoryID == 5}"><c:set var="catName" value="MPV Đa Dụng" /></c:when>
    <c:when test="${product.categoryID == 6}"><c:set var="catName" value="Phụ Tùng / Phụ Kiện" /></c:when>
    <c:otherwise><c:set var="catName" value="Phiên bản Đặc Biệt" /></c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${product.supplierID == 1}"><c:set var="supName" value="Toyota" /></c:when>
    <c:when test="${product.supplierID == 2}"><c:set var="supName" value="Honda" /></c:when>
    <c:when test="${product.supplierID == 3}"><c:set var="supName" value="Mercedes-Benz" /></c:when>
    <c:when test="${product.supplierID == 4}"><c:set var="supName" value="BMW" /></c:when>
    <c:when test="${product.supplierID == 5}"><c:set var="supName" value="Porsche" /></c:when>
    <c:when test="${product.supplierID == 6}"><c:set var="supName" value="Lexus" /></c:when>
    <c:when test="${product.supplierID == 7}"><c:set var="supName" value="Ford" /></c:when>
    <c:when test="${product.supplierID == 11}"><c:set var="supName" value="Audi" /></c:when>
    <c:when test="${product.supplierID == 12}"><c:set var="supName" value="Mitsubishi" /></c:when>
    <c:when test="${product.supplierID == 10}"><c:set var="supName" value="Kia" /></c:when>
    <c:otherwise><c:set var="supName" value="Nhà Cung Cấp F-AUTO" /></c:otherwise>
</c:choose>

<c:set var="pName" value="${fn:toLowerCase(product.productName)}" />

<c:set var="spec_engine" value="Vui lòng liên hệ Hotline" />
<c:set var="spec_hp" value="Đang cập nhật" />
<c:set var="spec_torque" value="Đang cập nhật" />
<c:set var="spec_0100" value="Đang cập nhật" />
<c:set var="spec_speed" value="Đang cập nhật" />
<c:set var="spec_dim" value="Đang cập nhật" />
<c:set var="spec_weight" value="Đang cập nhật" />
<c:set var="spec_drive" value="Đang cập nhật" />
<c:set var="spec_gear" value="Tự động" />

<c:choose>
    <%-- CATEGORY 1: SEDAN --%>
    <c:when test="${fn:contains(pName, 'camry')}">
        <c:set var="spec_engine" value="2.5L Dynamic Force I4" /><c:set var="spec_hp" value="207 mã lực" /><c:set var="spec_torque" value="250 Nm" /><c:set var="spec_0100" value="8.5 giây" /><c:set var="spec_speed" value="210 km/h" /><c:set var="spec_dim" value="4885 x 1840 x 1445 mm" /><c:set var="spec_weight" value="1550 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Tự động 8 cấp (8AT)" />
    </c:when>
    <c:when test="${fn:contains(pName, 'city')}">
        <c:set var="spec_engine" value="1.5L i-VTEC I4" /><c:set var="spec_hp" value="119 mã lực" /><c:set var="spec_torque" value="145 Nm" /><c:set var="spec_0100" value="10.0 giây" /><c:set var="spec_speed" value="190 km/h" /><c:set var="spec_dim" value="4580 x 1748 x 1467 mm" /><c:set var="spec_weight" value="1133 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Vô cấp CVT" />
    </c:when>
    <c:when test="${fn:contains(pName, 's 450') || fn:contains(pName, 's450')}">
        <c:set var="spec_engine" value="3.0L I6 Mild-Hybrid" /><c:set var="spec_hp" value="367 mã lực" /><c:set var="spec_torque" value="500 Nm" /><c:set var="spec_0100" value="5.3 giây" /><c:set var="spec_speed" value="250 km/h" /><c:set var="spec_dim" value="5300 x 1937 x 1503 mm" /><c:set var="spec_weight" value="2015 kg" /><c:set var="spec_drive" value="RWD (Cầu sau)" /><c:set var="spec_gear" value="9G-TRONIC" />
    </c:when>
    <c:when test="${fn:contains(pName, '330i')}">
        <c:set var="spec_engine" value="2.0L TwinPower Turbo" /><c:set var="spec_hp" value="258 mã lực" /><c:set var="spec_torque" value="400 Nm" /><c:set var="spec_0100" value="5.8 giây" /><c:set var="spec_speed" value="250 km/h" /><c:set var="spec_dim" value="4709 x 1827 x 1435 mm" /><c:set var="spec_weight" value="1545 kg" /><c:set var="spec_drive" value="RWD (Cầu sau)" /><c:set var="spec_gear" value="8 cấp Steptronic" />
    </c:when>
    <c:when test="${fn:contains(pName, 'c300') || fn:contains(pName, 'c 300')}">
        <c:set var="spec_engine" value="2.0L Turbo Mild-Hybrid" /><c:set var="spec_hp" value="258 mã lực" /><c:set var="spec_torque" value="400 Nm" /><c:set var="spec_0100" value="6.0 giây" /><c:set var="spec_speed" value="250 km/h" /><c:set var="spec_dim" value="4751 x 1820 x 1438 mm" /><c:set var="spec_weight" value="1675 kg" /><c:set var="spec_drive" value="RWD (Cầu sau)" /><c:set var="spec_gear" value="9G-TRONIC" />
    </c:when>

    <%-- CATEGORY 2: SPORT --%>
    <c:when test="${fn:contains(pName, 'type r')}">
        <c:set var="spec_engine" value="2.0L VTEC Turbo" /><c:set var="spec_hp" value="315 mã lực" /><c:set var="spec_torque" value="420 Nm" /><c:set var="spec_0100" value="5.4 giây" /><c:set var="spec_speed" value="272 km/h" /><c:set var="spec_dim" value="4593 x 1890 x 1407 mm" /><c:set var="spec_weight" value="1434 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Số sàn 6 cấp (6MT)" />
    </c:when>
    <c:when test="${fn:contains(pName, '911')}">
        <c:set var="spec_engine" value="3.0L Flat-6 Twin-Turbo" /><c:set var="spec_hp" value="450 mã lực" /><c:set var="spec_torque" value="530 Nm" /><c:set var="spec_0100" value="3.7 giây" /><c:set var="spec_speed" value="308 km/h" /><c:set var="spec_dim" value="4519 x 1852 x 1300 mm" /><c:set var="spec_weight" value="1515 kg" /><c:set var="spec_drive" value="RWD (Cầu sau)" /><c:set var="spec_gear" value="Ly hợp kép 8 cấp PDK" />
    </c:when>
    <c:when test="${fn:contains(pName, 'r8')}">
        <c:set var="spec_engine" value="5.2L V10 FSI Hút khí tự nhiên" /><c:set var="spec_hp" value="620 mã lực" /><c:set var="spec_torque" value="580 Nm" /><c:set var="spec_0100" value="3.1 giây" /><c:set var="spec_speed" value="331 km/h" /><c:set var="spec_dim" value="4429 x 1940 x 1236 mm" /><c:set var="spec_weight" value="1595 kg" /><c:set var="spec_drive" value="AWD (Quattro)" /><c:set var="spec_gear" value="Ly hợp kép 7 cấp S tronic" />
    </c:when>

    <%-- CATEGORY 3: SUV & CUV --%>
    <c:when test="${fn:contains(pName, 'fortuner')}">
        <c:set var="spec_engine" value="2.8L Diesel Turbo" /><c:set var="spec_hp" value="201 mã lực" /><c:set var="spec_torque" value="500 Nm" /><c:set var="spec_0100" value="10.5 giây" /><c:set var="spec_speed" value="180 km/h" /><c:set var="spec_dim" value="4795 x 1855 x 1835 mm" /><c:set var="spec_weight" value="2135 kg" /><c:set var="spec_drive" value="4WD (2 cầu bán thời gian)" /><c:set var="spec_gear" value="Tự động 6 cấp" />
    </c:when>
    <c:when test="${fn:contains(pName, 'cross')}">
        <c:set var="spec_engine" value="1.8L Xăng lai Điện (Hybrid)" /><c:set var="spec_hp" value="122 mã lực (Tổng)" /><c:set var="spec_torque" value="142 Nm" /><c:set var="spec_0100" value="11.0 giây" /><c:set var="spec_speed" value="170 km/h" /><c:set var="spec_dim" value="4460 x 1825 x 1620 mm" /><c:set var="spec_weight" value="1410 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Vô cấp e-CVT" />
    </c:when>
    <c:when test="${fn:contains(pName, 'cr-v') || fn:contains(pName, 'crv')}">
        <c:set var="spec_engine" value="1.5L VTEC Turbo" /><c:set var="spec_hp" value="188 mã lực" /><c:set var="spec_torque" value="240 Nm" /><c:set var="spec_0100" value="9.0 giây" /><c:set var="spec_speed" value="200 km/h" /><c:set var="spec_dim" value="4691 x 1866 x 1681 mm" /><c:set var="spec_weight" value="1673 kg" /><c:set var="spec_drive" value="AWD (4 bánh toàn thời gian)" /><c:set var="spec_gear" value="Vô cấp CVT" />
    </c:when>
    <c:when test="${fn:contains(pName, 'rx 350') || fn:contains(pName, 'rx350')}">
        <c:set var="spec_engine" value="2.4L Turbocharged" /><c:set var="spec_hp" value="275 mã lực" /><c:set var="spec_torque" value="430 Nm" /><c:set var="spec_0100" value="7.6 giây" /><c:set var="spec_speed" value="200 km/h" /><c:set var="spec_dim" value="4890 x 1920 x 1695 mm" /><c:set var="spec_weight" value="2035 kg" /><c:set var="spec_drive" value="AWD (Direct4)" /><c:set var="spec_gear" value="Tự động 8 cấp" />
    </c:when>
    <c:when test="${fn:contains(pName, 'glc')}">
        <c:set var="spec_engine" value="2.0L Turbo Mild-Hybrid" /><c:set var="spec_hp" value="258 mã lực" /><c:set var="spec_torque" value="400 Nm" /><c:set var="spec_0100" value="6.2 giây" /><c:set var="spec_speed" value="240 km/h" /><c:set var="spec_dim" value="4716 x 1890 x 1640 mm" /><c:set var="spec_weight" value="1925 kg" /><c:set var="spec_drive" value="AWD (4MATIC)" /><c:set var="spec_gear" value="9G-TRONIC" />
    </c:when>
    <c:when test="${fn:contains(pName, 'x5')}">
        <c:set var="spec_engine" value="3.0L I6 TwinPower Turbo" /><c:set var="spec_hp" value="381 mã lực" /><c:set var="spec_torque" value="520 Nm" /><c:set var="spec_0100" value="5.4 giây" /><c:set var="spec_speed" value="250 km/h" /><c:set var="spec_dim" value="4935 x 2004 x 1765 mm" /><c:set var="spec_weight" value="2165 kg" /><c:set var="spec_drive" value="AWD (xDrive)" /><c:set var="spec_gear" value="8 cấp Steptronic" />
    </c:when>
    <c:when test="${fn:contains(pName, 'g63')}">
        <c:set var="spec_engine" value="4.0L V8 Bi-Turbo" /><c:set var="spec_hp" value="585 mã lực" /><c:set var="spec_torque" value="850 Nm" /><c:set var="spec_0100" value="4.5 giây" /><c:set var="spec_speed" value="220 km/h" /><c:set var="spec_dim" value="4873 x 1984 x 1966 mm" /><c:set var="spec_weight" value="2560 kg" /><c:set var="spec_drive" value="AWD (4MATIC)" /><c:set var="spec_gear" value="AMG SPEEDSHIFT 9G" />
    </c:when>

    <%-- CATEGORY 4: BÁN TẢI --%>
    <c:when test="${fn:contains(pName, 'raptor')}">
        <c:set var="spec_engine" value="3.0L V6 Twin-Turbo" /><c:set var="spec_hp" value="392 mã lực" /><c:set var="spec_torque" value="583 Nm" /><c:set var="spec_0100" value="6.5 giây" /><c:set var="spec_speed" value="180 km/h" /><c:set var="spec_dim" value="5381 x 2028 x 1922 mm" /><c:set var="spec_weight" value="2475 kg" /><c:set var="spec_drive" value="4WD (2 cầu thông minh)" /><c:set var="spec_gear" value="Tự động 10 cấp" />
    </c:when>
    <c:when test="${fn:contains(pName, 'wildtrak')}">
        <c:set var="spec_engine" value="2.0L Bi-Turbo Diesel" /><c:set var="spec_hp" value="210 mã lực" /><c:set var="spec_torque" value="500 Nm" /><c:set var="spec_0100" value="10.0 giây" /><c:set var="spec_speed" value="180 km/h" /><c:set var="spec_dim" value="5362 x 1918 x 1875 mm" /><c:set var="spec_weight" value="2274 kg" /><c:set var="spec_drive" value="4WD (2 cầu điện tử)" /><c:set var="spec_gear" value="Tự động 10 cấp" />
    </c:when>
    <c:when test="${fn:contains(pName, 'triton')}">
        <c:set var="spec_engine" value="2.4L MIVEC Diesel Turbo" /><c:set var="spec_hp" value="181 mã lực" /><c:set var="spec_torque" value="430 Nm" /><c:set var="spec_0100" value="10.4 giây" /><c:set var="spec_speed" value="175 km/h" /><c:set var="spec_dim" value="5305 x 1815 x 1795 mm" /><c:set var="spec_weight" value="1930 kg" /><c:set var="spec_drive" value="4WD (Super Select 4WD-II)" /><c:set var="spec_gear" value="Tự động 6 cấp" />
    </c:when>

    <%-- CATEGORY 5: MPV --%>
    <c:when test="${fn:contains(pName, 'carnival')}">
        <c:set var="spec_engine" value="2.2L Smartstream Diesel" /><c:set var="spec_hp" value="199 mã lực" /><c:set var="spec_torque" value="440 Nm" /><c:set var="spec_0100" value="10.7 giây" /><c:set var="spec_speed" value="190 km/h" /><c:set var="spec_dim" value="5155 x 1995 x 1775 mm" /><c:set var="spec_weight" value="2110 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Tự động 8 cấp" />
    </c:when>
    <c:when test="${fn:contains(pName, 'xpander')}">
        <c:set var="spec_engine" value="1.5L MIVEC" /><c:set var="spec_hp" value="104 mã lực" /><c:set var="spec_torque" value="141 Nm" /><c:set var="spec_0100" value="13.0 giây" /><c:set var="spec_speed" value="170 km/h" /><c:set var="spec_dim" value="4595 x 1750 x 1750 mm" /><c:set var="spec_weight" value="1260 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Tự động 4 cấp (4AT)" />
    </c:when>
    <c:when test="${fn:contains(pName, 'innova')}">
        <c:set var="spec_engine" value="2.0L Hybrid" /><c:set var="spec_hp" value="152 mã lực" /><c:set var="spec_torque" value="188 Nm" /><c:set var="spec_0100" value="10.0 giây" /><c:set var="spec_speed" value="175 km/h" /><c:set var="spec_dim" value="4755 x 1850 x 1795 mm" /><c:set var="spec_weight" value="1615 kg" /><c:set var="spec_drive" value="FWD (Cầu trước)" /><c:set var="spec_gear" value="Vô cấp e-CVT" />
    </c:when>

    <c:when test="${product.categoryID == 1}">
        <c:set var="spec_engine" value="Khối động cơ I4 / V6" /><c:set var="spec_hp" value="Tối ưu hiệu suất" /><c:set var="spec_torque" value="Cân bằng êm ái" /><c:set var="spec_0100" value="7 - 9 giây" /><c:set var="spec_speed" value="200+ km/h" /><c:set var="spec_dim" value="Thiết kế chuẩn Sedan" /><c:set var="spec_weight" value="~ 1500 kg" /><c:set var="spec_drive" value="FWD / RWD" /><c:set var="spec_gear" value="Tự động" />
    </c:when>
    <c:when test="${product.categoryID == 2}">
        <c:set var="spec_engine" value="Động cơ thể thao hiệu năng cao" /><c:set var="spec_hp" value="Khủng" /><c:set var="spec_torque" value="Lực kéo lớn" /><c:set var="spec_0100" value="< 5 giây" /><c:set var="spec_speed" value="250+ km/h" /><c:set var="spec_dim" value="Khí động học tối ưu" /><c:set var="spec_weight" value="Tối giản trọng lượng" /><c:set var="spec_drive" value="RWD / AWD" /><c:set var="spec_gear" value="Ly hợp kép" />
    </c:when>
    <c:when test="${product.categoryID == 3}">
        <c:set var="spec_engine" value="Động cơ SUV đa dụng" /><c:set var="spec_hp" value="Mạnh mẽ" /><c:set var="spec_torque" value="Đạt chuẩn Off-road" /><c:set var="spec_0100" value="8 - 11 giây" /><c:set var="spec_speed" value="180+ km/h" /><c:set var="spec_dim" value="Thiết kế gầm cao" /><c:set var="spec_weight" value="~ 1800 kg" /><c:set var="spec_drive" value="AWD / 4WD" /><c:set var="spec_gear" value="Tự động" />
    </c:when>
</c:choose>


<c:set var="isLiked" value="false" />
<c:if test="${not empty sessionScope.wishlist}">
    <c:forEach var="wId" items="${sessionScope.wishlist}">
        <c:if test="${wId == product.productID}">
            <c:set var="isLiked" value="true" />
        </c:if>
    </c:forEach>
</c:if>

<jsp:include page="includes/header.jsp"></jsp:include>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=Montserrat:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* TRỞ VỀ DARK LUXURY THEME CHÍNH TÔNG */
        body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
        .luxury-title { font-family: 'Playfair Display', serif; color: #D4AF37; letter-spacing: 1px; }
        .text-gold { color: #D4AF37 !important; }
        .premium-panel { background: #111; border: 1px solid rgba(212, 175, 55, 0.15); border-radius: 12px; padding: 40px; box-shadow: 0 15px 40px rgba(0, 0, 0, 0.8); }
        .img-showcase { width: 100%; height: 450px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.05); overflow: hidden; position: relative; }
        .img-showcase img { width: 100%; height: 100%; object-fit: cover; transform: scale(1.15); transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94); }
        .img-showcase:hover img { transform: scale(1.25); }
        .car-title-main { font-size: 2.8rem; font-weight: 800; color: #fff; margin-bottom: 5px; line-height: 1.2; text-transform: uppercase; }
        .car-price-main { font-size: 2.2rem; font-weight: 800; color: #D4AF37; margin-bottom: 25px; text-shadow: 0 0 15px rgba(212, 175, 55, 0.3); }
        .specs-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .spec-item { background: rgba(255,255,255,0.03); border: 1px solid rgba(212, 175, 55, 0.1); padding: 15px 20px; border-radius: 8px; border-left: 3px solid #D4AF37; }
        .spec-lbl { font-size: 0.75rem; color: #888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .spec-val { font-size: 1.1rem; color: #fff; font-weight: 600; }
        .desc-text { color: #aaa; line-height: 1.8; font-size: 1rem; margin-bottom: 30px; text-align: justify; }
        .action-group { display: flex; gap: 15px; }
        .btn-luxury-action { flex-grow: 1; background: linear-gradient(135deg, #D4AF37, #FFD700); color: #000; border: none; padding: 18px; font-size: 1.1rem; font-weight: 800; border-radius: 50px; text-transform: uppercase; letter-spacing: 2px; transition: 0.3s; box-shadow: 0 10px 20px rgba(212, 175, 55, 0.2); }
        .btn-luxury-action:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(212, 175, 55, 0.4); background: #f1c40f; }
        .btn-luxury-action:disabled { filter: grayscale(100%); opacity: 0.6; cursor: not-allowed; transform: none; box-shadow: none; }
        .btn-wishlist { width: 60px; height: 60px; border-radius: 50%; background: transparent; border: 2px solid #D4AF37; color: #D4AF37; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; transition: 0.3s; cursor: pointer; }
        .btn-wishlist:hover { background: #D4AF37; color: #000; transform: translateY(-3px); box-shadow: 0 10px 20px rgba(212, 175, 55, 0.3); }
        .lux-spec-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .lux-spec-table th { background: rgba(255,255,255,0.03); color: #D4AF37; padding: 15px; border-bottom: 1px solid rgba(255,255,255,0.1); width: 35%; text-align: left; font-weight: 600; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 1px; }
        .lux-spec-table td { background: transparent; color: #fff; padding: 15px; border-bottom: 1px solid rgba(255,255,255,0.1); font-weight: 500; font-size: 0.95rem; }
        .lux-spec-table tr:hover td, .lux-spec-table tr:hover th { background: rgba(212, 175, 55, 0.05); }
        .review-box { background: rgba(255,255,255,0.02); border: 1px solid rgba(255,255,255,0.05); padding: 25px; border-radius: 10px; margin-bottom: 15px; }
        .input-dark-luxury { background: #050505 !important; border: 1px solid #333 !important; color: #fff !important; }
        .input-dark-luxury:focus { border-color: #D4AF37 !important; box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25) !important; }
        .swal-lux { border: 1px solid #D4AF37 !important; border-radius: 12px !important; }
    </style>

<c:if test="${not empty msg}">
    <script>
        Swal.fire({
            title: '<span style="font-family: \'Playfair Display\', serif; color: #D4AF37;">THÔNG BÁO!</span>',
            html: '<span style="color: #ccc;">${msg}</span>',
            icon: 'success', iconColor: '#D4AF37', background: '#111',
            customClass: {popup: 'swal-lux', confirmButton: 'btn btn-outline-warning px-5 py-2 rounded-pill fw-bold'},
            buttonsStyling: false, confirmButtonText: 'ĐÓNG'
        });
    </script>
    <c:remove var="msg" />
    <c:remove var="msg" scope="session" />
</c:if>

<div class="container my-5">

    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-gold">Showroom</a></li>
            <li class="breadcrumb-item"><a href="MainController?target=Product" class="text-decoration-none text-secondary">Kho xe</a></li>
            <li class="breadcrumb-item active text-white fw-bold" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <div class="premium-panel mb-5">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <div class="img-showcase">
                    <%-- ĐÃ FIX: Thêm contextPath vào đường dẫn hình ảnh --%>
                    <img src="${pageContext.request.contextPath}/${product.imageURL}" onerror="this.src='${pageContext.request.contextPath}/IMG/logo.jpg'" alt="${product.productName}">
                </div>
            </div>

            <div class="col-lg-6 ps-lg-5">
                <div style="font-family: monospace; color: #666; letter-spacing: 2px; margin-bottom: 10px;">Mã Sản Phẩm: FAUTO-00${product.productID}</div>
                <h1 class="car-title-main">${product.productName}</h1>
                <div class="car-price-main"><fmt:formatNumber value="${product.price}" type="number" pattern="#,###"/> VNĐ</div>

                <div class="specs-grid">
                    <div class="spec-item">
                        <div class="spec-lbl">Thương Hiệu</div>
                        <div class="spec-val"><i class="fa-solid fa-copyright text-gold me-2"></i> ${supName}</div>
                    </div>
                    <div class="spec-item">
                        <div class="spec-lbl">Phân Khúc</div>
                        <div class="spec-val"><i class="fa-solid ${product.categoryID == 6 ? 'fa-box' : 'fa-car-side'} text-gold me-2"></i> ${catName}</div>
                    </div>
                    <div class="spec-item">
                        <div class="spec-lbl">Trạng Thái Kho</div>
                        <div class="spec-val ${product.stockQuantity > 0 ? 'text-success' : 'text-danger'}">
                            <i class="fa-solid fa-warehouse me-2"></i> 
                            <c:choose>
                                <c:when test="${product.stockQuantity > 0}">${product.stockQuantity} sản phẩm</c:when>
                                <c:otherwise>Hết hàng</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="spec-item">
                        <div class="spec-lbl">Chất lượng</div>
                        <div class="spec-val text-white"><i class="fa-solid fa-gem text-gold me-2"></i> Mới 100%</div>
                    </div>
                </div>

                <p class="desc-text">${product.description}</p>

                <div class="action-group">
                    <form action="MainController" method="POST" style="flex-grow: 1;">
                        <input type="hidden" name="target" value="Cart">
                        <input type="hidden" name="action" value="addToCart">
                        <input type="hidden" name="productId" value="${product.productID}">
                        <input type="hidden" name="quantity" value="1">
                        <input type="hidden" name="returnUrl" value="MainController?target=Detail&id=${product.productID}">                        
                        <button type="submit" class="btn-luxury-action" ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fa-solid fa-cart-arrow-down me-2"></i> 
                            ${product.stockQuantity > 0 ? 'THÊM VÀO GIỎ HÀNG' : 'ĐÃ BÁN HẾT'}
                        </button>
                    </form>

                    <form action="MainController" method="POST" title="${isLiked ? 'Bỏ thích' : 'Thêm vào danh sách Yêu thích'}">
                        <input type="hidden" name="target" value="Wishlist">
                        <input type="hidden" name="action" value="${isLiked ? 'remove' : 'add'}">
                        <input type="hidden" name="productId" value="${product.productID}">
                        <input type="hidden" name="returnUrl" value="MainController?target=Detail&id=${product.productID}">
                        <button type="submit" class="btn-wishlist" style="${isLiked ? 'background-color: #D4AF37; color: #000;' : ''}">
                            <i class="${isLiked ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${product.categoryID != 6}">
        <div class="premium-panel mb-5 p-4 p-md-5">
            <h3 class="luxury-title fs-4 border-bottom border-secondary pb-3 mb-4">
                <i class="fa-solid fa-microchip me-2 text-gold"></i> THÔNG SỐ KỸ THUẬT CHI TIẾT
            </h3>
            <div class="row">
                <div class="col-md-6 pe-md-4">
                    <table class="lux-spec-table">
                        <tr><th>Động Cơ (Engine)</th> <td>${spec_engine}</td></tr>
                        <tr><th>Công Suất (Power)</th> <td>${spec_hp}</td></tr>
                        <tr><th>Mô-men Xoắn (Torque)</th> <td>${spec_torque}</td></tr>
                        <tr><th>Hộp Số (Transmission)</th> <td>${spec_gear}</td></tr>
                    </table>
                </div>
                <div class="col-md-6 ps-md-4 mt-4 mt-md-0 border-start border-secondary border-opacity-25">
                    <table class="lux-spec-table">
                        <tr><th>Tăng tốc 0-100 km/h</th> <td>${spec_0100}</td></tr>
                        <tr><th>Tốc Độ Tối Đa</th> <td>${spec_speed}</td></tr>
                        <tr><th>Hệ Dẫn Động</th> <td>${spec_drive}</td></tr>
                        <tr><th>Kích Thước & Khối lượng</th> <td>${spec_dim} <br> <span class="text-muted" style="font-size: 0.8rem;">Trọng lượng: ${spec_weight}</span></td></tr>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <div class="premium-panel p-4 p-md-5">
        <h3 class="luxury-title fs-4 border-bottom border-secondary pb-3 mb-4">
            ĐÁNH GIÁ TỪ KHÁCH HÀNG <span class="badge bg-warning text-dark ms-2 rounded-pill fs-6">${reviewList.size()}</span>
        </h3>

        <div class="row">
            <div class="col-md-5 mb-5 mb-md-0 border-end border-secondary border-opacity-25 pe-md-4">
                <h5 class="fw-bold mb-4 text-white"><i class="fa-solid fa-pen-nib text-gold me-2"></i> Trải nghiệm của bạn</h5>
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="target" value="Review">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.productID}">

                            <div class="mb-3">
                                <label class="spec-lbl">Mức độ hài lòng</label>
                                <select name="rating" class="form-select input-dark-luxury fw-bold text-warning">
                                    <option value="5" style="color: black;">⭐⭐⭐⭐⭐ Đẳng cấp</option>
                                    <option value="4" style="color: black;">⭐⭐⭐⭐ Rất tốt</option>
                                    <option value="3" style="color: black;">⭐⭐⭐ Hài lòng</option>
                                    <option value="2" style="color: black;">⭐⭐ Tạm được</option>
                                    <option value="1" style="color: black;">⭐ Thất vọng</option>
                                 </select>
                            </div>
                            <div class="mb-4">
                                <label class="spec-lbl">Nội dung chi tiết</label>
                                <textarea name="comment" class="form-control input-dark-luxury" rows="4" placeholder="Nhập cảm nhận của bạn..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-outline-warning w-100 fw-bold py-2 rounded-pill">
                                XÁC NHẬN ĐÁNH GIÁ
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center border border-secondary rounded" style="background: #050505;">
                            <i class="fa-solid fa-user-lock fs-2 text-gold mb-3 opacity-50"></i>
                            <h6 class="text-white fw-bold mb-2">Yêu Cầu Đăng Nhập</h6>
                            <p class="text-muted small mb-4">Tham gia cộng đồng F-AUTO để chia sẻ cảm nhận.</p>
                            <a href="login.jsp" class="btn btn-outline-light btn-sm px-4 fw-bold rounded-pill text-uppercase">Đăng Nhập Ngay</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-7 ps-md-4" style="max-height: 500px; overflow-y: auto;">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="text-center py-5">
                            <i class="fa-regular fa-comment-slash fs-1 text-secondary mb-3 opacity-25"></i>
                            <p class="text-secondary text-uppercase" style="letter-spacing: 1px;">Chưa có đánh giá nào.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rev" items="${reviewList}">
                            <div class="review-box">
                                <div class="d-flex justify-content-between align-items-center mb-2 border-bottom border-secondary border-opacity-25 pb-2">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-dark text-gold rounded-circle d-flex justify-content-center align-items-center me-3 border border-secondary" style="width: 40px; height: 40px;">
                                            <i class="fa-solid fa-user"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold text-white">${reviewDAO.getUsername(rev.userID)}</div>
                                            <div class="text-warning" style="font-size: 0.75rem;"><c:forEach begin="1" end="${rev.rating}">⭐</c:forEach></div>
                                            </div>
                                        </div>
                                        <span class="text-muted small"><fmt:formatDate value="${rev.reviewDate}" pattern="dd/MM/yyyy" /></span>
                                </div>
                                <p class="text-light mb-0 mt-3" style="line-height: 1.6;">${rev.comment}</p>

                                <c:if test="${sessionScope.user != null && (sessionScope.user.userID == rev.userID || sessionScope.user.role == 1)}">
                                    <div class="mt-3 text-end">
                                        <c:if test="${sessionScope.user.userID == rev.userID}">
                                            <button class="btn btn-sm btn-link text-info p-0 me-3 fw-bold text-decoration-none" data-bs-toggle="modal" data-bs-target="#editModal${rev.reviewID}">Sửa</button>
                                        </c:if>
                                        <a href="MainController?target=Review&action=delete&reviewId=${rev.reviewID}&productId=${product.productID}" class="btn btn-sm btn-link text-danger p-0 fw-bold text-decoration-none" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                                    </div>

                                    <div class="modal fade" id="editModal${rev.reviewID}" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content" style="background: #111; border: 1px solid #D4AF37;">
                                                <form action="MainController" method="POST">
                                                    <div class="modal-header border-bottom border-secondary">
                                                        <h5 class="modal-title fw-bold text-gold">SỬA ĐÁNH GIÁ</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="target" value="Review">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="reviewId" value="${rev.reviewID}">
                                                        <input type="hidden" name="productId" value="${product.productID}">

                                                        <div class="mb-3">
                                                            <select name="rating" class="form-select input-dark-luxury text-warning fw-bold">
                                                                <option value="5" style="color: black;" ${rev.rating == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐ Đẳng cấp</option>
                                                                <option value="4" style="color: black;" ${rev.rating == 4 ? 'selected' : ''}>⭐⭐⭐⭐ Rất tốt</option>
                                                                <option value="3" style="color: black;" ${rev.rating == 3 ? 'selected' : ''}>⭐⭐⭐ Hài lòng</option>
                                                                <option value="2" style="color: black;" ${rev.rating == 2 ? 'selected' : ''}>⭐⭐ Tạm được</option>
                                                                <option value="1" style="color: black;" ${rev.rating == 1 ? 'selected' : ''}>⭐ Thất vọng</option>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <textarea name="comment" class="form-control input-dark-luxury" rows="4">${rev.comment}</textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer border-top border-secondary">
                                                        <button type="button" class="btn btn-outline-light rounded-pill px-4" data-bs-dismiss="modal">Hủy</button>
                                                        <button type="submit" class="btn btn-warning rounded-pill px-4 fw-bold">Lưu thay đổi</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>