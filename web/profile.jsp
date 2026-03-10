<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    /* Đồng bộ nền tối với F-AUTO Premium Theme */
    body {
        background-color: #1a1a1a;
    }

    .profile-card-premium {
        background: #222;
        border: 1px solid #333;
        border-radius: 16px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    }
    
    .profile-card-premium .card-header {
        background: linear-gradient(135deg, #111 0%, #2a2a2a 100%);
        border-bottom: 1px solid #444;
        border-top-left-radius: 16px;
        border-top-right-radius: 16px;
        color: #d4af37;
        font-weight: 800;
        font-size: 1.2rem;
        letter-spacing: 1px;
    }

    .profile-card-premium .form-label {
        color: #adb5bd;
        font-weight: 600;
        font-size: 0.95rem;
    }

    .profile-card-premium .form-control {
        background-color: #1a1a1a;
        border: 1px solid #444;
        color: #fff !important;
        padding: 10px 15px;
        border-radius: 8px;
        transition: all 0.3s;
    }
    
    .profile-card-premium .form-control:disabled, 
    .profile-card-premium .form-control[readonly] {
        background-color: #111;
        color: #6c757d !important;
        border-color: #333;
    }

    .profile-card-premium .form-control:focus {
        background-color: #1a1a1a;
        border-color: #d4af37;
        box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
    }

    .btn-gold {
        background-color: #d4af37;
        color: #111;
        font-weight: 700;
        padding: 10px 20px;
        border-radius: 8px;
        border: none;
        transition: all 0.3s;
    }

    .btn-gold:hover {
        background-color: #f1c40f;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }
    
    .avatar-circle {
        width: 100px;
        height: 100px;
        background-color: #333;
        color: #d4af37;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3rem;
        margin: 0 auto -50px auto;
        border: 4px solid #222;
        position: relative;
        z-index: 10;
        box-shadow: 0 5px 15px rgba(0,0,0,0.5);
    }
</style>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            
            <c:if test="${not empty message}">
                <div class="alert alert-success text-center fw-bold border-0 shadow-sm" style="background-color: rgba(40, 167, 69, 0.1); color: #28a745;">
                    <i class="fa-solid fa-circle-check me-2"></i>${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center fw-bold border-0 shadow-sm" style="background-color: rgba(220, 53, 69, 0.1); color: #dc3545;">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                </div>
            </c:if>

            <div class="card profile-card-premium border-0 mt-4">
                
                <div class="avatar-circle">
                    <i class="fa-solid fa-user-tie"></i>
                </div>
                
                <div class="card-header text-center pt-5 pb-3">
                    THÔNG TIN CÁ NHÂN
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <form action="UserController" method="POST" class="mb-5">
                        <input type="hidden" name="action" value="updateProfile">
                        
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label"><i class="fa-solid fa-id-badge me-2 text-warning"></i>Tên đăng nhập</label>
                                <input type="text" class="form-control" value="${sessionScope.user.username}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-crown me-2 text-warning"></i>Cấp bậc</label>
                                <input type="text" class="form-control text-warning fw-bold" value="${sessionScope.user.role == 1 ? 'Quản trị viên (Admin)' : 'Khách hàng F-AUTO'}" readonly>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="fa-solid fa-address-card me-2 text-warning"></i>Họ và Tên</label>
                            <input type="text" name="txtFullName" class="form-control" value="${sessionScope.user.fullName}" required>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label"><i class="fa-solid fa-envelope me-2 text-warning"></i>Email</label>
                                <input type="email" name="txtEmail" class="form-control" value="${sessionScope.user.email}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-phone me-2 text-warning"></i>Số điện thoại</label>
                                <input type="text" name="txtPhone" class="form-control" value="${sessionScope.user.phone}">
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-gold"><i class="fa-solid fa-floppy-disk me-2"></i>LƯU THAY ĐỔI</button>
                        </div>
                    </form>

                    <hr class="border-secondary mb-5">

                    <h5 class="fw-bold mb-4" style="color: #d4af37;"><i class="fa-solid fa-shield-halved me-2"></i>Bảo mật tài khoản</h5>
                    <form action="UserController" method="POST">
                        <input type="hidden" name="action" value="changePassword">
                        
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu hiện tại</label>
                            <input type="password" name="oldPassword" class="form-control" placeholder="Nhập mật khẩu cũ..." required>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới..." required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới..." required>
                            </div>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-outline-light fw-bold px-4"><i class="fa-solid fa-key me-2"></i>ĐỔI MẬT KHẨU</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>