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
import javax.servlet.http.HttpSession;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDAO;
import model.OrderDetailDTO;
import model.UserDTO;
import utils.EmailUtils;
import model.PaymentMethodDAO; // Đã thêm Import
import model.PaymentMethodDTO; // Đã thêm Import

/**
 *
 * @author AngDeng
 */
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
                if (user != null && user.getRole() == 1) {
                    String orderIdStr = request.getParameter("orderId");
                    String newStatus = request.getParameter("status"); 
                    if (orderIdStr != null && newStatus != null) {
                        orderDAO.updateOrderStatus(Integer.parseInt(orderIdStr), newStatus);
                    }
                    response.sendRedirect("DashboardController"); 
                    return;
                } else {
                    response.sendRedirect("home.jsp");
                    return;
                }
            } else if ("processPayment".equals(action)) {
                String orderIdStr = request.getParameter("orderId");
                String paymentMethodId = request.getParameter("paymentMethod");

                try {
                    // CẬP NHẬT TRẠNG THÁI VÀO CSDL TẠI ĐÂY NẾU CẦN
                    // orderDAO.updatePaymentInfo(Integer.parseInt(orderIdStr), Integer.parseInt(paymentMethodId));

                    if (user.getEmail() != null && !user.getEmail().isEmpty()) {
                        
                        // --- BẮT ĐẦU: LẤY TÊN THẬT CỦA PHƯƠNG THỨC THANH TOÁN ---
                        PaymentMethodDAO pmDao = new PaymentMethodDAO();
                        String methodName = "Cổng số " + paymentMethodId; // Mặc định nếu không tìm thấy trong DB

                        try {
                            int pmId = Integer.parseInt(paymentMethodId);
                            List<PaymentMethodDTO> listPM = pmDao.getAllActive();
                            for (PaymentMethodDTO pm : listPM) {
                                if (pm.getMethodID() == pmId) {
                                    methodName = pm.getMethodName();
                                    // Kèm theo tên ngân hàng nếu đó là QR Code và có thông tin BankName
                                    if(pm.getBankName() != null && !pm.getBankName().trim().isEmpty()) {
                                        methodName += " (" + pm.getBankName() + ")"; 
                                    }
                                    break; // Tìm thấy thì dừng vòng lặp
                                }
                            }
                        } catch (Exception e) {
                            System.out.println("Lỗi khi tìm tên phương thức thanh toán: " + e.getMessage());
                        }
                        // --- KẾT THÚC: LẤY TÊN THẬT CỦA PHƯƠNG THỨC THANH TOÁN ---

                        // Khởi tạo các biến final để dùng trong Background Thread
                        final String customerName = (user.getFullName() != null && !user.getFullName().isEmpty()) 
                                ? user.getFullName() : user.getUsername();
                        final String customerEmail = user.getEmail();
                        final String fOrderId = orderIdStr;
                        final String fPaymentMethod = methodName; // Đưa tên thật vừa lấy được vào đây

                        // Đẩy tiến trình gửi mail ra Background Thread để web không bị đơ
                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                String subject = "[F-AUTO] Xác nhận yêu cầu thanh toán Hợp đồng #" + fOrderId;
                                String body = EmailUtils.getOrderConfirmationTemplate(customerName, fOrderId, fPaymentMethod);
                                EmailUtils.sendEmail(customerEmail, subject, body);
                            }
                        }).start();
                    }

                    // Thông báo và đá về trang lịch sử đơn hàng ngay lập tức
                    session.setAttribute("msg", "Xác nhận thành công! Vui lòng kiểm tra hộp thư Email.");
                    response.sendRedirect("OrderController"); 
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("msgError", "Lỗi giao dịch: " + e.getMessage());
                    response.sendRedirect("OrderController");
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
        return "Short description";
    }
}