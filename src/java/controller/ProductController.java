package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductDAO;
import model.ProductDTO;
import model.SearchHistoryDAO;
import model.SearchHistoryDTO;
import model.UserDTO;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword"); // Hứng từ khóa nếu có

        ProductDAO dao = new ProductDAO();
        SearchHistoryDAO trendDAO = new SearchHistoryDAO(); // Khởi tạo DAO xu hướng
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // ==========================================================
        // 1. GỘP CHUNG HIỂN THỊ DANH SÁCH (ADMIN, KHÁCH VÀ TÌM KIẾM)
        // ==========================================================
        if (action == null || action.equals("list")) {
            List<ProductDTO> listProduct;

            // TRƯỜNG HỢP 1: CÓ GÕ TÌM KIẾM
            if (keyword != null && !keyword.trim().isEmpty()) {
                trendDAO.saveOrUpdateSearch(keyword); // Lưu vào DB để đua Top
                listProduct = dao.searchProductsByName(keyword); // Lấy xe theo tên
                request.setAttribute("currentKeyword", keyword); // Giữ lại chữ đang gõ trên ô Search
            } 
            // TRƯỜNG HỢP 2: KHÔNG TÌM KIẾM (BẤM TỪ MENU VÀO)
            else {
                // Kiểm tra phân quyền: Admin lấy hết, Khách chỉ lấy xe đang bán
                if (user != null && user.getRole() == 1) {
                    listProduct = dao.getAllProducts();
                } else {
                    listProduct = dao.getActiveProducts();
                }
            }

            // Lấy Top 4 Xu Hướng nhét vào chung luôn
            List<SearchHistoryDTO> topTrending = trendDAO.getTopSearches(4);
            
            // Đóng gói tất cả đẩy sang JSP
            request.setAttribute("listP", listProduct);
            request.setAttribute("topSearches", topTrending);
            request.getRequestDispatcher("product.jsp").forward(request, response);

        // ==========================================================
        // 2. CÁC CHỨC NĂNG CỦA ADMIN (XÓA, SỬA, LƯU)
        // ==========================================================
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("ProductController");

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDTO p = dao.getProductById(id);
            request.setAttribute("product", p);
            request.getRequestDispatcher("admin-product-form.jsp").forward(request, response);

        } else if (action.equals("save")) {
            String idStr = request.getParameter("productID");
            int cateID = Integer.parseInt(request.getParameter("categoryID"));
            int suppID = Integer.parseInt(request.getParameter("supplierID"));
            String name = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stockQuantity"));
            String desc = request.getParameter("description");
            String img = request.getParameter("imageURL");

            boolean status = request.getParameter("status") != null ? Boolean.parseBoolean(request.getParameter("status")) : true;

            if (idStr == null || idStr.isEmpty()) {
                dao.addProduct(new ProductDTO(0, cateID, suppID, name, price, stock, desc, img, true));
            } else {
                int id = Integer.parseInt(idStr);
                dao.updateProduct(new ProductDTO(id, cateID, suppID, name, price, stock, desc, img, status));
            }
            response.sendRedirect("ProductController"); 
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}