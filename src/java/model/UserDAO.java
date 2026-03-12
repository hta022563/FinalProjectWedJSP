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
import utils.SecurityUtils; // Import thư viện máy xay của tụi mình
import utils.DbUtils;

public class UserDAO {

    public UserDAO() {
    }

    // =========================================================================
    // 1. HÀM ĐĂNG NHẬP (Lấy User lên rồi so sánh mã băm) - JPA
    // =========================================================================
    public UserDTO login(String username, String rawPassword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Bước 1: Tìm xem có tài khoản nào mang username này không
            String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
            TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
            query.setParameter("user", username);

            // getSingleResult() sẽ văng Exception nếu không tìm thấy user
            UserDTO u = query.getSingleResult();

            // Bước 2: Băm mật khẩu khách gõ
            String hashedPassword = SecurityUtils.hashPassword(rawPassword);

            // Bước 3: So sánh 2 mã băm (Mã vừa băm VS Mã lưu trong Database)
            if (u.getPassword().equals(hashedPassword)) {
                return u; // Khớp -> Mở cửa
            } else {
                return null; // Sai mật khẩu
            }

        } catch (Exception e) {
            System.out.println("Tài khoản không tồn tại hoặc lỗi: " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }

    // =========================================================================
    // 2. Hàm kiểm tra xem Username đã có ai dùng chưa - JPA
    // =========================================================================
    public boolean checkUserExist(String username) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
            TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
            query.setParameter("user", username);

            // Trả về true nếu list không rỗng (nghĩa là user đã tồn tại)
            return !query.getResultList().isEmpty(); 
        } finally {
            em.close();
        }
    }

    // =========================================================================
    // 3. Hàm Đăng Ký (Dùng JPA - Đã nhét thêm bước băm mật khẩu)
    // =========================================================================
    public boolean register(UserDTO newUser) {
        // Băm nát mật khẩu gốc ra trước khi giao cho JPA lưu
        String hashedPass = SecurityUtils.hashPassword(newUser.getPassword());
        newUser.setPassword(hashedPass); // Tráo đổi pass thật thành pass đã băm

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction(); 
        try {
            tx.begin();
            em.persist(newUser); // JPA sẽ tự động lưu chuỗi băm xuống DB
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback(); 
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // =========================================================================
    // 4. Hàm cập nhật thông tin cơ bản (Profile) - JPA
    // =========================================================================
    public boolean updateProfile(UserDTO user) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user); // Lệnh merge sẽ tự động ghi đè dữ liệu mới vào Database
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }


    // =========================================================================
    // Hàm Đổi Mật Khẩu (Đã nâng cấp dùng chuẩn JPA để không bị lỗi Cache)
    // =========================================================================
    public boolean changePassword(int userId, String alreadyHashedPassword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // 1. Tìm User trong Database lên (Để JPA theo dõi)
            UserDTO u = em.find(UserDTO.class, userId);
            
            if (u != null) {
                // 2. Ghi đè mật khẩu mới (đã được băm từ Controller)
                u.setPassword(alreadyHashedPassword);
                
                // 3. Lệnh commit sẽ tự động Lưu xuống DB và Cập nhật luôn Cache
                em.getTransaction().commit();
                return true;
            }
            return false;
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.out.println("Lỗi khi đổi mật khẩu: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // =========================================================================
    // 6. Hàm Đếm số Khách Hàng VIP (Role = 0) - JDBC Thuần
    // =========================================================================
    public int countVIPCustomers() {
        int count = 0;
        // Chú ý: SQL Server dùng [User] hoặc [Users] tuỳ tên bảng của bạn nhé
        String sql = "SELECT COUNT(*) FROM [User] WHERE Role = 0";
        
        try (Connection conn = DbUtils.getConnection();
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

    // =========================================================================
    // 7. Hàm Kiểm tra Email có tồn tại không - JDBC Thuần
    // =========================================================================
    public boolean checkEmailExist(String email) {
        String sql = "SELECT 1 FROM [User] WHERE Email = ?";
        
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu rs.next() là true nghĩa là tìm thấy email trong DB
                return rs.next(); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================================================================
    // 8. Hàm Quên Mật Khẩu (Cập nhật pass mới theo Email) - JDBC Thuần
    // =========================================================================
    public boolean updatePasswordByEmail(String email, String newRawPassword) {
        // 1. Mang mật khẩu mới đi băm nát ra
        String hashedNewPass = SecurityUtils.hashPassword(newRawPassword);
        
        // 2. Câu lệnh SQL Update
        String sql = "UPDATE [User] SET Password = ? WHERE Email = ?";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            // Truyền tham số vào dấu ?
            ps.setString(1, hashedNewPass);
            ps.setString(2, email);
            
            // executeUpdate() trả về số dòng bị ảnh hưởng. 
            // Nếu > 0 tức là đã tìm thấy email và đổi pass thành công.
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật mật khẩu theo Email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}