<%-- 
    Document   : register
    Created on : Jan 16, 2026, 10:43:04 AM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <h3 class="text-center fw-bold mb-4 text-warning text-uppercase">Tạo Tài Khoản</h3>
                    
                    <form action="#" method="POST">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Họ và Tên</label>
                                <input type="text" class="form-control" placeholder="Nguyen Van A">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" placeholder="user123">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control">
                        </div>
                         <div class="mb-3">
                            <label class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" class="form-control">
                        </div>
                        
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-warning btn-lg fw-bold text-white">ĐĂNG KÝ</button>
                        </div>
                    </form>
                    
                    <div class="text-center mt-4">
                        <p>Đã có tài khoản? <a href="login.jsp" class="fw-bold">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>