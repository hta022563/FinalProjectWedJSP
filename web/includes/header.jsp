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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .hover-shadow:hover { box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; transition: .3s; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-uppercase text-warning" href="home.jsp">
                <i class="fa-solid fa-car-side"></i> F-Auto
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" href="home.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
                </ul>
                <div class="d-flex">
                    <a href="login.jsp" class="btn btn-outline-light btn-sm me-2">
                        <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                    </a>
                    <a href="register.jsp" class="btn btn-warning btn-sm fw-bold">
                        <i class="fa-solid fa-user-plus"></i> Đăng ký
                    </a>
                </div>
            </div>
        </div>
    </nav>