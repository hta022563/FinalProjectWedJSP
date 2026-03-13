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
import javax.servlet.http.HttpSession;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDAO;
import model.OrderDetailDTO;
import model.UserDTO;
import model.ActivityDAO; // Thêm import ActivityDAO

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return; 
            }
            int userId = user.getUserID();
            
            if ("checkout".equals(action)) {
                boolean isSuccess = orderDAO.checkout(userId, 1, null, "Giao xe tại Showroom F-Auto");
                if (isSuccess) {
                    request.setAttribute("msg", "Ting ting! Chốt đơn siêu xe thành công!");

                    // =========================================================
                    // [THÊM MỚI] GHI LOG HOẠT ĐỘNG LÊN DASHBOARD KHI CHỐT ĐƠN
                    // =========================================================
                    try {
                        // 1. Lấy đơn hàng mới nhất vừa tạo của khách này để lấy OrderID và Tổng tiền
                        List<OrderDTO> recentOrders = orderDAO.getOrdersByUserId(userId);
                        if (recentOrders != null && !recentOrders.isEmpty()) {
                            OrderDTO newestOrder = recentOrders.get(0); // Lấy đơn đầu tiên (mới nhất)
                            
                           // 2. Gọi Thư ký ghi sổ
                            ActivityDAO actDao = new ActivityDAO();
                            actDao.logActivity(
                                "ORDER", // Loại Log
                                "Đơn hàng VIP mới từ khách " + user.getUsername(), // Tiêu đề
                                user.getUsername(), // Người tạo
                                "FA-" + newestOrder.getOrderID(), // Mã tham chiếu 
                                Double.valueOf(String.valueOf(newestOrder.getTotalAmount())) // <--- ĐÃ ÉP KIỂU CHUẨN DOUBLE Ở ĐÂY
                            );
                        }
                    } catch (Exception ex) {
                        System.out.println("Lỗi khi ghi Log đơn hàng: " + ex.getMessage());
                        // Không return ở đây để không làm đứt luồng chốt đơn của khách
                    }
                    // =========================================================

                } else {
                    request.setAttribute("error", "Lỗi: Giỏ hàng trống hoặc hệ thống đang bận!");
                }
                
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
                    return; 
                } 
                
            } else if ("delete".equals(action)) {
                String orderIdStr = request.getParameter("id");
                if (orderIdStr != null && !orderIdStr.isEmpty()) {
                    boolean isDeleted = orderDAO.deleteOrder(Integer.parseInt(orderIdStr));
                    if (isDeleted) { request.setAttribute("msg", "Đã xóa đơn hàng thành công!"); }
                }
                
            } else if ("updateStatus".equals(action)) {
                // Sửa lại để điều hướng bằng MainController
                if (user != null && user.getRole() == 1) {
                    String orderIdStr = request.getParameter("orderId");
                    String newStatus = request.getParameter("status"); 
                    if (orderIdStr != null && newStatus != null) {
                        orderDAO.updateOrderStatus(Integer.parseInt(orderIdStr), newStatus);
                    }
                    response.sendRedirect("MainController?target=Dashboard"); 
                    return;
                } else {
                    response.sendRedirect("home.jsp");
                    return;
                }
                
            } else if ("exportContract".equals(action)) {
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
                    
                    OrderDTO contractOrder = null;
                    List<OrderDTO> allOrders = orderDAO.getOrdersByUserId(userId);
                    for(OrderDTO o : allOrders) {
                        if(o.getOrderID() == orderId) { contractOrder = o; break; }
                    }
                    request.setAttribute("contractOrder", contractOrder);
                    request.getRequestDispatcher("contract-pdf.jsp").forward(request, response);
                    return; 
                } 
            }
            
            // Xử lý mặc định: Hiển thị danh sách lịch sử đơn hàng
            List<OrderDTO> listOrders = orderDAO.getOrdersByUserId(userId);
            request.setAttribute("listOrders", listOrders);
            request.getRequestDispatcher("order-history.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Hệ thống đang bảo trì!");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Order Controller";
    }
}