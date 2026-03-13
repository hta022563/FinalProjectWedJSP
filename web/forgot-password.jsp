<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container" style="margin-top: 100px; margin-bottom: 100px;">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card p-4" style="background: #111; border: 1px solid #D4AF37; border-radius: 20px; box-shadow: 0 10px 30px rgba(212, 175, 55, 0.1);">
                <div class="text-center mb-4">
                    <i class="fa-solid fa-key fa-3x text-warning mb-3"></i>
                    <h3 class="fw-bold" style="color: #D4AF37;">KHÔI PHỤC TÀI KHOẢN</h3>
                    <p class="text-light small">Nhập Email đã đăng ký để nhận mã OTP</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center py-2">${error}</div>
                </c:if>

                <form action="MainController" method="POST">
                    <input type="hidden" name="target" value="ForgotPassword">
                    <input type="hidden" name="action" value="sendOTP">
                    <div class="mb-4">
                        <input type="email" name="email" class="form-control form-control-lg bg-dark text-light border-secondary" placeholder="Nhập Email của bạn..." required>
                    </div>
                    <button type="submit" class="btn w-100 fw-bold py-2" style="background: linear-gradient(135deg, #D4AF37, #FFD700); color: #000; border-radius: 50px;">
                        <i class="fa-solid fa-paper-plane me-2"></i>GỬI MÃ OTP
                    </button>
                </form>
                <div class="text-center mt-3">
                    <a href="login.jsp" class="text-muted text-decoration-none small"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>