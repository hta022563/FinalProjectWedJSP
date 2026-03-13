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
        
        // Nhận ID của xe từ URL (ví dụ: DetailController?pid=1)
        String pidStr = request.getParameter("pid");
        if (pidStr == null) {
            response.sendRedirect("ProductController");
            return;
        }

        try {
            int pid = Integer.parseInt(pidStr);
            
            // Lấy thông tin xe thật từ Database
            EntityManager em = JPAUtil.getEntityManager();
            ProductDTO product = em.find(ProductDTO.class, pid);
            em.close();

            // Nếu không tìm thấy xe, đá về trang danh sách
            if (product == null) {
                response.sendRedirect("ProductController");
                return;
            }

            // Lấy danh sách Review của chiếc xe này
            ReviewDAO reviewDAO = new ReviewDAO();
            List<ReviewDTO> reviewList = reviewDAO.getReviewsByProduct(pid);

            // Gửi dữ liệu sang detail.jsp
            request.setAttribute("product", product);
            request.setAttribute("reviewList", reviewList);
            request.setAttribute("reviewDAO", reviewDAO);

            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProductController");
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}