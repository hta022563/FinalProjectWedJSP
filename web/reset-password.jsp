<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container" style="margin-top: 100px; margin-bottom: 100px;">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card p-4" style="background: #111; border: 1px solid #D4AF37; border-radius: 20px; box-shadow: 0 10px 30px rgba(212, 175, 55, 0.1);">
                <div class="text-center mb-4">
                    <i class="fa-solid fa-lock fa-3x text-warning mb-3"></i>
                    <h3 class="fw-bold" style="color: #D4AF37;">MẬT KHẨU MỚI</h3>
                    <p class="text-white small">Thiết lập lại lớp bảo mật cho tài khoản của bạn</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center py-2">${error}</div>
                </c:if>

                <form action="ForgotPasswordController?action=resetPassword" method="POST">
                    <div class="mb-3">
                        <label class="text-white small mb-1">Mật khẩu mới</label>
                        <input type="password" name="newPassword" class="form-control bg-dark text-light border-secondary" required minlength="6">
                    </div>
                    <div class="mb-4">
                        <label class="text-white small mb-1">Nhập lại mật khẩu</label>
                        <input type="password" name="confirmPassword" class="form-control bg-dark text-light border-secondary" required minlength="6">
                    </div>
                    <button type="submit" class="btn w-100 fw-bold py-2" style="background: linear-gradient(135deg, #D4AF37, #FFD700); color: #000; border-radius: 50px;">
                        <i class="fa-solid fa-floppy-disk me-2"></i>LƯU MẬT KHẨU
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>