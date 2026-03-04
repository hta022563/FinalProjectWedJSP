/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartDAO;
import model.CartItemDAO;

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
            int userId = 1;

            if ("addToCart".equals(action)) {
                String productIdStr = request.getParameter("productId");
                String quantityStr = request.getParameter("quantity");
                if (productIdStr != null) {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;
                    boolean success = cartItemDAO.addToCart(userId, productId, quantity);

                    if (success) {
                        request.setAttribute("msg", "Đã thêm xe vào giỏ hàng thành công!");
                    } else {
                        request.setAttribute("error", "Lỗi: Không thể thêm vào giỏ!");
                    }
                }
                String returnUrl = request.getParameter("returnUrl");
                if (returnUrl == null || returnUrl.isEmpty()) {
                    returnUrl = "home.jsp";
                }
                request.getRequestDispatcher(returnUrl).forward(request, response);
            } else if ("viewCart".equals(action)) {
                model.CartDTO cart = cartDAO.getCartByUserId(userId);
                java.util.List<model.CartItemDTO> cartItems = cartItemDAO.getCartItems(cart.getCartID());

                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } else if ("remove".equals(action)) {
                String itemIdStr = request.getParameter("itemId");
                if (itemIdStr != null) {
                    int itemId = Integer.parseInt(itemIdStr);
                    cartItemDAO.removeCartItem(itemId);
                }
                response.sendRedirect("CartController?action=viewCart");
            } else {
                response.sendRedirect("home.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Hệ thống đang bảo trì, vui lòng thử lại sau!");
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
