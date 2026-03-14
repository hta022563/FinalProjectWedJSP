      package controller;

import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProductDTO;
import model.ReviewDAO;
import model.ReviewDTO;
import utils.JPAUtil;

@WebServlet(name = "DetailController", urlPatterns = {"/DetailController"})
public class DetailController extends HttpServlet {

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String carIdStr = request.getParameter("id");
        if (carIdStr == null || carIdStr.trim().isEmpty() || carIdStr.equalsIgnoreCase("null")) {
            carIdStr = request.getParameter("pid");
        }
        if (carIdStr == null || carIdStr.trim().isEmpty() || carIdStr.equalsIgnoreCase("null")) {
            response.sendRedirect("MainController?target=Product");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdStr.trim());
            
            EntityManager em = JPAUtil.getEntityManager();
            ProductDTO product = em.find(ProductDTO.class, carId);
            em.close();
            if (product == null) {
                response.sendRedirect("MainController?target=Product");
                return;
            }

            ReviewDAO reviewDAO = new ReviewDAO();
            List<ReviewDTO> reviewList = reviewDAO.getReviewsByProduct(carId);

            request.setAttribute("product", product);
            request.setAttribute("reviewList", reviewList);
            request.setAttribute("reviewDAO", reviewDAO);

            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (NumberFormatException nfe) {

            System.out.println("Lỗi đường link sai định dạng ID: " + carIdStr);
            response.sendRedirect("MainController?target=Product");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("MainController?target=Product");
        }
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}