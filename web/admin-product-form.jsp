<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

    <div class="container-fluid w-75 mx-auto mt-4 mb-5">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-dark text-warning fw-bold fs-5">
                <i class="fa-solid fa-car"></i> ${product != null ? 'CẬP NHẬT THÔNG TIN XE' : 'THÊM XE MỚI'}
            </div>
            <div class="card-body bg-light">
                <form action="ProductController?action=save" method="POST">
                    
                    <input type="hidden" name="productID" value="${product.productID}">
                    <input type="hidden" name="status" value="${product != null ? product.status : 'true'}">

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Tên sản phẩm (Xe/Phụ kiện)</label>
                            <input type="text" name="productName" class="form-control border-secondary" value="${product.productName}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Tên File Ảnh (VD: camry.jpg)</label>
                            <input type="text" name="imageURL" class="form-control border-secondary" value="${product.imageURL}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Giá bán (VNĐ)</label>
                            <input type="number" name="price" class="form-control border-secondary" value="${product.price}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Số lượng trong kho</label>
                            <input type="number" name="stockQuantity" class="form-control border-secondary" value="${product.stockQuantity}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">ID Danh mục (1: SUV, 2: Sedan...)</label>
                            <input type="number" name="categoryID" class="form-control border-secondary" value="${product != null ? product.categoryID : '1'}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">ID Nhà Cung Cấp</label>
                            <input type="number" name="supplierID" class="form-control border-secondary" value="${product != null ? product.supplierID : '1'}" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Mô tả chi tiết</label>
                        <textarea name="description" class="form-control border-secondary" rows="4" required>${product.description}</textarea>
                    </div>

                    <div class="text-end">
                        <a href="ProductController" class="btn btn-secondary me-2 fw-bold">Hủy bỏ</a>
                        <button type="submit" class="btn btn-warning fw-bold text-dark">
                            <i class="fa-solid fa-floppy-disk"></i> Lưu Thông Tin
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>