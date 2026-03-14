package model;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import utils.JPAUtil;

public class OrderDAO {
    
    public boolean checkout(int userId, int methodId, Integer promotionId, String shippingAddress) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // 1. Lấy Giỏ Hàng
            String cartJpql = "SELECT c FROM CartDTO c WHERE c.userID = :uid";
            CartDTO cart = em.createQuery(cartJpql, CartDTO.class).setParameter("uid", userId).getSingleResult();
            
            // 2. Lấy Danh sách item trong Giỏ
            String itemJpql = "SELECT ci FROM CartItemDTO ci WHERE ci.cartID = :cid";
            List<CartItemDTO> cartItems = em.createQuery(itemJpql, CartItemDTO.class).setParameter("cid", cart.getCartID()).getResultList();
            
            if (cartItems.isEmpty()) { return false; }
            
            // 3. Tạo Đơn Hàng Mới
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
            
            // 4. Tính toán tiền và chuyển item sang OrderDetail
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
                em.remove(item); // Xóa khỏi giỏ hàng
            }
            
            // ====================================================================
            // 5. [ĐÃ THÊM MỚI] XỬ LÝ TRỪ TIỀN KHUYẾN MÃI TRƯỚC KHI LƯU TỔNG CỘNG
            // ====================================================================
            if (promotionId != null) {
                try {
                    // Móc xuống DB lấy số % giảm giá của cái mã này
                    Object discountObj = em.createNativeQuery("SELECT DiscountPercent FROM Promotion WHERE PromotionID = ? AND IsActive = 1")
                                           .setParameter(1, promotionId)
                                           .getSingleResult();
                    
                    if (discountObj != null) {
                        int discountPercent = Integer.parseInt(discountObj.toString());
                        
                        // Công thức trừ tiền: Total = Total - (Total * (Percent / 100))
                        BigDecimal discountRate = new BigDecimal(discountPercent).divide(new BigDecimal(100));
                        BigDecimal discountAmount = total.multiply(discountRate);
                        
                        total = total.subtract(discountAmount); // Trừ đi số tiền được giảm
                    }
                } catch (Exception ex) {
                    System.out.println("Lỗi khi áp dụng mã giảm giá lúc chốt đơn: " + ex.getMessage());
                }
            }
            // ====================================================================
            
            // 6. Cập nhật lại Tổng tiền cuối cùng và lưu DB
            newOrder.setTotalAmount(total);
            em.merge(newOrder);
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
        String sql = "SELECT SUM(TotalAmount) FROM [Order] WHERE Status != N'Đã từ chối'"; // Không tính doanh thu đơn bị hủy
        
        try (Connection conn = utils.DbUtils.getConnection(); // Chỉnh thành DBUtils hoặc class kết nối của sếp
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
    
    public List<OrderDTO> getAllOrders() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT o FROM OrderDTO o ORDER BY o.orderDate DESC", OrderDTO.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    public boolean updateOrderStatus(int orderId, String newStatus) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            OrderDTO order = em.find(OrderDTO.class, orderId);
            if (order != null) {
                order.setStatus(newStatus); 
                em.merge(order);
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