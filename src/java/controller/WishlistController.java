/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

/**
 *
 * @author AngDeng
 */
@WebServlet(name = "WishlistController", urlPatterns = {"/WishlistController"})
public class WishlistController extends HttpServlet {

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
        
        String action = request.getParameter("action");
        if (action == null) action = "view"; 
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        WishlistDAO wDao = new WishlistDAO();

        // 1. TẢI DỮ LIỆU WISHLIST LÊN
        List<Integer> wishlist = new ArrayList<>();
        if (user != null) {
            // Nếu đã đăng nhập -> Lấy data bất tử từ Database
            wishlist = wDao.getWishlistByUser(user.getUserID());
            
            // Gộp tự động: Nếu lúc chưa đăng nhập khách có thả tim dở dang, thì nhét luôn vào DB
            List<Integer> sessionWishlist = (List<Integer>) session.getAttribute("wishlist");
            if (sessionWishlist != null && !sessionWishlist.isEmpty()) {
                for (int pid : sessionWishlist) {
                    wDao.add(user.getUserID(), pid);
                }
                wishlist = wDao.getWishlistByUser(user.getUserID()); // Tải lại list mới
                session.removeAttribute("wishlist"); // Dọn dẹp rác session
            }
        } else {
            // Nếu chưa đăng nhập -> Lấy list tạm thời từ Session
            wishlist = (List<Integer>) session.getAttribute("wishlist");
            if (wishlist == null) wishlist = new ArrayList<>();
        }

        // 2. XỬ LÝ NÚT BẤM (ADD / REMOVE / VIEW)
        if ("add".equals(action)) {
            String productIdStr = request.getParameter("productId");
            String returnUrl = request.getParameter("returnUrl");
            
            if (productIdStr != null && !productIdStr.isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                if (!wishlist.contains(productId)) {
                    if (user != null) {
                        wDao.add(user.getUserID(), productId); // Lưu hẳn vào DB
                        wishlist = wDao.getWishlistByUser(user.getUserID());
                    } else {
                        wishlist.add(productId); // Lưu tạm vào Session
                    }
                    session.setAttribute("msg", "Đã thả tim! Siêu phẩm được thêm vào Danh sách Yêu thích.");
                } else {
                    session.setAttribute("msg", "Siêu phẩm này đã có sẵn trong tim bạn rồi!");
                }
            }
            session.setAttribute("wishlist", wishlist); // Đồng bộ lại đếm số Icon trên Header
            if (returnUrl != null && !returnUrl.isEmpty()) { response.sendRedirect(returnUrl); } 
            else { response.sendRedirect("MainController?target=Product"); }
            
        } else if ("remove".equals(action)) {
            String productIdStr = request.getParameter("productId");
            String returnUrl = request.getParameter("returnUrl");
            
            if (productIdStr != null && !productIdStr.isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                if (user != null) {
                    wDao.remove(user.getUserID(), productId); // Xóa DB
                    wishlist = wDao.getWishlistByUser(user.getUserID());
                } else {
                    wishlist.remove(Integer.valueOf(productId)); // Xóa Session
                }
                session.setAttribute("msg", "Đã bỏ siêu phẩm khỏi danh sách Yêu thích!");
            }
            session.setAttribute("wishlist", wishlist);
            if (returnUrl != null && !returnUrl.isEmpty()) { response.sendRedirect(returnUrl); } 
            else { response.sendRedirect("MainController?target=Wishlist&action=view"); }
            
        } else if ("view".equals(action)) {
            session.setAttribute("wishlist", wishlist);
            List<ProductDTO> listWishlistCars = new ArrayList<>();
            if (!wishlist.isEmpty()) {
                ProductDAO dao = new ProductDAO();
                for (int pid : wishlist) {
                    ProductDTO p = dao.getProductById(pid);
                    if (p != null) listWishlistCars.add(p);
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
