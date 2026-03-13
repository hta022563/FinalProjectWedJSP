<%-- File: web/includes/header.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.CartDAO, model.CartItemDAO, model.CartDTO, model.CartItemDTO, model.UserDTO, java.util.List"%>
<%
    int cartBadge = 0;
    try {
        UserDTO authUser = (UserDTO) session.getAttribute("user");
        if (authUser != null) {
            CartDAO hCartDAO = new CartDAO();
            CartItemDAO hItemDAO = new CartItemDAO();

            CartDTO hCart = hCartDAO.getCartByUserId(authUser.getUserID());
            if (hCart != null) {
                List<CartItemDTO> hItems = hItemDAO.getCartItems(hCart.getCartID());
                if (hItems != null) {
                    for (CartItemDTO it : hItems) {
                        cartBadge += it.getQuantity();
                    }
                }
            }
        }
    } catch (Exception e) {
    }
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
            @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@700;800&family=Montserrat:wght@400;500;600&display=swap');
            body { font-family: 'Montserrat', sans-serif; }

            /* Nền Header Đen Tuyền + Viền Vàng */
            .navbar-custom {
                background-color: #050505 !important;
                border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            }

            /* LOGO F-AUTO: THÊM HIỆU ỨNG ÁNH SÁNG CHẠY */
            .luxury-logo {
                font-family: 'Cinzel', serif;
                font-size: 2.2rem;
                font-weight: 900;
                letter-spacing: 3px;
                /* Cấu hình dải màu Vàng -> Trắng -> Vàng */
                background: linear-gradient(to right, #D4AF37 20%, #ffffff 40%, #ffffff 60%, #D4AF37 80%);
                background-size: 200% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-shadow: 0px 4px 15px rgba(212, 175, 55, 0.3);
                /* Gắn bộ đếm thời gian chạy hiệu ứng */
                animation: shineLogo 3s linear infinite; 
            }
            
            /* Khai báo chuyển động cho logo */
            @keyframes shineLogo {
                to { background-position: 200% center; }
            }

            .luxury-logo:hover { text-shadow: 0px 4px 20px rgba(255, 255, 255, 0.5); }

            /* Menu Links */
            .nav-link-custom {
                color: #e0e0e0 !important;
                text-transform: uppercase; font-size: 0.85rem; font-weight: 600; letter-spacing: 1px; transition: 0.3s;
            }
            .nav-link-custom:hover { color: #D4AF37 !important; }

            /* Nút Quản Trị / Đăng Ký (Nền Vàng) */
            .btn-gold-nav {
                background: linear-gradient(135deg, #D4AF37, #FFD700);
                color: #000 !important; border: none; transition: all 0.3s ease; font-weight: 700; font-size: 0.85rem;
            }
            .btn-gold-nav:hover { transform: translateY(-2px); box-shadow: 0 4px 10px rgba(212, 175, 55, 0.4); }

            /* Nút Đăng Nhập (Viền Vàng) */
            .btn-outline-gold {
                color: #D4AF37;
                border: 1px solid #D4AF37; background: transparent; padding: 6px 18px; font-size: 0.85rem; font-weight: 600; transition: 0.3s;
            }
            .btn-outline-gold:hover { background: rgba(212, 175, 55, 0.1); color: #FFDF00; border-color: #FFDF00; }

            /* Nút Giỏ Hàng (Gradient Vàng Cam) */
            .btn-cart-gold {
                background: linear-gradient(135deg, #D4AF37, #FF8C00);
                color: #000 !important; border: none; padding: 6px 18px; font-weight: 700; font-size: 0.85rem; transition: 0.3s;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
            }
            .btn-cart-gold:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(212, 175, 55, 0.5); color: #000 !important; }
            .cart-badge { background-color: #dc3545; color: #fff; border: 1px solid #fff; font-size: 0.75rem; }

            /* Nút Lịch Sử Đơn (Viền Cam) */
            .btn-history-gold {
                background: transparent;
                color: #FFA500 !important; border: 1px solid #FFA500; padding: 6px 18px; font-weight: 600; font-size: 0.85rem; transition: 0.3s;
            }
            .btn-history-gold:hover { background: rgba(255, 165, 0, 0.1); color: #FFDF00 !important; border-color: #FFDF00; transform: translateY(-2px); }

            /* Khu vực User Greeting */
            .user-greeting {
                font-size: 0.9rem; padding-right: 15px; border-right: 1px solid rgba(212, 175, 55, 0.3); margin-right: 15px;
            }
            .profile-icon { color: #D4AF37; font-size: 1.4rem; transition: 0.3s; cursor: pointer; }
            .profile-icon:hover { transform: scale(1.1); color: #FFDF00; }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top py-2 shadow-lg">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center text-decoration-none" href="home.jsp">
                    <span class="luxury-logo">F-AUTO</span>
                </a>
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                    <i class="fa-solid fa-bars text-warning fs-3"></i>
                </button>
                <div class="collapse navbar-collapse" id="navContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="home.jsp">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="MainController?target=Product">Sản phẩm</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="MainController?target=News">Tin tức</a></li>

                        <%-- MỤC TRANG QUẢN TRỊ --%>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                            <li class="nav-item ms-3 d-flex align-items-center">
                                <a class="btn btn-gold-nav rounded-pill px-3 py-1" href="MainController?target=Dashboard">
                                     <i class="fa-solid fa-user-shield"></i> QUẢN TRỊ
                                </a>
                            </li>
                        </c:if>
                    </ul>

                    <div class="d-flex align-items-center">
                        <c:choose>
                            <%-- KHI ĐÃ ĐĂNG NHẬP --%>
                            <c:when test="${not empty sessionScope.user}">
                                <a href="MainController?target=Cart&action=viewCart" class="btn btn-cart-gold rounded-pill me-2">
                                    <i class="fa-solid fa-cart-shopping"></i> Giỏ hàng 
                                    <c:if test="${cartBadge > 0}">
                                        <span class="badge cart-badge rounded-pill ms-1">${cartBadge}</span>
                                    </c:if>
                                </a>

                                <a href="MainController?target=Order&action=history" class="btn btn-history-gold rounded-pill me-3">
                                    <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đơn
                                </a>

                               <div class="user-greeting d-flex align-items-center">
                                    <a href="MainController?target=User&action=profile" class="text-decoration-none me-2" title="Xem thông tin cá nhân">
                                        <%-- Lấy đúng ảnh đại diện vừa upload, nếu lỗi thì tự động tạo ảnh chữ cái đầu --%>
                                        <img src="IMG/avatars/avatar_${sessionScope.user.userID}.jpg?v=<%= System.currentTimeMillis() %>" 
                                             onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.user.username}&background=222&color=d4af37&size=40'" 
                                             alt="Avatar" 
                                             style="width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid #D4AF37; transition: 0.3s;"
                                             onmouseover="this.style.transform='scale(1.1)'; this.style.borderColor='#FFDF00';" 
                                             onmouseout="this.style.transform='scale(1)'; this.style.borderColor='#D4AF37';">
                                    </a>
                                    <span style="color: #a0a0a0;">Xin chào, <span class="fw-bold" style="color: #D4AF37;">${sessionScope.user.fullName}</span></span>
                                </div>

                                <a href="MainController?target=User&action=logout" class="btn btn-outline-danger btn-sm fw-bold rounded-pill px-3">
                                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                                </a>
                            </c:when>

                            <%-- KHI CHƯA ĐĂNG NHẬP --%>
                            <c:otherwise>
                                <a href="login.jsp" class="btn btn-outline-gold rounded-pill me-2">
                                    <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                                </a>
                                <a href="register.jsp" class="btn btn-gold-nav rounded-pill px-3 py-1">
                                    <i class="fa-solid fa-user-plus"></i> Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>