<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    /* -- THAY ĐỔI QUAN TRỌNG: Đặt hình nền siêu xe và phủ lớp mờ sang trọng -- */
    body {
        /* Đường dẫn đến hình siêu xe của Duy */
        background-image: url('IMG/bg_login.jpg') !important;
        background-size: cover !important; 
        background-position: center !important; 
        background-repeat: no-repeat !important;
        background-attachment: fixed !important; 
        position: relative;
    }

    /* Tạo lớp phủ đen mờ (Overlay) để làm nổi bật Form */
    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.7) !important; 
        z-index: -1; 
    }

    /* CSS Tùy chỉnh riêng cho Form Đăng Nhập F-AUTO */
    .login-card-premium {
        background: rgba(22, 22, 22, 0.85); 
        border: 1px solid #2a2a2a;
        border-radius: 16px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.9);
        backdrop-filter: blur(10px); 
    }
    .login-card-premium .form-label {
        color: #d4af37 !important; 
        font-weight: 600;
        font-size: 0.95rem;
    }
    .login-card-premium .form-control {
        background-color: rgba(34, 34, 34, 0.8);
        border: 1px solid #444;
        color: #fff !important;
        padding: 12px 15px;
        border-radius: 8px;
        transition: all 0.3s;
    }
    .login-card-premium .form-control::placeholder {
        color: #888;
    }
    .login-card-premium .form-control:focus {
        background-color: rgba(34, 34, 34, 1);
        border-color: #d4af37;
        box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
    }
    .btn-gold {
        background-color: #d4af37;
        color: #111;
        font-weight: 800;
        letter-spacing: 1px;
        padding: 12px;
        border-radius: 8px;
        transition: all 0.3s;
    }
    .btn-gold:hover {
        background-color: #f1c40f;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }
    .text-gold-link {
        color: #d4af37;
        font-weight: bold;
        text-decoration: none;
    }
    .text-gold-link:hover {
        color: #f1c40f;
        text-decoration: underline;
    }
    
    .login-container {
        min-height: calc(100vh - 200px); 
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

<div class="container my-5 login-container">
    <div class="row justify-content-center w-100">
        <div class="col-md-5">
            <div class="card login-card-premium border-0">
                <div class="card-body p-4 p-md-5">
                    
                    <h2 class="text-center fw-bold mb-1" style="color: #d4af37; letter-spacing: 2px;">F-AUTO</h2>
                    <p class="text-center mb-4" style="color: #adb5bd;">Đăng nhập hệ thống</p>
                    
                    <c:if test="${not empty message}">
                        <div class="alert text-center fw-bold mb-4" role="alert" style="background-color: rgba(255, 77, 77, 0.1); color: #ff4d4d; border: 1px solid #ff4d4d; border-radius: 8px;">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${message}
                        </div>
                    </c:if>
                    
                    <form action="UserController" method="POST">
                        <div class="text-center mb-3">
                            <span style="color: #ff4d4d; font-size: 0.85rem;">(Gợi ý Admin: Tk: admin | MK: 123456)</span>
                        </div>
                        
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label class="form-label"><i class="fa-solid fa-user me-2"></i>Tên đăng nhập</label>
                            <input type="text" name="txtUsername" class="form-control" value="${cookie.cUser.value}" placeholder="Nhập tên tài khoản..." required>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label"><i class="fa-solid fa-lock me-2"></i>Mật khẩu</label>
                            <input type="password" name="txtPassword" class="form-control" value="${cookie.cPass.value}" placeholder="********" required>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-4 align-items-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember" name="remember" value="ON" ${not empty cookie.cUser ? 'checked' : ''} style="accent-color: #d4af37; background-color: #333; border-color: #555;">
                                <label class="form-check-label" for="remember" style="color: #adb5bd; cursor: pointer;">Ghi nhớ tôi</label>
                            </div>
                            <a href="forgot-password.jsp" class="text-gold-link" style="font-size: 0.9rem; font-weight: normal;">Quên mật khẩu?</a>
                        </div>
                        
                        <div class="d-grid mb-4">
                            <button type="submit" class="btn btn-gold btn-lg"><i class="fa-solid fa-right-to-bracket me-2"></i>ĐĂNG NHẬP</button>
                        </div>
                    </form>
                    
                    <div class="text-center mt-2" style="font-size: 0.95rem;">
                        <span style="color: #8a939b;">Chưa có tài khoản?</span> 
                        <a href="register.jsp" class="text-gold-link ms-1">Đăng ký ngay</a>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>