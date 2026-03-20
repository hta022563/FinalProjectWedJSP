package controller;

import model.SupplierDAO;
import model.SupplierDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SupplierController", urlPatterns = {"/SupplierController"})
public class SupplierController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        SupplierDAO dao = new SupplierDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("supplierName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");

                if (name != null && !name.trim().isEmpty()) {
                    boolean success = dao.insert(name, phone, address);
                    if (!success) {
                        request.setAttribute("errorMessage", "Thêm nhà cung cấp thất bại!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên nhà cung cấp không được để trống!");
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.softDelete(id);
                        if (!success) {
                            request.setAttribute("errorMessage", "Xóa thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                }
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String name = request.getParameter("supplierName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");

                if (idStr != null && name != null && !name.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.update(id, name, phone, address);
                        if (!success) {
                            request.setAttribute("errorMessage", "Cập nhật thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên nhà cung cấp bắt buộc nhập!");
                }
            } else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.restore(id);
                        if (!success) {
                            request.setAttribute("errorMessage", "Khôi phục thất bại!");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
        } finally {
            try {
                List<SupplierDTO> listActive = dao.getAllActive();
                List<SupplierDTO> listDeleted = dao.getDeletedAll();

                request.setAttribute("listSupplier", listActive);
                request.setAttribute("listDeletedSupplier", listDeleted);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi tải dữ liệu!");
            }
            request.getRequestDispatcher("supplier.jsp").forward(request, response);
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
