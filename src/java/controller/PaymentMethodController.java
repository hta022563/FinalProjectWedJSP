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
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class PaymentMethodController extends HttpServlet {

    private String uploadFile(HttpServletRequest request, Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + "IMG";

        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        filePart.write(uploadFilePath + File.separator + uniqueFileName);
        return "IMG/" + uniqueFileName;
    }

    private void keepFormData(HttpServletRequest request, String name, String code, String icon, String desc, String bank, String accNo, String accName) {
        request.setAttribute("keepName", name);
        request.setAttribute("keepCode", code);
        request.setAttribute("keepIcon", icon);
        request.setAttribute("keepDesc", desc);
        request.setAttribute("keepBank", bank);
        request.setAttribute("keepAccNo", accNo);
        request.setAttribute("keepAccName", accName);
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

                String qr = null;
                try {
                    if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                        Part filePart = request.getPart("qrCodeFile");
                        qr = uploadFile(request, filePart);
                    }
                } catch (Exception e) {
                    System.out.println("Form không có file đính kèm.");
                }

                if (name != null && !name.trim().isEmpty()) {
                    boolean success = dao.insert(name, code, icon, desc, bank, accNo, accName, qr);
                    if (!success) {
                        request.setAttribute("errorMessage", "Thêm thất bại do lỗi Database!");
                        keepFormData(request, name, code, icon, desc, bank, accNo, accName);
                    } else {
                        request.setAttribute("successMessage", "Thêm phương thức thành công!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Tên phương thức không được trống!");
                    keepFormData(request, name, code, icon, desc, bank, accNo, accName);
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

                String qr = request.getParameter("oldQrCodeURL");

                try {
                    if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                        Part filePart = request.getPart("qrCodeFile");
                        String newQr = uploadFile(request, filePart);
                        if (newQr != null) {
                            qr = newQr;
                        }
                    }
                } catch (Exception e) {
                }

                if (idStr != null && name != null && !name.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        boolean success = dao.update(id, name, code, icon, desc, bank, accNo, accName, qr);
                        if (!success) {
                            request.setAttribute("errorMessage", "Cập nhật thất bại!");
                        } else {
                            request.setAttribute("successMessage", "Cập nhật thành công!");
                        }
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
                        request.setAttribute("successMessage", "Đã tạm ngưng phương thức!");
                    } catch (NumberFormatException e) {
                    }
                }
            } else if ("restore".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        dao.restore(id);
                        request.setAttribute("successMessage", "Đã khôi phục phương thức!");
                    } catch (NumberFormatException e) {
                    }
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
