<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/admin-header.jsp"></jsp:include>

<style>
    .form-control:focus, .form-select:focus {
        border-color: #d4af37 !important;
        box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25) !important;
        outline: 0;
    }
</style>

    <div class="container-fluid w-75 mx-auto mt-4 mb-5">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-dark text-warning fw-bold fs-5">
                <i class="fa-solid fa-car"></i> ${product != null ? 'CẬP NHẬT THÔNG TIN XE' : 'THÊM XE MỚI'}
            </div>
            <div class="card-body bg-light">
                <form action="MainController" method="POST">
                    <input type="hidden" name="target" value="Product">
                    <input type="hidden" name="action" value="save">
                    
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
                            <label class="form-label fw-bold">Danh mục sản phẩm</label>
                            <select name="categoryID" class="form-select border-secondary" required>
                                <option value="" disabled ${empty product ? 'selected' : ''}>-- Chọn danh mục --</option>
                                <option value="1" ${product.categoryID == 1 ? 'selected' : ''}>1: Sedan</option>
                                <option value="2" ${product.categoryID == 2 ? 'selected' : ''}>2: Sport (Siêu xe thể thao)</option>
                                <option value="3" ${product.categoryID == 3 ? 'selected' : ''}>3: SUV & CUV</option>
                                <option value="4" ${product.categoryID == 4 ? 'selected' : ''}>4: Bán tải</option>
                                <option value="5" ${product.categoryID == 5 ? 'selected' : ''}>5: MPV (Xe đa dụng)</option>
                                <option value="6" ${product.categoryID == 6 ? 'selected' : ''}>6: Phụ tùng & Phụ kiện</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Nhà Cung Cấp (Thương hiệu)</label>
                            <select name="supplierID" class="form-select border-secondary" required>
                                <option value="" disabled ${empty product ? 'selected' : ''}>-- Chọn thương hiệu --</option>
                                <optgroup label="🚗 CÁC HÃNG XE">
                                    <option value="1" ${product.supplierID == 1 ? 'selected' : ''}>Toyota</option>
                                    <option value="2" ${product.supplierID == 2 ? 'selected' : ''}>Honda</option>
                                    <option value="3" ${product.supplierID == 3 ? 'selected' : ''}>Mercedes-Benz</option>
                                    <option value="4" ${product.supplierID == 4 ? 'selected' : ''}>BMW</option>
                                    <option value="5" ${product.supplierID == 5 ? 'selected' : ''}>Porsche</option>
                                    <option value="6" ${product.supplierID == 6 ? 'selected' : ''}>Lexus</option>
                                    <option value="7" ${product.supplierID == 7 ? 'selected' : ''}>Ford</option>
                                    <option value="8" ${product.supplierID == 8 ? 'selected' : ''}>Mazda</option>
                                    <option value="9" ${product.supplierID == 9 ? 'selected' : ''}>Hyundai</option>
                                    <option value="10" ${product.supplierID == 10 ? 'selected' : ''}>Kia</option>
                                    <option value="11" ${product.supplierID == 11 ? 'selected' : ''}>Volvo</option>
                                    <option value="12" ${product.supplierID == 12 ? 'selected' : ''}>Mitsubishi</option>
                                    <option value="13" ${product.supplierID == 13 ? 'selected' : ''}>Nissan</option>
                                    <option value="14" ${product.supplierID == 14 ? 'selected' : ''}>Isuzu</option>
                                    <option value="15" ${product.supplierID == 15 ? 'selected' : ''}>Suzuki</option>
                                    <option value="16" ${product.supplierID == 16 ? 'selected' : ''}>Lotus</option>
                                </optgroup>
                                
                                <optgroup label="🔧 HÃNG PHỤ KIỆN / ĐỒ CHƠI">
                                    <option value="17" ${product.supplierID == 17 ? 'selected' : ''}>Michelin</option>
                                    <option value="18" ${product.supplierID == 18 ? 'selected' : ''}>Vietmap</option>
                                    <option value="19" ${product.supplierID == 19 ? 'selected' : ''}>Panasonic</option>
                                    <option value="20" ${product.supplierID == 20 ? 'selected' : ''}>Steelmate</option>
                                    <option value="21" ${product.supplierID == 21 ? 'selected' : ''}>70mai</option>
                                    <option value="22" ${product.supplierID == 22 ? 'selected' : ''}>Areon</option>
                                    <option value="23" ${product.supplierID == 23 ? 'selected' : ''}>KATA</option>
                                    <option value="24" ${product.supplierID == 24 ? 'selected' : ''}>Khác (Phụ kiện chung)</option>
                                </optgroup>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Mô tả chi tiết</label>
                        <textarea name="description" class="form-control border-secondary" rows="4" required>${product.description}</textarea>
                    </div>

                    <div class="text-end">
                        <a href="MainController?target=Product" class="btn btn-secondary me-2 fw-bold">Hủy bỏ</a>
                        <button type="submit" class="btn btn-warning fw-bold text-dark">
                            <i class="fa-solid fa-floppy-disk"></i> Lưu Thông Tin
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

<jsp:include page="includes/admin-footer.jsp"></jsp:include>