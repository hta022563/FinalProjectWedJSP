/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import utils.JPAUtil;

public class UserDAO {

    public UserDAO() {
    }

    public UserDTO login(String username, String password) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Bước 1: Chỉ tìm kiếm bằng username
            String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
            TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
            query.setParameter("user", username);

            // Sẽ văng Exception nếu không tìm thấy user nào
            UserDTO u = query.getSingleResult();

            // Bước 2: Lấy thông tin về Java rồi mới check mật khẩu
            if (u.getPassword().equals(password)) {
                return u; // Mật khẩu khớp -> Đăng nhập thành công
            } else {
                return null; // Có tài khoản nhưng sai mật khẩu
            }

        } catch (Exception e) {
            // Rơi vào đây tức là tìm không thấy username trong DB
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    // 1. Hàm kiểm tra xem Username đã có ai dùng chưa
    public boolean checkUserExist(String username) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
            TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
            query.setParameter("user", username);
            
            // Nếu danh sách trả về không rỗng -> User đã tồn tại
            return !query.getResultList().isEmpty(); 
        } finally {
            em.close();
        }
    }

    // 2. Hàm đăng ký (Lưu User mới vào DB)
    public boolean register(UserDTO newUser) {
        EntityManager em = JPAUtil.getEntityManager();
        // Bắt buộc phải dùng Transaction khi Insert/Update/Delete
        EntityTransaction tx = em.getTransaction(); 
        try {
            tx.begin();
            // Lưu đối tượng xuống Database
            em.persist(newUser); 
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback(); // Nếu lỗi thì hoàn tác lại
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    public int countVIPCustomers() {
    int count = 0;
    // Đếm những User có Role = 0 (Khách hàng)
    String sql = "SELECT COUNT(*) FROM [User] WHERE Role = 0";
    
    try (Connection conn = utils.DbUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}
}
