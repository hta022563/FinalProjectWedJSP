package controller;

import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import utils.EmailUtils;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Chống lỗi font chữ tiếng Việt
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            // ==========================================
            // LUỒNG 1: KHÁCH BẤM GỬI EMAIL ĐỂ NHẬN OTP
            // ==========================================
        if ("sendOTP".equals(action)) {
                String email = request.getParameter("email");
                
                // THÊM ĐOẠN NÀY: Gọi DAO ra kiểm tra Email trước!
                UserDAO dao = new UserDAO();
                if (!dao.checkEmailExist(email)) {
                    // Nếu không có trong DB -> Đuổi về ngay và luôn
                    request.setAttribute("error", "Email này chưa được đăng ký trong hệ thống F-AUTO!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                    return; // Dừng chạy đoạn code bên dưới
                }

                // Nếu Email chuẩn rồi thì mới cho máy tạo OTP và gửi đi
                Random rnd = new Random();
                int number = rnd.nextInt(999999);
                String otp = String.format("%06d", number);

                // 2. Cất OTP và Email vào Session để chút nữa còn lôi ra so sánh
                session.setAttribute("otp_cua_khach", otp);
                session.setAttribute("email_dang_khoi_phuc", email);

                // 3. Gọi EmailUtils để gửi thư
                String tieuDe = "Mã xác nhận khôi phục mật khẩu F-AUTO";
                String noiDung = "Chào quý khách,\n\nMã OTP để khôi phục mật khẩu tài khoản của bạn là: " + otp + "\n\nVui lòng không chia sẻ mã này cho bất kỳ ai.";
                
                boolean isSent = EmailUtils.sendEmail(email, tieuDe, noiDung);

                if (isSent) {
                    // Gửi mail thành công -> Chuyển sang trang nhập OTP
                    request.setAttribute("message", "Mã OTP đã được gửi! Vui lòng kiểm tra hộp thư Gmail của bạn.");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Lỗi hệ thống gửi mail. Vui lòng kiểm tra lại cấu hình EmailUtils!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                }
            } 
            // ==========================================
            // LUỒNG 2: KHÁCH NHẬP OTP ĐỂ HỆ THỐNG XÁC MINH
            // ==========================================
            else if ("verifyOTP".equals(action)) {
                String otpKhachNhap = request.getParameter("otp");
                // Lấy cái OTP hồi nãy hệ thống cất trong tủ ra
                String otpHeThong = (String) session.getAttribute("otp_cua_khach");

                // Kiểm tra 2 số có khớp nhau không
                if (otpKhachNhap != null && otpKhachNhap.equals(otpHeThong)) {
                    // Khớp! Cho phép chuyển sang trang đổi pass mới
                    request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại!");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                }
            }
            // ==========================================
            // LUỒNG 3: KHÁCH ĐẶT LẠI MẬT KHẨU MỚI
            // ==========================================
            else if ("resetPassword".equals(action)) {
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                String email = (String) session.getAttribute("email_dang_khoi_phuc");

                if (newPassword.equals(confirmPassword)) {
                    // Gọi DAO băm pass mới và lưu đè xuống DB
                    UserDAO dao = new UserDAO();
                    boolean isUpdated = dao.updatePasswordByEmail(email, newPassword);

                    if (isUpdated) {
                        // Đổi thành công -> Dọn sạch sẽ Session để bảo mật
                        session.removeAttribute("otp_cua_khach");
                        session.removeAttribute("email_dang_khoi_phuc");
                        
                        request.setAttribute("message", "Đổi mật khẩu thành công! Mời đăng nhập lại hệ thống F-AUTO.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Lỗi cập nhật Database. Có thể Email này không tồn tại trong hệ thống.");
                        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Hai mật khẩu không khớp nhau!");
                    request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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