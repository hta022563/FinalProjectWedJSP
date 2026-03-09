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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
            CartDTO cart = em.createQuery(cartJpql, CartDTO.class).setParameter("uid", userId).getSingleResult();
            
            String itemJpql = "SELECT ci FROM CartItemDTO ci WHERE ci.cartID = :cid";
            List<CartItemDTO> cartItems = em.createQuery(itemJpql, CartItemDTO.class).setParameter("cid", cart.getCartID()).getResultList();
            
            if (cartItems.isEmpty()) { return false; }
            
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
                BigDecimal currentPrice = BigDecimal.ZERO;
                try {
                    Object priceObj = em.createNativeQuery("SELECT Price FROM Product WHERE ProductID = ?").setParameter(1, item.getProductID()).getSingleResult();
                    currentPrice = new BigDecimal(priceObj.toString());
                } catch (Exception ex) {}

                OrderDetailDTO orderDetail = new OrderDetailDTO();
                orderDetail.setOrderID(newOrder.getOrderID()); 
                orderDetail.setProductID(item.getProductID());
                orderDetail.setQuantity(item.getQuantity());
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
            if (tx.isActive()) tx.rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public List<OrderDTO> getOrdersByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT o FROM OrderDTO o WHERE o.userID = :uid ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, OrderDTO.class).setParameter("uid", userId).getResultList();
        } finally {
            em.close();
        }
    }

    public boolean deleteOrder(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createNativeQuery("DELETE FROM OrderDetail WHERE OrderID = ?").setParameter(1, orderId).executeUpdate();
            OrderDTO order = em.find(OrderDTO.class, orderId);
            if (order != null) { em.remove(order); }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            return false;
        } finally {
            em.close();
        }
    }
    public Double getTotalRevenue() {
    Double total = 0.0;
    // Dùng hàm SUM() của SQL để cộng dồn cột TotalAmount
    // (Có thể thêm WHERE Status = 'SUCCESS' nếu Hảo muốn chỉ tính đơn đã giao)
    String sql = "SELECT SUM(TotalAmount) FROM [Order]";
    
    try (Connection conn = utils.DbUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            total = rs.getDouble(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return total != null ? total : 0.0;
}
}