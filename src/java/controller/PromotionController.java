package controller;

import model.PromotionDAO;
import model.PromotionDTO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PromotionController", urlPatterns = {"/PromotionController"})
public class PromotionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PromotionDAO dao = new PromotionDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String code = request.getParameter("promoCode");
                String percentStr = request.getParameter("discountPercent");
                String startStr = request.getParameter("startDate");
                String endStr = request.getParameter("endDate");

                if (code != null && !code.trim().isEmpty() && percentStr != null) {
                    int percent = Integer.parseInt(percentStr);
                    Date startDate = Date.valueOf(startStr);
                    Date endDate = Date.valueOf(endStr);
                    
                    if (!dao.insert(code, percent, startDate, endDate)) {
                        request.setAttribute("errorMessage", "Thêm thất bại (Có thể mã code đã tồn tại)!");
                    }
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    if (!dao.softDelete(id)) request.setAttribute("errorMessage", "Xóa thất bại!");
                }
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String code = request.getParameter("promoCode");
                String percentStr = request.getParameter("discountPercent");
                String startStr = request.getParameter("startDate");
                String endStr = request.getParameter("endDate");

                if (idStr != null && code != null && !code.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    int percent = Integer.parseInt(percentStr);
                    Date startDate = Date.valueOf(startStr);
                    Date endDate = Date.valueOf(endStr);
                    
                    if (!dao.update(id, code, percent, startDate, endDate)) {
                        request.setAttribute("errorMessage", "Cập nhật thất bại!");
                    }
                }
            } else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    if (!dao.restore(id)) request.setAttribute("errorMessage", "Khôi phục thất bại!");
                }
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Lỗi định dạng ngày tháng hoặc dữ liệu nhập vào!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
        } finally {
            try {
                List<PromotionDTO> listActive = dao.getAllActive();
                List<PromotionDTO> listDeleted = dao.getDeletedAll();
                request.setAttribute("listPromotion", listActive);
                request.setAttribute("listDeletedPromotion", listDeleted);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Lỗi tải dữ liệu!");
            }
            request.getRequestDispatcher("promotion.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}