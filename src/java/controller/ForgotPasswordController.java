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
        
        response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
        if ("sendOTP".equals(action)) {
                String email = request.getParameter("email");
                
                model.UserDAO dao = new model.UserDAO();
                if (!dao.checkEmailExist(email)) {
                    request.setAttribute("error", "Email này chưa được đăng ký trong hệ thống F-AUTO!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                    return; 
                }

                java.util.Random rnd = new java.util.Random();
                int number = rnd.nextInt(999999);
                String otp = String.format("%06d", number);

                session.setAttribute("otp_cua_khach", otp);
                session.setAttribute("email_dang_khoi_phuc", email);

                String subject = "[F-AUTO] MÃ XÁC THỰC KHÔI PHỤC MẬT KHẨU";
                
                String bodyHtml = utils.EmailUtils.getOtpEmailTemplate("Quý khách", otp);
                
                boolean isSent = utils.EmailUtils.sendEmail(email, subject, bodyHtml);

                if (isSent) {
                    request.setAttribute("message", "Mã OTP đã được gửi! Vui lòng kiểm tra hộp thư Gmail của bạn.");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Lỗi hệ thống gửi mail. Vui lòng kiểm tra lại kết nối mạng!");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
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