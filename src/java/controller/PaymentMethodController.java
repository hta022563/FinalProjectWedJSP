package controller;

import model.PaymentMethodDAO;
import model.PaymentMethodDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PaymentMethodController", urlPatterns = {"/PaymentMethodController"})
public class PaymentMethodController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PaymentMethodDAO dao = new PaymentMethodDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("methodName");
                if (name != null && !name.trim().isEmpty()) {
                    boolean success = dao.insert(name);
                    if (!success) request.setAttribute("errorMessage", "Thêm thất bại!");
                } else {
                    request.setAttribute("errorMessage", "Tên phương thức không được trống!");
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.softDelete(id);
                        if (!success) request.setAttribute("errorMessage", "Xóa thất bại!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                }
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String name = request.getParameter("methodName");
                if (idStr != null && name != null && !name.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.update(id, name);
                        if (!success) request.setAttribute("errorMessage", "Cập nhật thất bại!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên phương thức bắt buộc nhập!");
                }
            } else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.restore(id);
                        if (!success) request.setAttribute("errorMessage", "Khôi phục thất bại!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
        } finally {
            try {
                // Prepare data for the JSP
                List<PaymentMethodDTO> listActive = dao.getAllActive();
                List<PaymentMethodDTO> listDeleted = dao.getDeletedAll();
                request.setAttribute("listPaymentMethod", listActive);
                request.setAttribute("listDeletedPaymentMethod", listDeleted);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi tải dữ liệu!");
            }
            request.getRequestDispatcher("payment_method.jsp").forward(request, response);
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