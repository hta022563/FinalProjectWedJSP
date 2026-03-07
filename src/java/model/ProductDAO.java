package model;

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
}