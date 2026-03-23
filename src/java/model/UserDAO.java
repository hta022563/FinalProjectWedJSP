package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import utils.JPAUtil;
import utils.SecurityUtils;
import utils.DbUtils;

public class UserDAO {

    public UserDAO() {
    }

    public UserDTO login(String username, String rawPassword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
           String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
        TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
        query.setParameter("user", username);

        java.util.List<UserDTO> results = query.getResultList();
        if (results.isEmpty()) {
            return null; 
        }
        UserDTO u = results.get(0);

        String hashedPassword = SecurityUtils.hashPassword(rawPassword);
        if (u.getPassword().equals(hashedPassword)) {
            return u;
        } else {
            return null; 
        }
    } catch (Exception e) {
        System.out.println("Lỗi hệ thống: " + e.getMessage());
        return null;
    } finally {
        em.close();
    }
}

    public boolean checkUserExist(String username) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT u FROM UserDTO u WHERE u.username = :user";
            TypedQuery<UserDTO> query = em.createQuery(jpql, UserDTO.class);
            query.setParameter("user", username);

            return !query.getResultList().isEmpty();
        } finally {
            em.close();
        }
    }

    public boolean register(UserDTO newUser) {
        String hashedPass = SecurityUtils.hashPassword(newUser.getPassword());
        newUser.setPassword(hashedPass);

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(newUser);
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

    public boolean updateProfile(UserDTO user) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
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

    public boolean changePassword(int userId, String alreadyHashedPassword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            UserDTO u = em.find(UserDTO.class, userId);

            if (u != null) {
                u.setPassword(alreadyHashedPassword);

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

    public int countVIPCustomers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [User] WHERE Role = 0";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean checkEmailExist(String email) {
        String sql = "SELECT 1 FROM [User] WHERE Email = ?";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePasswordByEmail(String email, String newRawPassword) {
        String hashedNewPass = SecurityUtils.hashPassword(newRawPassword);

        String sql = "UPDATE [User] SET Password = ? WHERE Email = ?";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, hashedNewPass);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật mật khẩu theo Email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
