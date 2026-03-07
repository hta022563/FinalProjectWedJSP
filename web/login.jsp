<%-- 
    Document   : login
    Created on : Jan 16, 2026, 10:42:47 AM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <h3 class="text-center fw-bold mb-4">Đăng Nhập</h3>
                    
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${message}
                        </div>
                    </c:if>
                    
                    <form action="UserController" method="POST">
                        
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập (Username)</label>
                            <input type="text" name="txtUsername" class="form-control form-control-lg" placeholder="Nhập tên tài khoản..." required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="txtPassword" class="form-control form-control-lg" placeholder="********" required>
                        </div>
                        <div class="d-flex justify-content-between mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember">
                                <label class="form-check-label" for="remember">Ghi nhớ tôi</label>
                            </div>
                            <a href="#" class="text-decoration-none">Quên mật khẩu?</a>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">ĐĂNG NHẬP</button>
                        </div>
                    </form>
                    
                    <div class="text-center mt-4">
                        <p>Chưa có tài khoản? <a href="register.jsp" class="fw-bold">Đăng ký ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>