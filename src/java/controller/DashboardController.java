/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ActivityDAO;
import model.OrderDAO;
import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;

/**
 *
 * @author Hao
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController"})
public class DashboardController extends HttpServlet {

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
        // 1. Kéo dữ liệu 5 hoạt động mới nhất từ Database
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        ActivityDAO actDAO = new ActivityDAO();

        try {
            // 1. [D] DELETE - XỬ LÝ XÓA LOG
            if ("deleteLog".equals(action)) {
                String logIdStr = request.getParameter("id");
                if (logIdStr != null && !logIdStr.isEmpty()) {
                    int logId = Integer.parseInt(logIdStr);
                    if (actDAO.deleteActivity(logId)) {
                        request.setAttribute("msg", "Hệ thống: Đã tiêu hủy dòng nhật ký #" + logId);
                    }
                }
            } // 2. [U] UPDATE - XỬ LÝ CẬP NHẬT LOG (MỚI)
            else if ("updateLog".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String title = request.getParameter("title");
                    String logType = request.getParameter("type");
                    String refCode = request.getParameter("refCode");

                    // Xử lý amount (có thể null nếu là log Security)
                    String amountStr = request.getParameter("amount");
                    Double amount = (amountStr != null && !amountStr.isEmpty()) ? Double.parseDouble(amountStr) : null;

                    // Gọi hàm Update trong DAO
                    boolean isUpdated = actDAO.updateActivity(id, logType, title, refCode, amount);

                    if (isUpdated) {
                        request.setAttribute("msg", "Hệ thống: Cập nhật thành công bản ghi #" + id);
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Lỗi dữ liệu: Không thể cập nhật nhật ký!");
                }
            }
            UserDAO userDAO = new UserDAO();
            int totalCus = userDAO.countVIPCustomers();
            request.setAttribute("totalCustomers", totalCus);

            // ... Code đếm totalCustomers ở bước trước ...
// [THÊM MỚI] Lấy tổng doanh thu và Rút gọn số
            OrderDAO orderDAO = new OrderDAO();
            Double rawRevenue = orderDAO.getTotalRevenue();

// Thuật toán rút gọn số tiền thành định dạng "B" (Billion - Tỷ)
            String formattedRevenue = "0.00B";
            if (rawRevenue > 0) {
                // Chia cho 1 tỷ để lấy số rút gọn
                double inBillions = rawRevenue / 1_000_000_000.0;

                // Dùng String.format để làm tròn lấy 2 chữ số thập phân (VD: 3.24B)
                // Dấu '.' thay vì ',' để chuẩn format quốc tế
                formattedRevenue = String.format(java.util.Locale.US, "%.2fB", inBillions);
            }

// ... Code đếm totalCustomers và totalRevenue ở các bước trước ...
// [THÊM MỚI] Lấy tổng số lượng xe trong kho
            ProductDAO productDAO = new ProductDAO();
            int totalStock = productDAO.getTotalStockQuantity();
            request.setAttribute("totalStock", totalStock);

// ... Code phân luồng forward sang JSP ...
// ... Code đếm totalCustomers, totalRevenue, totalStock ở các bước trước ...
// [THÊM MỚI] Lấy tổng số lượng phụ kiện
            int totalAccessories = productDAO.getTotalAccessoryStock();
            request.setAttribute("totalAccessories", totalAccessories);

// ... Code phân luồng forward sang JSP (admin-dashboard.jsp) ...
            request.setAttribute("totalRevenue", formattedRevenue);

           
            List<ProductDTO> listProduct = productDAO.getAllProducts(); // Hàm gốc của Hảo

// 2. NHÉT VÀO REQUEST (Tên biến phải khớp 100% với tên trong c:forEach)
            request.setAttribute("productList", listProduct);
            // 3. [R] READ - LẤY DỮ LIỆU HIỂN THỊ
            request.setAttribute("listActivities", actDAO.getRecentActivities(5));

            String type = request.getParameter("type");
            if ("ajax".equals(type)) {
                // Trả về phần ruột cho AJAX tự động reload 5s/lần
                request.getRequestDispatcher("recentActivitiesTable.jsp").forward(request, response);
            } else {
                // Trả về toàn bộ Dashboard Command Matrix
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
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
