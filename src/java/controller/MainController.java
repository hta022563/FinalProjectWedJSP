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
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author AngDeng
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");

        // Nhận tham số "target" để biết cần điều phối đi đâu
        String target = request.getParameter("target");
        String url = "home.jsp"; // Nếu không có target, mặc định về trang chủ

        try {
            if (target == null || target.isEmpty()) {
                url = "home.jsp";
            } else if (target.equals("User")) {
                url = "UserController";
            } else if (target.equals("Cart")) {
                url = "CartController";
            } else if (target.equals("Order")) {
                url = "OrderController";
            } else if (target.equals("Product")) {
                url = "ProductController";
            } else if (target.equals("Dashboard")) {
                url = "DashboardController";
            } else if (target.equals("Detail")) {
                url = "DetailController";
            } else if (target.equals("News")) {
                url = "NewsController";
            } else if (target.equals("Review")) {
                url = "ReviewController";
            } else if (target.equals("Showroom")) {
                url = "ShowroomController";
            } else if (target.equals("Supplier")) {
                url = "SupplierController";
            } else if (target.equals("Category")) {
                url = "CategoryController";
            } else if (target.equals("Promotion")) {
                url = "PromotionController";
            } else if (target.equals("Payment")) {
                url = "PaymentMethodController";
            } else if (target.equals("ForgotPassword")) {
                url = "ForgotPasswordController";

                // SỬA LẠI ĐOẠN WISHLIST ĐỂ ĐỒNG BỘ VỚI TOÀN BỘ CONTROLLER
            } else if (target.equals("Wishlist")) {
                url = "WishlistController";
            }

        } catch (Exception e) {
            log("Lỗi tại MainController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
