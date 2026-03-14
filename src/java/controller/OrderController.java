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
import utils.EmailUtils;
import model.PaymentMethodDAO; 
import model.PaymentMethodDTO; 
import model.ActivityDAO; 

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();

        try {
            HttpSession session = request.getSession();
            // Lấy thông tin user (Không cần check null nữa vì Filter đã chặn ngoài cửa rồi)
            UserDTO user = (UserDTO) session.getAttribute("user");
            int userId = user.getUserID();
            
        if ("checkout".equals(action)) {
                // 1. Lấy địa chỉ Showroom khách vừa chọn từ Form
                String shippingAddress = request.getParameter("shippingAddress");
                if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                    shippingAddress = "Giao xe tại Showroom F-Auto Hội Sở"; // Fallback an toàn
                }

                // 2. Lấy mã giảm giá (nếu có)
                Integer promoId = (Integer) session.getAttribute("promotionId");
                
                // 3. Chốt đơn: TRUYỀN shippingAddress VÀO HÀM CHECKOUT (thay cho chữ cứng lúc trước)
                boolean isSuccess = orderDAO.checkout(userId, 1, promoId, shippingAddress);
                
                if (isSuccess) {
                    request.setAttribute("msg", "Ting ting! Chốt đơn siêu xe thành công!");

                    // Xóa session mã giảm giá
                    session.removeAttribute("appliedPromoCode");
                    session.removeAttribute("discountPercent");
                    session.removeAttribute("promotionId");

                    // Ghi Log hoạt động
                    try {
                        List<OrderDTO> recentOrders = orderDAO.getOrdersByUserId(userId);
                        if (recentOrders != null && !recentOrders.isEmpty()) {
                            OrderDTO newestOrder = recentOrders.get(0); 
                            ActivityDAO actDao = new ActivityDAO();
                            actDao.logActivity("ORDER", "Đơn hàng VIP mới từ khách " + user.getUsername(), user.getUsername(), "FA-" + newestOrder.getOrderID(), Double.valueOf(String.valueOf(newestOrder.getTotalAmount())));
                        }
                    } catch (Exception ex) {
                        System.out.println("Lỗi khi ghi Log: " + ex.getMessage());
                    }
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
                if (user.getRole() == 1) { // Chỉ Admin mới được update
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
            } else if ("processPayment".equals(action)) {
                String orderIdStr = request.getParameter("orderId");
                String paymentMethodId = request.getParameter("paymentMethod");

                try {
                    if (user.getEmail() != null && !user.getEmail().isEmpty()) {
                        
                        PaymentMethodDAO pmDao = new PaymentMethodDAO();
                        String methodName = "Cổng số " + paymentMethodId; 

                        try {
                            int pmId = Integer.parseInt(paymentMethodId);
                            List<PaymentMethodDTO> listPM = pmDao.getAllActive();
                            for (PaymentMethodDTO pm : listPM) {
                                if (pm.getMethodID() == pmId) {
                                    methodName = pm.getMethodName();
                                    if(pm.getBankName() != null && !pm.getBankName().trim().isEmpty()) {
                                        methodName += " (" + pm.getBankName() + ")"; 
                                    }
                                    break; 
                                }
                            }
                        } catch (Exception e) {
                            System.out.println("Lỗi khi tìm tên phương thức TT: " + e.getMessage());
                        }

                        final String customerName = (user.getFullName() != null && !user.getFullName().isEmpty()) 
                                ? user.getFullName() : user.getUsername();
                        final String customerEmail = user.getEmail();
                        final String fOrderId = orderIdStr;
                        final String fPaymentMethod = methodName; 

                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                String subject = "[F-AUTO] Xác nhận yêu cầu thanh toán Hợp đồng #" + fOrderId;
                                String body = EmailUtils.getOrderConfirmationTemplate(customerName, fOrderId, fPaymentMethod);
                                EmailUtils.sendEmail(customerEmail, subject, body);
                            }
                        }).start();
                    }

                    session.setAttribute("msg", "Xác nhận thành công! Vui lòng kiểm tra hộp thư Email.");
                    response.sendRedirect("OrderController"); 
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("msgError", "Lỗi giao dịch: " + e.getMessage());
                    response.sendRedirect("OrderController");
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
        return "Order Controller"; // ĐÃ FIX: Chỉ giữ lại 1 dòng return
    }
}