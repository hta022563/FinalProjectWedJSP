/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author AngDeng
 */
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import utils.JPAUtil;

public class OrderDAO {
    public boolean checkout(int userId, int methodId, Integer promotionId, String shippingAddress) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            String cartJpql = "SELECT c FROM CartDTO c WHERE c.userID = :uid";
            TypedQuery<CartDTO> cartQuery = em.createQuery(cartJpql, CartDTO.class);
            cartQuery.setParameter("uid", userId);
            CartDTO cart = cartQuery.getSingleResult();
            String itemJpql = "SELECT ci FROM CartItemDTO ci WHERE ci.cartID = :cid";
            TypedQuery<CartItemDTO> itemQuery = em.createQuery(itemJpql, CartItemDTO.class);
            itemQuery.setParameter("cid", cart.getCartID());
            List<CartItemDTO> cartItems = itemQuery.getResultList();
            if (cartItems.isEmpty()) {
                return false; 
            }
            OrderDTO newOrder = new OrderDTO();
            newOrder.setUserID(userId);
            newOrder.setMethodID(methodId);
            newOrder.setPromotionID(promotionId);
            newOrder.setOrderDate(new Date());
            newOrder.setStatus("Đang xử lý");
            newOrder.setShippingAddress(shippingAddress);
            newOrder.setTotalAmount(BigDecimal.ZERO);
            em.persist(newOrder); 
            em.flush(); 
            BigDecimal total = BigDecimal.ZERO;
            for (CartItemDTO item : cartItems) {
                OrderDetailDTO orderDetail = new OrderDetailDTO();
                orderDetail.setOrderID(newOrder.getOrderID()); 
                orderDetail.setProductID(item.getProductID());
                orderDetail.setQuantity(item.getQuantity());
                BigDecimal currentPrice = new BigDecimal("1000000"); 
                orderDetail.setUnitPrice(currentPrice);           
                em.persist(orderDetail); 
                BigDecimal itemTotal = currentPrice.multiply(new BigDecimal(item.getQuantity()));
                total = total.add(itemTotal);
                em.remove(item); 
            }
            newOrder.setTotalAmount(total);
            em.merge(newOrder);
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
}