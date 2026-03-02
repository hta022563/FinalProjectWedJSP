package controller;

import model.ProductCategoryDAO;
import model.ProductCategoryDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryController", urlPatterns = {"/CategoryController"})
public class CategoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        ProductCategoryDAO dao = new ProductCategoryDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("categoryName");
                if (name != null && !name.trim().isEmpty()) {
                    boolean success = dao.insert(name);
                    if (!success) {
                        request.setAttribute("errorMessage", "Thêm danh mục thất bại!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên danh mục không được để trống!");
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.delete(id);
                        if (!success) {
                            request.setAttribute("errorMessage", "Xóa danh mục thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
                    }
                }
            } // 3. Xử lý SỬA (Update) - MỚI THÊM
            else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String newName = request.getParameter("newCategoryName");

                if (idStr != null && newName != null && !newName.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.update(id, newName);
                        if (!success) {
                            request.setAttribute("errorMessage", "Cập nhật danh mục thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên danh mục không được để trống!");
                }
            } // 4. Xử lý KHÔI PHỤC (Restore)
            else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.restore(id);
                        if (!success) {
                            request.setAttribute("errorMessage", "Khôi phục danh mục thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
        } finally {
           try {
                // Lấy danh sách đang hoạt động
                List<ProductCategoryDTO> list = dao.getAll(); 
                // Lấy danh sách đã xóa (Thùng rác)
                List<ProductCategoryDTO> listDeleted = dao.getDeletedAll(); 
                
                request.setAttribute("listCategory", list);
                request.setAttribute("listDeleted", listDeleted); // Gửi thêm thùng rác sang JSP
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi tải danh mục!");
            }
            request.getRequestDispatcher("category.jsp").forward(request, response);
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
