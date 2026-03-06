/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author AngDeng
 */
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import utils.JPAUtil;

public class CartItemDAO {

    public boolean addToCart(int userId, int productId, int quantity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            CartDAO cartDAO = new CartDAO();
            CartDTO cart = cartDAO.getCartByUserId(userId);
            CartItemDTO item = new CartItemDTO();
            item.setCartID(cart.getCartID());
            item.setProductID(productId);
            item.setQuantity(quantity);
            em.persist(item);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<CartItemDTO> getCartItems(int cartId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT ci FROM CartItemDTO ci WHERE ci.cartID = :cid";
            return em.createQuery(jpql, CartItemDTO.class)
                     .setParameter("cid", cartId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    public boolean removeCartItem(int cartItemId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            CartItemDTO item = em.find(CartItemDTO.class, cartItemId);
            if (item != null) em.remove(item);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            return false;
        } finally {
            em.close();
        }
    }
    public boolean updateQuantity(int cartItemId, int newQuantity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            CartItemDTO item = em.find(CartItemDTO.class, cartItemId);
            if (item != null) {
                if (newQuantity > 0) {
                    item.setQuantity(newQuantity);
                    em.merge(item);
                } else {
                    em.remove(item);
                }
            }
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