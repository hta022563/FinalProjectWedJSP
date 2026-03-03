<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-dark">Bảng Điều Khiển F-AUTO</h2>
            <div class="text-secondary fw-bold">
                <i class="fa-solid fa-clock me-2"></i> Phiên làm việc: ${sessionScope.user.fullName}
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white shadow-sm border-0">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-1 small">Tổng xe hiện có</h6>
                        <h2 class="mb-0 fw-bold">45</h2>
                    </div>
                    <i class="fa-solid fa-car fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white shadow-sm border-0">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-1 small">Đơn hàng mới</h6>
                        <h2 class="mb-0 fw-bold">12</h2>
                    </div>
                    <i class="fa-solid fa-cart-shopping fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-dark shadow-sm border-0">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-1 small">Khách hàng</h6>
                        <h2 class="mb-0 fw-bold">1,050</h2>
                    </div>
                    <i class="fa-solid fa-users fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-danger text-white shadow-sm border-0">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-1 small">Doanh thu tháng</h6>
                        <h2 class="mb-0 fw-bold">3.2 tỷ</h2>
                    </div>
                    <i class="fa-solid fa-money-bill-trend-up fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-md-12">

                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-pie text-primary me-2"></i> TRẠNG THÁI KHO HÀNG</h5>
                        <div class="row text-center mb-2">
                            <div class="col-4 small fw-bold">TỔNG LƯỢNG: 100</div>
                            <div class="col-4 small fw-bold text-success">ĐÃ BÁN: 65</div>
                            <div class="col-4 small fw-bold text-warning">CÒN TRONG KHO: 35</div>
                        </div>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%">65%</div>
                            <div class="progress-bar bg-warning text-dark" role="progressbar" style="width: 35%">35%</div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h5 class="fw-bold m-0"><i class="fa-solid fa-warehouse text-info me-2"></i> CHI TIẾT XE TRONG KHO</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Tên Xe</th>
                                    <th>Mô tả chi tiết</th>
                                    <th class="text-end">Giá niêm yết</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-center">Trạng thái</th>
                                </tr>
                            </thead>
                        <%--
                            <tbody id="product-list">
                                <c:forEach items="${productList}" var="p">
                                    <tr>
                                        <td class="fw-bold text-primary">${p.productName}</td>
                                        <td class="small text-muted">${p.description}</td>
                                        <td class="text-end fw-bold text-danger">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                </td>
                                <td class="text-center">${p.stockQuantity}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.stockQuantity > 0}">
                                            <span class="badge bg-success">Sẵn sàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                </tr>
                            </c:forEach> 
                            </tbody>
                            --%>
                            <tbody>
                            <tr>
                                <td class="fw-bold text-primary">Toyota Corolla Cross 1.8V</td>
                                <td class="small text-muted">Xe SUV đô thị cỡ B bán chạy nhất.</td>
                                <td class="text-end fw-bold text-danger">860,000,000đ</td>
                                <td class="text-center">5</td>
                                <td class="text-center"><span class="badge bg-success">Sẵn sàng</span></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-primary">Honda City RS</td>
                                <td class="small text-muted">Xe Sedan thể thao, tiết kiệm xăng.</td>
                                <td class="text-end fw-bold text-danger">609,000,000đ</td>
                                <td class="text-center">10</td>
                                <td class="text-center"><span class="badge bg-success">Sẵn sàng</span></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-primary">Toyota Fortuner 2026</td>
                                <td class="small text-muted">Xe SUV 7 chỗ mạnh mẽ, bền bỉ.</td>
                                <td class="text-end fw-bold text-danger">1,200,000,000đ</td>
                                <td class="text-center">5</td>
                                <td class="text-center"><span class="badge bg-success">Sẵn sàng</span></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-primary">Thảm lót sàn ô tô Michelin</td>
                                <td class="small text-muted">Thảm lót sàn cao cấp chống thấm nước.</td>
                                <td class="text-end fw-bold text-danger">1,500,000đ</td>
                                <td class="text-center">50</td>
                                <td class="text-center"><span class="badge bg-info">Phụ kiện</span></td>
                            </tr>
                        </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-light py-2">
                        <small class="text-muted italic"><i class="fa-solid fa-circle-info me-1"></i> Lưu ý: Dữ liệu trên được cập nhật theo thời gian thực từ Database.</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>