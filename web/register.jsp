<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    body {
        background-image: url('IMG/bg_login.jpg') !important;
        background-size: cover !important;
        background-position: center !important;
        background-repeat: no-repeat !important;
        background-attachment: fixed !important;
        position: relative;
    }
    body::before {
        content: ""; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.7) !important; z-index: -1;
    }
    .register-card-premium {
        background: rgba(22, 22, 22, 0.9);
        border: 1px solid #2a2a2a; border-radius: 16px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.9); backdrop-filter: blur(5px);
    }
    .register-card-premium .form-label { color: #d4af37 !important; font-weight: 600; font-size: 0.95rem; }
    .register-card-premium .form-control {
        background-color: rgba(34, 34, 34, 0.8); border: 1px solid #444; color: #fff !important;
        padding: 12px 15px; border-radius: 8px; transition: all 0.3s;
    }
    .register-card-premium .form-control::placeholder { color: #888; }
    .register-card-premium .form-control:focus {
        background-color: rgba(34, 34, 34, 1); border-color: #d4af37; box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
    }
    .btn-gold {
        background-color: #d4af37; color: #111; font-weight: 800; letter-spacing: 1px;
        padding: 12px; border-radius: 8px; transition: all 0.3s;
    }
    .btn-gold:hover { background-color: #f1c40f; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3); }
    .text-gold-link { color: #d4af37; font-weight: bold; text-decoration: none; transition: color 0.2s; }
    .text-gold-link:hover { color: #f1c40f; text-decoration: underline; }
    .register-container { min-height: calc(100vh - 200px); display: flex; align-items: center; justify-content: center; padding: 40px 0; }
</style>

<div class="container register-container">
    <div class="row justify-content-center w-100">
        <div class="col-lg-6 col-md-8">
            <div class="card register-card-premium border-0">
                <div class="card-body p-4 p-md-5">
                    <h2 class="text-center fw-bold mb-1" style="color: #d4af37; letter-spacing: 2px;">F-AUTO</h2>
                    <p class="text-center mb-4" style="color: #adb5bd;">Đăng ký tài khoản mới</p>
                    
                    <c:if test="${not empty ERROR}">
                        <div class="alert text-center fw-bold mb-4" role="alert" style="background-color: rgba(255, 77, 77, 0.1); color: #ff4d4d; border: 1px solid #ff4d4d; border-radius: 8px;">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${ERROR}
                        </div>
                    </c:if>
                    
                    <form action="MainController" method="POST">
                        <input type="hidden" name="target" value="User">
                        <input type="hidden" name="action" value="register">
                        
                        <div class="mb-3">
                            <label class="form-label"><i class="fa-solid fa-user me-2"></i>Tên đăng nhập (*)</label>
                            <input type="text" name="txtUsername" class="form-control" placeholder="Nhập tên tài khoản..." required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fa-solid fa-lock me-2"></i>Mật khẩu (*)</label>
                                <input type="password" name="txtPassword" class="form-control" placeholder="••••••••" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fa-solid fa-key me-2"></i>Nhập lại mật khẩu (*)</label>
                                <input type="password" name="txtConfirmPassword" class="form-control" placeholder="••••••••" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label"><i class="fa-solid fa-id-card me-2"></i>Họ và Tên</label>
                            <input type="text" name="txtFullName" class="form-control" placeholder="Nhập họ và tên của bạn">
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fa-solid fa-envelope me-2"></i>Email</label>
                                <input type="email" name="txtEmail" class="form-control" placeholder="example@email.com">
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label"><i class="fa-solid fa-phone me-2"></i>Số điện thoại</label>
                                <input type="text" name="txtPhone" class="form-control" placeholder="09xxxxxxxx">
                            </div>
                        </div>
                        
                        <div class="d-grid mb-4 mt-2">
                            <button type="submit" class="btn btn-gold btn-lg"><i class="fa-solid fa-user-plus me-2"></i>ĐĂNG KÝ TÀI KHOẢN</button>
                        </div>
                    </form>
                    
                    <div class="text-center mt-2" style="font-size: 0.95rem;">
                        <span style="color: #8a939b;">Đã có tài khoản?</span> 
                        <a href="login.jsp" class="text-gold-link ms-1">Đăng nhập ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>