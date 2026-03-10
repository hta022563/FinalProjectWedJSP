package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import javax.persistence.EntityManager;
import utils.JPAUtil;

public class ProductDAO {

    public ProductDAO() {
    }

    // 1. Dành cho Admin: Lấy TẤT CẢ sản phẩm (kể cả xe đã ẩn)
    public List<ProductDTO> getAllProducts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM ProductDTO p", ProductDTO.class).getResultList();
        } finally {
            em.close();
        }
    }

    // 2. Dành cho Khách hàng: Chỉ lấy xe ĐANG BÁN (Status = true)
    public List<ProductDTO> getActiveProducts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM ProductDTO p WHERE p.status = true", ProductDTO.class).getResultList();
        } finally {
            em.close();
        }
    }

    // 3. Lấy 1 xe theo ID (Để Xem chi tiết hoặc đổ dữ liệu vào Form Sửa)
    public ProductDTO getProductById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(ProductDTO.class, id);
        } finally {
            em.close();
        }
    }

    // 4. Hàm THÊM xe mới
    public boolean addProduct(ProductDTO product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(product);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 5. Hàm CẬP NHẬT (Sửa) thông tin xe
    public boolean updateProduct(ProductDTO product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(product); // merge dùng để update dữ liệu đã có
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 6. Hàm XÓA MỀM (Chỉ chuyển Status thành false, không xóa hẳn khỏi Database)
    public boolean deleteProduct(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            ProductDTO p = em.find(ProductDTO.class, id);
            if (p != null) {
                p.setStatus(false); // Ẩn xe đi
                em.merge(p);        // Lưu thay đổi
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
// Hàm đếm tổng số lượng xe đang tồn trong kho

// Hàm đếm tổng số lượng xe đang tồn trong kho (Chỉ tính xe, không tính phụ kiện)
public int getTotalStockQuantity() {
    int total = 0;
    
    // CODE MỀM: Thêm điều kiện WHERE CategoryID IN (1, 2, 3) để chỉ cộng dồn xe hơi
    String sql = "SELECT SUM(StockQuantity) FROM Product WHERE CategoryID IN (1, 2, 3)";

    try ( Connection conn = utils.DbUtils.getConnection();  
            PreparedStatement ps = conn.prepareStatement(sql); 
            ResultSet rs = ps.executeQuery()) {

        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return total;
}
    
    public int getTotalAccessoryStock() {
    int total = 0;
    
    // Logic: Cộng dồn StockQuantity nhưng BỎ QUA các CategoryID là 1, 2, 3 (Xe hơi)
    // Nếu sau này Hảo thêm Category số 4 (Nước hoa), 5 (Đệm ghế) thì nó sẽ tự động được cộng vào đây!
    String sql = "SELECT SUM(StockQuantity) FROM Product WHERE CategoryID NOT IN (1, 2, 3)";
    
    try (Connection conn = utils.DbUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return total;
}
   // =========================================================================
    // 7. Hàm TÌM KIẾM SẢN PHẨM THEO TÊN (Khớp chuẩn 9 tham số của ProductDTO)
    // =========================================================================
    public List<ProductDTO> searchProductsByName(String keyword) {
        List<ProductDTO> list = new java.util.ArrayList<>();
        
        // Câu lệnh SQL thuần: Chỉ lấy từ bảng Product, lọc xe đang bán (Status = 1)
        String sql = "SELECT * FROM Product WHERE ProductName LIKE ? AND Status = 1";

        try (java.sql.Connection conn = utils.DbUtils.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {

            // Kẹp thêm % ở 2 đầu để tìm kiếm gần đúng
            ps.setString(1, "%" + keyword + "%");

            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Gọi đúng hàm khởi tạo 9 tham số của ProductDTO
                    ProductDTO p = new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getInt("SupplierID"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getInt("StockQuantity"),
                        rs.getString("Description"),
                        rs.getString("ImageURL"),
                        rs.getBoolean("Status")
                    );
                    list.add(p);
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi tìm kiếm xe: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}
