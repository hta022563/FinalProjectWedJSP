/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.ActivityDAO; // Hoặc thư mục chứa ActivityDAO của Hảo
import java.io.IOException;
import java.math.BigDecimal;
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

                // BƯỚC 1: Xử lý nghiệp vụ chính
                boolean isSuccess = orderDAO.checkout(userId, methodId, promotionId, shippingAddress);

                if (isSuccess) {
                    request.setAttribute("msg", "Ting ting! Chốt đơn siêu xe thành công!");

                    // ========================================================
                    // 🚀 BƯỚC 2: KỸ THUẬT GHI VẾT (LOGGING) TỰ ĐỘNG - VERSION PRO
                    // ========================================================
                    try {
                        ActivityDAO actDAO = new ActivityDAO();
                        OrderDetailDAO detailDAO = new OrderDetailDAO(); // Gọi thêm DAO chi tiết để lấy tên xe

                        // Lấy danh sách đơn hàng mới nhất để truy xuất ID vừa tạo
                        List<OrderDTO> recentOrders = orderDAO.getOrdersByUserId(userId);

                        if (recentOrders != null && !recentOrders.isEmpty()) {
                            OrderDTO newOrder = recentOrders.get(0);

                            // 1. Lấy danh sách chi tiết của đơn hàng này
                            List<OrderDetailDTO> details = detailDAO.getDetailsByOrderId(newOrder.getOrderID());

                            // 2. Dùng StringBuilder để gom tên tất cả xe khách vừa mua
                            StringBuilder carNames = new StringBuilder();
                            for (int i = 0; i < details.size(); i++) {
                                String name = detailDAO.getProductName(details.get(i).getProductID());
                                carNames.append(name);
                                if (i < details.size() - 1) {
                                    carNames.append(", "); // Thêm dấu phẩy nếu mua nhiều xe
                                }
                            }

                            // 3. Tiêu đề giờ đây sẽ hiển thị tên xe thực tế thay vì chỉ hiện mã số!
                            String title = "Đặt hàng thành công: " + carNames.toString();
                            String refCode = "ORD-" + newOrder.getOrderID();
                            Double amount = newOrder.getTotalAmount().doubleValue();

                            // Ghi log xuống Database
                            actDAO.logActivity("ORDER", title, "User ID: " + userId, refCode, amount);
                        }
                    } catch (Exception e) {
                        System.out.println("Lỗi ghi log chi tiết: " + e.getMessage());
                    }
                    // ========================================================
                } else {
                    request.setAttribute("error", "Lỗi: Giỏ hàng trống hoặc hệ thống đang bận!");
                }

                // BƯỚC 3: Đẩy ra giao diện Lịch sử đặt hàng
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
                    for (OrderDetailDTO item : listDetails) {
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
