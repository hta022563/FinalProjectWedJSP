package controller;

import model.PaymentMethodDAO;
import model.PaymentMethodDTO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "PaymentMethodController", urlPatterns = {"/PaymentMethodController"})
// THÊM ĐOẠN NÀY ĐỂ SERVLET CÓ THỂ NHẬN FILE TỪ FORM ENCTYPE="MULTIPART/FORM-DATA"
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class PaymentMethodController extends HttpServlet {

    // --- HÀM HỖ TRỢ UPLOAD FILE TỰ ĐỘNG ---
    private String uploadFile(HttpServletRequest request, Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null; // Nếu ko chọn file thì bỏ qua
        
        // Lấy tên file gốc
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        // Chống trùng lặp tên file bằng cách gắn thời gian vào trước
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        
        // Đường dẫn tới thư mục web/IMG của project
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + "IMG";
        
        // Tạo folder IMG nếu nó chưa có
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        
        // Ghi file xuống ổ cứng
        filePart.write(uploadFilePath + File.separator + uniqueFileName);
        
        // Trả về chuỗi để lưu Database
        return "IMG/" + uniqueFileName;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PaymentMethodDAO dao = new PaymentMethodDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("methodName");
                String code = request.getParameter("methodCode");
                String icon = request.getParameter("iconClass");
                String desc = request.getParameter("description");
                String bank = request.getParameter("bankName");
                String accNo = request.getParameter("accountNo");
                String accName = request.getParameter("accountName");
                
                // BẮT FILE TỪ FORM JPS BẰNG getPart, GỌI HÀM UPLOAD
                Part filePart = request.getPart("qrCodeFile");
                String qr = uploadFile(request, filePart); 

                if (name != null && !name.trim().isEmpty()) {
                    boolean success = dao.insert(name, code, icon, desc, bank, accNo, accName, qr);
                    if (!success) request.setAttribute("errorMessage", "Thêm thất bại!");
                } else {
                    request.setAttribute("errorMessage", "Tên phương thức không được trống!");
                }
                
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String name = request.getParameter("methodName");
                String code = request.getParameter("methodCode");
                String icon = request.getParameter("iconClass");
                String desc = request.getParameter("description");
                String bank = request.getParameter("bankName");
                String accNo = request.getParameter("accountNo");
                String accName = request.getParameter("accountName");
                
                // Lấy ảnh cũ đề phòng trường hợp Admin không upload ảnh mới
                String qr = request.getParameter("oldQrCodeURL"); 
                
                // THỬ BẮT FILE ẢNH MỚI
                Part filePart = request.getPart("qrCodeFile");
                String newQr = uploadFile(request, filePart);
                
                // Nếu Admin có chọn file mới thì xài file mới, không thì giữ lại link cũ
                if (newQr != null) {
                    qr = newQr;
                }

                if (idStr != null && name != null && !name.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.update(id, name, code, icon, desc, bank, accNo, accName, qr);
                        if (!success) request.setAttribute("errorMessage", "Cập nhật thất bại!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "ID không hợp lệ!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên phương thức bắt buộc nhập!");
                }
                
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        dao.softDelete(id);
                    } catch (NumberFormatException e) {}
                }
            } else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        dao.restore(id);
                    } catch (NumberFormatException e) {}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
        } finally {
            try {
                List<PaymentMethodDTO> listActive = dao.getAllActive();
                List<PaymentMethodDTO> listDeleted = dao.getDeletedAll();
                request.setAttribute("listPaymentMethod", listActive);
                request.setAttribute("listDeletedPaymentMethod", listDeleted);
            } catch (Exception e) {
                e.printStackTrace();
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