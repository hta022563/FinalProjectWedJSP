<%-- 
    Document   : header
    Created on : Jan 16, 2026, 10:19:19 AM
    Author     : AngDeng
--%>

<%-- File: web/includes/header.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AutoWorld Showroom</title>
        <link rel="icon" href="IMG/logo.jpg" type="image/webp">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f7f6;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .hover-shadow:hover {
                box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
                transition: .3s;
            }
            .luxury-logo {
                font-size: 1.8rem;
                font-weight: 900;
                letter-spacing: 3px;
                background: linear-gradient(to right, #ffffff 20%, #d4af37 40%, #d4af37 60%, #ffffff 80%);
                background-size: 200% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: shine 4s linear infinite;
            }
            @keyframes shine {
                to {
                    background-position: 200% center;
                }
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
                        <li class="nav-item"><a class="nav-link" href="">Sản phẩm</a></li>

                        <li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
                    </ul>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                        <li class="nav-item">
                            <a class="btn btn-danger fw-bold me-4" href="admin-dashboard.jsp">
                                <i class="fa-solid fa-user-shield"></i> VÀO TRANG QUẢN TRỊ
                            </a>
                        </li>
                    </c:if>
                    <div class="d-flex">
                        <div class="d-flex align-items-center">


                            <a href="login.jsp" class="btn btn-outline-light btn-sm me-2">
                                <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                            </a>

                            <a href="register.jsp" class="btn btn-warning btn-sm fw-bold me-3">
                                <i class="fa-solid fa-user-plus"></i> Đăng ký
                            </a>
                            <a href="OrderController?action=history" class="btn btn-outline-info btn-sm me-2 border-2 text-white">
                                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đơn
                            </a>
                            <a href="CartController?action=viewCart" class="btn btn-outline-light btn-sm border-2">
                                <i class="fa-solid fa-cart-shopping"></i> Giỏ hàng
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </nav>