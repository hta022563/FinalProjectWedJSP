package model;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import utils.JPAUtil;

public class CartDAO {

    public CartDTO getCartByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT c FROM CartDTO c WHERE c.userID = :uid";
            List<CartDTO> carts = em.createQuery(jpql, CartDTO.class)
                                    .setParameter("uid", userId)
                                    .getResultList();
            if (!carts.isEmpty()) {
                return carts.get(0);
            }
            em.getTransaction().begin();
            CartDTO newCart = new CartDTO();
            newCart.setUserID(userId);
            em.persist(newCart);
            em.getTransaction().commit();
            return newCart;
        } finally {
            em.close();
        }
    }
    public List<CartDTO> getAllCarts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM CartDTO c", CartDTO.class).getResultList();
        } finally {
            em.close();
        }
    }
    public boolean deleteCart(int cartId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            CartDTO cart = em.find(CartDTO.class, cartId);
            if (cart != null) em.remove(cart);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            return false;
        } finally {
            em.close();
        }
    }
}