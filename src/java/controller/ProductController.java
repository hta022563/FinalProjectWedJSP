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
import model.ActivityDAO;
import model.ProductDAO;
import model.ProductDTO;
import model.SearchHistoryDAO;
import model.SearchHistoryDTO;
import model.UserDTO;
import model.ProductCategoryDAO;
import model.ProductCategoryDTO;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");

        ProductDAO dao = new ProductDAO();
        SearchHistoryDAO trendDAO = new SearchHistoryDAO();

        ProductCategoryDAO catDAO = new ProductCategoryDAO();

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (action == null || action.equals("list")) {
            List<ProductDTO> listProduct;

            if (keyword != null && !keyword.trim().isEmpty()) {
                trendDAO.saveOrUpdateSearch(keyword);
                listProduct = dao.searchProductsByName(keyword);
                request.setAttribute("currentKeyword", keyword);
            } else {
                if (user != null && user.getRole() == 1) {
                    listProduct = dao.getAllProducts();
                } else {
                    listProduct = dao.getActiveProducts();
                }
            }

            List<SearchHistoryDTO> topTrending = trendDAO.getTopSearches(4);
            request.setAttribute("topSearches", topTrending);

            List<ProductCategoryDTO> listCategories = catDAO.getAll();
            request.setAttribute("listCategories", listCategories);

            List<ProductDTO> listCars = new ArrayList<>();
            List<ProductDTO> listParts = new ArrayList<>();

            if (listProduct != null) {
                for (ProductDTO p : listProduct) {
                    int catID = p.getCategoryID();
                    if (catID == 6) {
                        listParts.add(p);
                    } else {
                        listCars.add(p);
                    }
                }
            }

            request.setAttribute("listCars", listCars);
            request.setAttribute("listParts", listParts);
            request.setAttribute("listP", listProduct);

            request.getRequestDispatcher("product.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteProduct(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("ProductController");

        } else if (action.equals("edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                ProductDTO p = dao.getProductById(id);
                request.setAttribute("product", p);
                request.getRequestDispatcher("admin-product-form.jsp").forward(request, response);
            } catch (Exception e) {
                response.sendRedirect("ProductController");
            }

        } else if (action.equals("save")) {
            try {
                String idStr = request.getParameter("productID");
                int cateID = Integer.parseInt(request.getParameter("categoryID"));
                int suppID = Integer.parseInt(request.getParameter("supplierID"));
                String name = request.getParameter("productName");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stockQuantity"));
                String desc = request.getParameter("description");
                String img = request.getParameter("imageURL");

                boolean status = true;
                if (request.getParameter("status") != null) {
                    status = Boolean.parseBoolean(request.getParameter("status"));
                }

                if (idStr == null || idStr.isEmpty()) {
                    dao.addProduct(new ProductDTO(0, cateID, suppID, name, price, stock, desc, img, true));

                    ActivityDAO actDao = new ActivityDAO();
                    actDao.logActivity(
                            "IMPORT",
                            "Nhập kho lô xe mới: " + name,
                            "Admin",
                            "IMP-" + idStr,
                            null
                    );

                } else {
                    int id = Integer.parseInt(idStr);
                    dao.updateProduct(new ProductDTO(id, cateID, suppID, name, price, stock, desc, img, status));
                }
            } catch (Exception e) {
                e.printStackTrace();
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
