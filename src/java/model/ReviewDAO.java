/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import utils.JPAUtil;
/**
 *
 * @author AngDeng
 */
public class ReviewDAO {
public boolean addReview(ReviewDTO r) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createNativeQuery("INSERT INTO Review (UserID, ProductID, Rating, Comment, ReviewDate) VALUES (?, ?, ?, ?, GETDATE())")
              .setParameter(1, r.getUserID()).setParameter(2, r.getProductID())
              .setParameter(3, r.getRating()).setParameter(4, r.getComment()).executeUpdate();
            tx.commit(); return true;
        } catch(Exception e) { if(tx.isActive()) tx.rollback(); return false; } finally { em.close(); }
    }

    public List<ReviewDTO> getReviewsByProduct(int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        List<ReviewDTO> list = new ArrayList<>();
        try {
            List<Object[]> rows = em.createNativeQuery("SELECT ReviewID, UserID, ProductID, Rating, Comment, ReviewDate FROM Review WHERE ProductID = ? ORDER BY ReviewDate DESC")
                                    .setParameter(1, productId).getResultList();
            for(Object[] row : rows) {
                ReviewDTO r = new ReviewDTO();
                r.setReviewID((Integer)row[0]); r.setUserID((Integer)row[1]);
                r.setProductID((Integer)row[2]); r.setRating((Integer)row[3]);
                r.setComment((String)row[4]); r.setReviewDate((Date)row[5]);
                list.add(r);
            }
        } catch(Exception e) { e.printStackTrace(); } finally { em.close(); }
        return list;
    }

    public boolean deleteReview(int reviewId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createNativeQuery("DELETE FROM Review WHERE ReviewID = ?").setParameter(1, reviewId).executeUpdate();
            tx.commit(); return true;
        } catch(Exception e) { if(tx.isActive()) tx.rollback(); return false; } finally { em.close(); }
    }

    public boolean updateReview(int reviewId, String comment, int rating) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createNativeQuery("UPDATE Review SET Comment = ?, Rating = ?, ReviewDate = GETDATE() WHERE ReviewID = ?")
              .setParameter(1, comment).setParameter(2, rating).setParameter(3, reviewId).executeUpdate();
            tx.commit(); return true;
        } catch(Exception e) { if(tx.isActive()) tx.rollback(); return false; } finally { em.close(); }
    }

    public String getUsername(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Object name = em.createNativeQuery("SELECT Username FROM [User] WHERE UserID = ?").setParameter(1, userId).getSingleResult();
            return name.toString();
        } catch(Exception e) { return "Khách hàng #" + userId; } finally { em.close(); }
    }
}
