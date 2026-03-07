<%-- File: web/includes/header.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.CartDAO, model.CartItemDAO, model.CartDTO, model.CartItemDTO, java.util.List"%>
<%
    int cartBadge = 0;
    try {
        CartDAO hCartDAO = new CartDAO();
        CartItemDAO hItemDAO = new CartItemDAO();
        // Giả sử đang fix cứng UserId = 1 để test (Sau này bạn có thể thay bằng ID của sessionScope.user)
        CartDTO hCart = hCartDAO.getCartByUserId(1); 
        if(hCart != null) {
            List<CartItemDTO> hItems = hItemDAO.getCartItems(hCart.getCartID());
            if(hItems != null) {
                for(CartItemDTO it : hItems) {
                    cartBadge += it.getQuantity(); 
                }
            }
        }
    } catch(Exception e) {}
    request.setAttribute("cartBadge", cartBadge);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>F-AUTO Showroom</title>
        <link rel="icon" href="IMG/logo.jpg" type="image/webp">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
            .luxury-logo {
                font-size: 1.8rem; font-weight: 900; letter-spacing: 3px;
                background: linear-gradient(to right, #ffffff 20%, #d4af37 40%, #d4af37 60%, #ffffff 80%);
                background-size: 200% auto; -webkit-background-clip: text; -webkit-text-fill-color: transparent;
                animation: shine 4s linear infinite;
            }
            @keyframes shine { to { background-position: 200% center; } }
            
            /* Căn chỉnh text tên người dùng cho đẹp */
            .user-greeting {
                color: #f8f9fa;
                font-size: 0.95rem;
                padding-right: 15px;
                border-right: 1px solid #6c757d;
                margin-right: 15px;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center text-decoration-none" href="home.jsp">
                    <span class="luxury-logo">F-AUTO</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="home.jsp">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Sản phẩm</a></li>
<<<<<<< Updated upstream
                               
=======
     
>>>>>>> Stashed changes
                        <%-- Kiểm tra Admin --%>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                            <li class="nav-item ms-3">
                                <a class="btn btn-danger fw-bold" href="DashboardController">
                                    <i class="fa-solid fa-user-shield"></i> VÀO TRANG QUẢN TRỊ
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    
                    <div class="d-flex align-items-center">
                        
                        <%-- KIỂM TRA ĐĂNG NHẬP Ở ĐÂY --%>
                        <c:choose>
                            <%-- NẾU ĐÃ ĐĂNG NHẬP --%>
                            <c:when test="${not empty sessionScope.user}">
                                <div class="user-greeting">
                                    <i class="fa-solid fa-user-circle text-warning"></i> 
                                    Xin chào, <span class="fw-bold">${sessionScope.user.fullName}</span>
                                </div>
                                <a href="UserController?action=logout" class="btn btn-outline-danger btn-sm me-3 fw-bold">
                                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                                </a>
<<<<<<< Updated upstream
                          </c:when>
=======
                           </c:when>
>>>>>>> Stashed changes
                            
                            <%-- NẾU CHƯA ĐĂNG NHẬP --%>
                            <c:otherwise>
                                <a href="login.jsp" class="btn btn-outline-light btn-sm me-2"><i class="fa-solid fa-right-to-bracket"></i> Đăng nhập</a>
                                <a href="register.jsp" class="btn btn-warning btn-sm fw-bold me-3"><i class="fa-solid fa-user-plus"></i> Đăng ký</a>
                            </c:otherwise>
                        </c:choose>
                        
                        <%-- Giỏ hàng với Badge số lượng --%>
                        <a href="CartController?action=viewCart" class="btn btn-light btn-sm me-2 fw-bold">
                            <i class="fa-solid fa-cart-shopping text-dark"></i> <span class="text-dark">Giỏ hàng</span> 
                            <c:if test="${cartBadge > 0}">
                                <span class="badge bg-danger rounded-pill ms-1 border border-light">${cartBadge}</span>
                            </c:if>
                        </a>
                        
                        <a href="OrderController?action=history" class="btn btn-outline-info btn-sm border-2 text-white">
                            <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đơn
                        </a>
                    </div>
                </div>
            </div>
        </nav>