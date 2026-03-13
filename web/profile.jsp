<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    /* Đồng bộ nền tối với F-AUTO Premium Theme */
    body { background-color: #1a1a1a; }
    .profile-card-premium { background: #222; border: 1px solid #333; border-radius: 16px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5); }
    .profile-card-premium .card-header { background: linear-gradient(135deg, #111 0%, #2a2a2a 100%); border-bottom: 1px solid #444; border-top-left-radius: 16px; border-top-right-radius: 16px; color: #d4af37; font-weight: 800; font-size: 1.2rem; letter-spacing: 1px; }
    .profile-card-premium .form-label { color: #adb5bd; font-weight: 600; font-size: 0.95rem; }
    .profile-card-premium .form-control { background-color: #1a1a1a; border: 1px solid #444; color: #fff !important; padding: 10px 15px; border-radius: 8px; transition: all 0.3s; }
    .profile-card-premium .form-control:disabled, .profile-card-premium .form-control[readonly] { background-color: #111; color: #6c757d !important; border-color: #333; }
    .profile-card-premium .form-control:focus { background-color: #1a1a1a; border-color: #d4af37; box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25); }
    .btn-gold { background-color: #d4af37; color: #111; font-weight: 700; padding: 10px 20px; border-radius: 8px; border: none; transition: all 0.3s; }
    .btn-gold:hover { background-color: #f1c40f; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3); }
    .avatar-circle { width: 120px; height: 120px; background-color: #333; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto -60px auto; border: 4px solid #222; position: relative; z-index: 10; box-shadow: 0 5px 15px rgba(0,0,0,0.8); overflow: hidden; }
</style>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            
            <c:if test="${not empty message}">
                <div class="alert alert-success text-center fw-bold border-0 shadow-sm" style="background-color: rgba(40, 167, 69, 0.1); color: #28a745;">
                    <i class="fa-solid fa-circle-check me-2"></i>${message}
                </div>
                <c:remove var="message"/>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center fw-bold border-0 shadow-sm" style="background-color: rgba(220, 53, 69, 0.1); color: #dc3545;">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                </div>
                <c:remove var="error"/>
            </c:if>

            <div class="card profile-card-premium border-0 mt-5">
                
                <div class="avatar-circle">
                    <img src="IMG/avatars/avatar_${sessionScope.user.userID}.jpg?v=<%= System.currentTimeMillis() %>" 
                         onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.user.username}&background=333&color=d4af37&size=120'" 
                         style="width: 100%; height: 100%; object-fit: cover;" alt="Avatar">
                </div>
                
                <div class="card-header text-center pt-5 pb-3 mt-3">
                    THÔNG TIN CÁ NHÂN
                </div>
                <div class="card-body p-4 p-md-5 pt-3">
                    
                    <form action="MainController" method="POST" enctype="multipart/form-data" class="mb-5 text-center border-bottom border-secondary pb-4">
                        <input type="hidden" name="target" value="User">
                        <input type="hidden" name="action" value="uploadAvatar">
                        <div class="d-flex justify-content-center align-items-center gap-2">
                            <input type="file" name="avatarFile" class="form-control form-control-sm bg-dark text-light border-secondary" accept="image/*" required style="max-width: 250px;">
                            <button type="submit" class="btn btn-outline-warning btn-sm fw-bold px-3 py-1">
                                <i class="fa-solid fa-camera"></i> Cập nhật ảnh
                            </button>
                        </div>
                    </form>

                    <form action="MainController" method="POST" class="mb-5">
                        <input type="hidden" name="target" value="User">
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
                    <form action="MainController" method="POST">
                        <input type="hidden" name="target" value="User">
                        <input type="hidden" name="action" value="changePassword">
                        
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu hiện tại</label>
                            <input type="password" name="oldPassword" class="form-control" placeholder="Nhập mật khẩu cũ..." required>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới..." required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới..." required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Mã xác thực OTP (Gửi về Email: <span class="text-info">${sessionScope.user.email}</span>)</label>
                            <div class="input-group">
                                <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP 6 số..." required maxlength="6">
                                <button type="button" class="btn btn-outline-warning fw-bold" id="btnGetOTP" onclick="requestOTP()" style="width: 150px;">Nhận mã OTP</button>
                            </div>
                            <small class="text-muted mt-2 d-block" id="otpMessage"></small>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-outline-light fw-bold px-4"><i class="fa-solid fa-key me-2"></i>ĐỔI MẬT KHẨU</button>
                        </div>
                    </form>

                    <script>
                        function requestOTP() {
                            const btn = document.getElementById('btnGetOTP');
                            const msg = document.getElementById('otpMessage');
                            
                            btn.disabled = true;
                            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang gửi...';
                            
                            // GỌI MAIN CONTROLLER ĐỂ LẤY MÃ OTP
                            fetch('MainController?target=User&action=sendChangePassOTP')
                                .then(response => response.text())
                                .then(data => {
                                    if(data.trim() === 'success') {
                                        msg.innerHTML = '<span class="text-success"><i class="fa-solid fa-circle-check"></i> Đã gửi mã OTP đến email! Có thể yêu cầu gửi lại sau <b id="countdown" class="text-white fs-5">30s</b></span>';
                                        
                                        let timeLeft = 30; 
                                        const timer = setInterval(() => {
                                            timeLeft--;
                                            btn.innerText = `Gửi lại (${timeLeft}s)`;
                                            
                                            const countdownSpan = document.getElementById('countdown');
                                            if (countdownSpan) {
                                                countdownSpan.innerText = timeLeft + 's';
                                            }

                                            if (timeLeft <= 0) {
                                                clearInterval(timer);
                                                btn.disabled = false;
                                                btn.innerText = 'Nhận lại mã';
                                                msg.innerHTML = '<span class="text-info"><i class="fa-solid fa-circle-info"></i> Bạn chưa nhận được mã? Hãy bấm Nhận lại mã.</span>';
                                            }
                                        }, 1000);
                                    } else {
                                        throw new Error("Lỗi Server");
                                    }
                                })
                                .catch(err => {
                                    msg.innerHTML = '<span class="text-danger"><i class="fa-solid fa-triangle-exclamation"></i> Lỗi gửi mail, vui lòng kiểm tra lại kết nối mạng!</span>';
                                    btn.disabled = false;
                                    btn.innerText = 'Nhận mã OTP';
                                });
                        }
                    </script>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>