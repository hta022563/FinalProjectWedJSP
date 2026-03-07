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
import model.UserDTO;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // 1. GỘP CHUNG HIỂN THỊ (ADMIN VÀ KHÁCH)
        if (action == null || action.equals("list")) {
            List<ProductDTO> listProduct;
            
            // Nếu là Admin (role == 1) thì lấy TẤT CẢ (cả xe ẩn)
            if (user != null && user.getRole() == 1) {
                listProduct = dao.getAllProducts();
            } else {
                // Nếu là Khách thì chỉ lấy xe ĐANG BÁN
                listProduct = dao.getActiveProducts();
            }
            
            request.setAttribute("listP", listProduct);
            request.getRequestDispatcher("product.jsp").forward(request, response);

        // 2. CÁC CHỨC NĂNG CỦA ADMIN
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("ProductController"); // Trở về trang dùng chung

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
            response.sendRedirect("ProductController"); // Trở về trang dùng chung
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}