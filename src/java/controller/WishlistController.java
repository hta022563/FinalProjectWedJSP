package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductDAO;
import model.ProductDTO;
import model.UserDTO;
import model.WishlistDAO;

@WebServlet(name = "WishlistController", urlPatterns = {"/WishlistController"})
public class WishlistController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        WishlistDAO wDao = new WishlistDAO();
        List<Integer> wishlist = wDao.getWishlistByUser(user.getUserID());

        if ("add".equals(action)) {
            String productIdStr = request.getParameter("productId");
            String returnUrl = request.getParameter("returnUrl");

            if (productIdStr != null && !productIdStr.isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                if (!wishlist.contains(productId)) {
                    wDao.add(user.getUserID(), productId);
                    wishlist = wDao.getWishlistByUser(user.getUserID());
                }
            }
            session.setAttribute("wishlist", wishlist);
            if (returnUrl != null && !returnUrl.isEmpty()) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect("MainController?target=Product");
            }

        } else if ("remove".equals(action)) {
            String productIdStr = request.getParameter("productId");
            String returnUrl = request.getParameter("returnUrl");

            if (productIdStr != null && !productIdStr.isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                wDao.remove(user.getUserID(), productId);
                wishlist = wDao.getWishlistByUser(user.getUserID());
            }
            session.setAttribute("wishlist", wishlist);
            if (returnUrl != null && !returnUrl.isEmpty()) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect("MainController?target=Wishlist&action=view");
            }

        } else if ("view".equals(action)) {
            session.setAttribute("wishlist", wishlist);
            List<ProductDTO> listWishlistCars = new ArrayList<>();
            if (!wishlist.isEmpty()) {
                ProductDAO dao = new ProductDAO();
                for (int pid : wishlist) {
                    ProductDTO p = dao.getProductById(pid);
                    if (p != null) {
                        listWishlistCars.add(p);
                    }
                }
            }
            request.setAttribute("listWishlistCars", listWishlistCars);
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
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
}
