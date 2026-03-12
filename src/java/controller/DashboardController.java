package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ActivityDAO;
import model.ActivityDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;

@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController"})
public class DashboardController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        ActivityDAO actDAO = new ActivityDAO();

        try {
            // 1. XỬ LÝ TÁC VỤ (XÓA / CẬP NHẬT LOG)
            if ("deleteLog".equals(action)) {
                String logIdStr = request.getParameter("id");
                if (logIdStr != null && !logIdStr.isEmpty()) {
                    int logId = Integer.parseInt(logIdStr);
                    if (actDAO.deleteActivity(logId)) {
                        request.setAttribute("msg", "Hệ thống: Đã tiêu hủy dòng nhật ký #" + logId);
                    }
                }
            } else if ("updateLog".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String title = request.getParameter("title");
                    String logType = request.getParameter("type");
                    String refCode = request.getParameter("refCode");
                    String amountStr = request.getParameter("amount");
                    Double amount = (amountStr != null && !amountStr.isEmpty()) ? Double.parseDouble(amountStr) : null;

                    if (actDAO.updateActivity(id, logType, title, refCode, amount)) {
                        request.setAttribute("msg", "Hệ thống: Cập nhật thành công bản ghi #" + id);
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Lỗi dữ liệu: Không thể cập nhật nhật ký!");
                }
            }

            // 2. KÉO DỮ LIỆU THỐNG KÊ TỔNG QUAN
            UserDAO userDAO = new UserDAO();
            request.setAttribute("totalCustomers", userDAO.countVIPCustomers());

            OrderDAO orderDAO = new OrderDAO();
            Double rawRevenue = orderDAO.getTotalRevenue();
            String formattedRevenue = "0.00B";
            if (rawRevenue != null && rawRevenue > 0) {
                double inBillions = rawRevenue / 1_000_000_000.0;
                formattedRevenue = String.format(java.util.Locale.US, "%.2fB", inBillions);
            }
            request.setAttribute("totalRevenue", formattedRevenue);

            ProductDAO productDAO = new ProductDAO();
            request.setAttribute("totalStock", productDAO.getTotalStockQuantity());
            request.setAttribute("totalAccessories", productDAO.getTotalAccessoryStock());

            // 3. KÉO DỮ LIỆU ĐỔ VÀO BẢNG
            List<ProductDTO> listProduct = productDAO.getAllProducts(); 
            request.setAttribute("productList", listProduct);

            List<OrderDTO> listAllOrders = orderDAO.getAllOrders();
            request.setAttribute("listAllOrders", listAllOrders);

            // [ĐÃ FIX] KÉO DỮ LIỆU LUỒNG GIAO DỊCH (LOGS) CHO RADAR
            List<ActivityDTO> listActivities = actDAO.getAllActivities(); // Đảm bảo DAO của Hảo có hàm getAllActivities() này
            request.setAttribute("listActivities", listActivities);

            // 4. PHÂN LUỒNG TRẢ VỀ VIEW
            String type = request.getParameter("type");
            if ("ajax".equals(type)) {
                request.getRequestDispatcher("recentActivitiesTable.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
        }
        // Đã xóa 2 dòng code mồ côi nằm ngoài try-catch gây lỗi sập Server
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
        return "Dashboard Controller";
    }
}