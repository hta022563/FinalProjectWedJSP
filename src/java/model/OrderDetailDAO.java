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
import utils.JPAUtil;

public class OrderDetailDAO {

   public List<OrderDetailDTO> getDetailsByOrderId(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT od FROM OrderDetailDTO od WHERE od.orderID = :oid";
            return em.createQuery(jpql, OrderDetailDTO.class).setParameter("oid", orderId).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (em != null && em.isOpen()) { em.close(); }
        }
    }

    public String getProductName(int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Object nameObj = em.createNativeQuery("SELECT ProductName FROM Product WHERE ProductID = ?").setParameter(1, productId).getSingleResult();
            return nameObj.toString();
        } catch (Exception e) {
            return "Siêu xe mã số #" + productId;
        } finally {
            if (em != null && em.isOpen()) { em.close(); }
        }
    }
}
