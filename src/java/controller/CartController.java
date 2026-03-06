/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CartDAO;
import model.CartDTO;
import model.CartItemDAO;
import model.CartItemDTO;
import utils.JPAUtil;
/**
 *
 * @author AngDeng
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        CartDAO cartDAO = new CartDAO();
        CartItemDAO cartItemDAO = new CartItemDAO();

        try {
            int userId = 1; // Mặc định User số 1

            if ("addToCart".equals(action)) {
                String productIdStr = request.getParameter("productId");
                String quantityStr = request.getParameter("quantity");
                if (productIdStr != null) {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;
                    boolean success = cartItemDAO.addToCart(userId, productId, quantity);
                    if (success) { request.setAttribute("msg", "Đã thêm xe vào giỏ hàng thành công!"); } 
                }
                String returnUrl = request.getParameter("returnUrl");
                if (returnUrl == null || returnUrl.isEmpty()) { returnUrl = "home.jsp"; }
                request.getRequestDispatcher(returnUrl).forward(request, response);
                
            } else if ("viewCart".equals(action)) {
                CartDTO cart = cartDAO.getCartByUserId(userId);
                List<CartItemDTO> cartItems = cartItemDAO.getCartItems(cart.getCartID());

                Map<Integer, BigDecimal> productPrices = new HashMap<>();
                BigDecimal cartTotal = BigDecimal.ZERO; 
                
                // TỰ ĐỘNG LẤY GIÁ TRỰC TIẾP KHÔNG CẦN QUA HÀM CỦA DAO
                EntityManager em = JPAUtil.getEntityManager();
                try {
                    for (CartItemDTO item : cartItems) {
                        Object priceObj = em.createNativeQuery("SELECT Price FROM Product WHERE ProductID = ?")
                                            .setParameter(1, item.getProductID()).getSingleResult();
                        BigDecimal price = new BigDecimal(priceObj.toString());
                        productPrices.put(item.getProductID(), price);
                        cartTotal = cartTotal.add(price.multiply(new BigDecimal(item.getQuantity())));
                    }
                } catch (Exception ex) {
                } finally { 
                    em.close(); 
                }
                
                request.setAttribute("productPrices", productPrices);
                request.setAttribute("cartTotal", cartTotal);
                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                
            } else if ("remove".equals(action)) {
                String itemIdStr = request.getParameter("itemId");
                if (itemIdStr != null) { cartItemDAO.removeCartItem(Integer.parseInt(itemIdStr)); }
                response.sendRedirect("CartController?action=viewCart");
                
            } else if ("update".equals(action)) {
                String cartItemIdStr = request.getParameter("cartItemId");
                String quantityStr = request.getParameter("quantity");
                if (cartItemIdStr != null && quantityStr != null) {
                    cartItemDAO.updateQuantity(Integer.parseInt(cartItemIdStr), Integer.parseInt(quantityStr));
                }
                response.sendRedirect("CartController?action=viewCart");
                
            } else { 
                response.sendRedirect("home.jsp"); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
