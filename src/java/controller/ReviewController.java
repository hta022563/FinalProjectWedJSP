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
import model.ReviewDAO;
import model.ReviewDTO;
import model.UserDTO;

/**
 *
 * @author AngDeng
 */
@WebServlet(name = "ReviewController", urlPatterns = {"/ReviewController"})
public class ReviewController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ReviewDAO dao = new ReviewDAO();
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        int userId = (user != null) ? user.getUserID() : 1; 

        String productIdStr = request.getParameter("productId");
        String returnUrl = "detail.jsp?id=" + productIdStr;

        try {
            if ("add".equals(action)) {
                ReviewDTO r = new ReviewDTO();
                r.setUserID(userId);
                r.setProductID(Integer.parseInt(productIdStr));
                r.setRating(Integer.parseInt(request.getParameter("rating")));
                r.setComment(request.getParameter("comment"));
                dao.addReview(r);
                
            } else if ("delete".equals(action)) {
                dao.deleteReview(Integer.parseInt(request.getParameter("reviewId")));
                
            } else if ("update".equals(action)) {
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                dao.updateReview(reviewId, comment, rating);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(returnUrl);
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
