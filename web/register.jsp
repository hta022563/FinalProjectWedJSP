<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <h3 class="text-center fw-bold mb-4">Đăng Ký Tài Khoản</h3>
                    
                    <c:if test="${not empty ERROR}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${ERROR}
                        </div>
                    </c:if>
                    
                    <form action="UserController" method="POST">
                        <input type="hidden" name="action" value="register">
                        
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập (*)</label>
                            <input type="text" name="txtUsername" class="form-control" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mật khẩu (*)</label>
                                <input type="password" name="txtPassword" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nhập lại mật khẩu (*)</label>
                                <input type="password" name="txtConfirmPassword" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Họ và Tên</label>
                            <input type="text" name="txtFullName" class="form-control">
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="txtEmail" class="form-control">
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="txtPhone" class="form-control">
                            </div>
                        </div>
                        
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg fw-bold">ĐĂNG KÝ</button>
                        </div>
                    </form>
                    
                    <div class="text-center mt-4">
                        <p>Đã có tài khoản? <a href="login.jsp" class="fw-bold">Đăng nhập ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>