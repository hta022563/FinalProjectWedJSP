package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String target = request.getParameter("target");
        String url = "home.jsp";

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

            } else if (target.equals("Wishlist")) {
                url = "WishlistController";
            }

        } catch (Exception e) {
            log("Lỗi tại MainController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
