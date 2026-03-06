/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CartDAO;
import model.CartItemDAO;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDAO;
import model.OrderDetailDTO;

/**
 *
 * @author AngDeng
 */


@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

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
        OrderDAO orderDAO = new OrderDAO();

        try {
            int userId = 1; // User test
            
            if ("checkout".equals(action)) {
                int methodId = 1; 
                Integer promotionId = null;
                String shippingAddress = "Giao xe tại Showroom F-Auto";
                boolean isSuccess = orderDAO.checkout(userId, methodId, promotionId, shippingAddress);
                
                if (isSuccess) {
                    request.setAttribute("msg", "Ting ting! Chốt đơn siêu xe thành công!");
                } else {
                    request.setAttribute("error", "Lỗi: Giỏ hàng trống hoặc hệ thống đang bận!");
                }
                List<OrderDTO> listOrders = orderDAO.getOrdersByUserId(userId);
                request.setAttribute("listOrders", listOrders);
                request.getRequestDispatcher("order-history.jsp").forward(request, response);
                
            } else if ("history".equals(action)) {
                List<OrderDTO> listOrders = orderDAO.getOrdersByUserId(userId);
                request.setAttribute("listOrders", listOrders);
                request.getRequestDispatcher("order-history.jsp").forward(request, response);
                
            } else if ("detail".equals(action)) {
                String orderIdStr = request.getParameter("id");
                if (orderIdStr != null && !orderIdStr.isEmpty()) {
                    int orderId = Integer.parseInt(orderIdStr);
                    OrderDetailDAO detailDAO = new OrderDetailDAO();
                    List<OrderDetailDTO> listDetails = detailDAO.getDetailsByOrderId(orderId);
                    Map<Integer, String> productNames = new HashMap<>();
                    for(OrderDetailDTO item : listDetails) {
                        productNames.put(item.getProductID(), detailDAO.getProductName(item.getProductID()));
                    }                   
                    request.setAttribute("listDetails", listDetails);
                    request.setAttribute("productNames", productNames);
                    request.setAttribute("orderId", orderId);
                    request.getRequestDispatcher("order-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("OrderController?action=history");
                }
                
            } else if ("delete".equals(action)) {
                String orderIdStr = request.getParameter("id");
                if (orderIdStr != null && !orderIdStr.isEmpty()) {
                    int orderId = Integer.parseInt(orderIdStr);
                    boolean isDeleted = orderDAO.deleteOrder(orderId);
                    if (isDeleted) {
                        request.setAttribute("msg", "Đã xóa đơn hàng thành công!");
                    }
                }
                List<OrderDTO> listOrders = orderDAO.getOrdersByUserId(userId);
                request.setAttribute("listOrders", listOrders);
                request.getRequestDispatcher("order-history.jsp").forward(request, response);
                
            } else {
                response.sendRedirect("home.jsp");
            }           
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Hệ thống đang bảo trì!");
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
