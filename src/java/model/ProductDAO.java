package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import utils.JPAUtil;
import utils.DbUtils;

public class ProductDAO {

    public ProductDAO() {
    }

    public List<ProductDTO> getAllProducts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM ProductDTO p", ProductDTO.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<ProductDTO> getActiveProducts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM ProductDTO p WHERE p.status = true", ProductDTO.class).getResultList();
        } finally {
            em.close();
        }
    }

    public ProductDTO getProductById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(ProductDTO.class, id);
        } finally {
            em.close();
        }
    }

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

    public boolean updateProduct(ProductDTO product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(product);
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

    public boolean deleteProduct(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            ProductDTO p = em.find(ProductDTO.class, id);
            if (p != null) {
                p.setStatus(false);
                em.merge(p);
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

    public List<ProductDTO> getProductsByCategoryId(int categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM ProductDTO p WHERE p.categoryID = :catId AND p.status = true";
            return em.createQuery(jpql, ProductDTO.class)
                    .setParameter("catId", categoryId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public int getTotalStockQuantity() {
        int total = 0;
        String sql = "SELECT SUM(StockQuantity) FROM Product WHERE CategoryID IN (1, 2, 3)";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
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
        String sql = "SELECT SUM(StockQuantity) FROM Product WHERE CategoryID NOT IN (1, 2, 3)";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<ProductDTO> searchProductsByName(String keyword) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE ProductName LIKE ? AND Status = 1";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
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
