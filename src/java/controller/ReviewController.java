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

@WebServlet(name = "ReviewController", urlPatterns = {"/ReviewController"})
public class ReviewController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        ReviewDAO dao = new ReviewDAO();
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");

        String productIdStr = request.getParameter("productId");

        String returnUrl = "MainController?target=Detail&id=" + productIdStr;

        try {
            if ("add".equals(action)) {
                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                ReviewDTO r = new ReviewDTO();
                r.setUserID(user.getUserID());
                r.setProductID(Integer.parseInt(productIdStr));
                r.setRating(Integer.parseInt(request.getParameter("rating")));
                r.setComment(request.getParameter("comment"));
                dao.addReview(r);

                request.getSession().setAttribute("msg", "Cảm ơn sếp đã đánh giá siêu phẩm này!");

            } else if ("delete".equals(action)) {
                if (user != null) {
                    dao.deleteReview(Integer.parseInt(request.getParameter("reviewId")));
                    request.getSession().setAttribute("msg", "Đã xóa đánh giá thành công!");
                }

            } else if ("update".equals(action)) {
                if (user != null) {
                    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                    int rating = Integer.parseInt(request.getParameter("rating"));
                    String comment = request.getParameter("comment");
                    dao.updateReview(reviewId, comment, rating);
                    request.getSession().setAttribute("msg", "Cập nhật đánh giá thành công!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(returnUrl);
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
