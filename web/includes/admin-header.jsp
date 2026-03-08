<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Car Store</title>
        <link rel="icon" href="IMG/logo.jpg" type="image/webp">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* CSS tuỳ chỉnh cho thanh Sidebar Sidebar màu đen */
            body {
                display: flex; /* Sử dụng flexbox để chia layout */
                min-height: 100vh;
            }
            .sidebar {
                width: 250px;
                background-color: #212529; /* Màu tối giống ý bạn */
                color: #fff;
                padding-top: 20px;
                flex-shrink: 0; /* Ngăn sidebar bị thu nhỏ */
            }
            .sidebar a {
                color: #adb5bd;
                text-decoration: none;
                padding: 10px 20px;
                display: block;
                transition: 0.3s;
            }
            .sidebar a:hover, .sidebar a.active {
                color: #fff;
                background-color: #495057;
            }
            .content {
                flex-grow: 1; /* Phần nội dung chiếm phần còn lại */
                padding: 0px;
                background-color: #f8f9fa;
            }
            .luxury-logo {
                font-size: 1.8rem;
                font-weight: 900;
                letter-spacing: 3px;
                background: linear-gradient(to right, #ffffff 20%, #d4af37 40%, #d4af37 60%, #ffffff 80%);
                background-size: 200% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: shine 3s linear infinite;
            }
            @keyframes shine {
                to {
                    background-position: 200% center;
                }
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/DashboardController" class="text-decoration-none">
                <h4 class="text-center text-warning fw-bold mb-4 luxury-logo ">
                    F-AUTO ADMIN
                </h4>
            </a>
            <a href="${pageContext.request.contextPath}/CategoryController"><i class="fa-solid fa-list me-2"></i> Quản lý Danh mục</a>
            <a href="${pageContext.request.contextPath}/SupplierController"><i class="fa-solid fa-truck-fast me-2"></i> Nhà Cung Cấp</a>
            <a href="${pageContext.request.contextPath}/PaymentMethodController"><i class="fa-solid fa-credit-card me-2"></i> PT Thanh Toán</a>
            <a href="${pageContext.request.contextPath}/PromotionController"><i class="fa-solid fa-tags me-2"></i> Khuyến Mãi</a>
            <a href="${pageContext.request.contextPath}/ShowroomController"><i class="fa-solid fa-building me-2"></i> Showroom</a>

            <a href="${pageContext.request.contextPath}/home.jsp" class="text-info"><i class="fa-solid fa-globe me-2"></i> Về trang public</a>
            
            <a href="${pageContext.request.contextPath}/UserController?action=logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>

         

        </div>

        <div class="content">
        </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>