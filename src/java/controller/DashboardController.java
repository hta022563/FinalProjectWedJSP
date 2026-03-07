/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ActivityDAO;

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
   String action = request.getParameter("action");

// NẾU CÓ LỆNH XÓA LOG
if ("deleteLog".equals(action)) {
    String logIdStr = request.getParameter("id");
    if (logIdStr != null && !logIdStr.isEmpty()) {
        int logId = Integer.parseInt(logIdStr);
        ActivityDAO actDAO = new ActivityDAO();
        boolean isDeleted = actDAO.deleteActivity(logId); // Gọi hàm [D] Delete trong DAO
        
        if (isDeleted) {
            request.setAttribute("msg", "Đã xóa thành công dòng nhật ký!");
        }
    }
}

// ... Code cũ: Lấy 5 hoạt động mới nhất đẩy ra giao diện ...
ActivityDAO actDAO = new ActivityDAO();
request.setAttribute("listActivities", actDAO.getRecentActivities(5));
request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
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
