package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();

        try {
            // LUỒNG 1: GỬI OTP (Sếp đã làm, tui tối ưu lại tí)
            if ("sendOTP".equals(action)) {
                String email = request.getParameter("email");
                if (!dao.checkEmailExist(email)) {
                    request.setAttribute("error", "Email này chưa có trong hệ thống F-AUTO!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                    return;
                }

                java.util.Random rnd = new java.util.Random();
                String otp = String.format("%06d", rnd.nextInt(999999));
                session.setAttribute("otp_cua_khach", otp);
                session.setAttribute("email_dang_khoi_phuc", email);

                String subject = "[F-AUTO] MÃ XÁC THỰC KHÔI PHỤC MẬT KHẨU";
                String bodyHtml = utils.EmailUtils.getOtpEmailTemplate("Quý khách", otp);
                
                if (utils.EmailUtils.sendEmail(email, subject, bodyHtml)) {
                    request.setAttribute("message", "Mã OTP đã được gửi đến Gmail của bạn!");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Lỗi gửi mail. Thử lại sau!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                }
            } 
            
            // LUỒNG 2: XÁC MINH OTP (SẾP ĐANG THIẾU CÁI NÀY)
            else if ("verifyOTP".equals(action)) {
                String inputOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("otp_cua_khach");

                if (inputOtp != null && inputOtp.equals(sessionOtp)) {
                    // Mã đúng -> Cho sang trang nhập mật khẩu mới
                    request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại!");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                }
            }

            // LUỒNG 3: ĐẶT LẠI MẬT KHẨU MỚI (SẾP CŨNG ĐANG THIẾU)
            else if ("resetPassword".equals(action)) {
                String newPass = request.getParameter("newPassword");
                String confirmPass = request.getParameter("confirmPassword");
                String email = (String) session.getAttribute("email_dang_khoi_phuc");

                if (newPass.equals(confirmPass)) {
                    // Gọi DAO cập nhật mật khẩu vào Database (Nhớ viết hàm updatePassword trong UserDAO nhé)
                    boolean isUpdated = dao.updatePasswordByEmail(email, newPass); 
                    if (isUpdated) {
                        session.removeAttribute("otp_cua_khach");
                        session.removeAttribute("email_dang_khoi_phuc");
                        request.setAttribute("msg", "Đổi mật khẩu thành công! Mời bạn đăng nhập.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Lỗi cập nhật mật khẩu. Thử lại sau!");
                        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
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