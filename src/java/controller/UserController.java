/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    protected void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String url = "";

        HttpSession session = request.getSession();

        String txtUsername = request.getParameter("txtUsername");
        String txtPassword = request.getParameter("txtPassword");
        // Lấy giá trị của ô checkbox "Ghi nhớ tôi"
        String remember = request.getParameter("remember");

        UserDAO udao = new UserDAO();
        UserDTO user = udao.login(txtUsername, txtPassword);

        if (user != null) {
            session.setAttribute("user", user);

            // --- XỬ LÝ COOKIE (GHI NHỚ TÀI KHOẢN) ---
            // Tạo 2 cái thẻ Cookie để lưu Username và Password
            javax.servlet.http.Cookie cUser = new javax.servlet.http.Cookie("cUser", txtUsername);
            javax.servlet.http.Cookie cPass = new javax.servlet.http.Cookie("cPass", txtPassword);

            cUser.setPath("/");
            cPass.setPath("/");

            if (remember != null) {
                // Nếu khách có tích chọn -> Lưu Cookie sống 7 ngày (7 * 24 * 60 * 60 giây)
                cUser.setMaxAge(7 * 24 * 60 * 60);
                cPass.setMaxAge(7 * 24 * 60 * 60);
            } else {
                // Nếu khách KHÔNG tích -> Hủy Cookie ngay lập tức (set thời gian = 0)
                cUser.setMaxAge(0);
                cPass.setMaxAge(0);
            }
            // Gắn Cookie vào response để gửi về trình duyệt
            response.addCookie(cUser);
            response.addCookie(cPass);
            // ----------------------------------------

            url = "home.jsp";
            response.sendRedirect(url);
            return;
        } else {
            url = "login.jsp";
            request.setAttribute("message", "Sai tài khoản hoặc mật khẩu!");
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    protected void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            session.invalidate(); // Hủy bỏ toàn bộ nội dung trong session
        }

        String url = "login.jsp";
        response.sendRedirect(url);
    }

    protected void doRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cài đặt tiếng Việt để lưu FullName có dấu không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 1. Lấy dữ liệu từ form register.jsp
        String username = request.getParameter("txtUsername");
        String pass = request.getParameter("txtPassword");
        String confirmPass = request.getParameter("txtConfirmPassword");
        String fullName = request.getParameter("txtFullName");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");

        // 2. Kiểm tra mật khẩu nhập lại có khớp không
        if (!pass.equals(confirmPass)) {
            request.setAttribute("ERROR", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        // 3. Kiểm tra trùng tên đăng nhập
        if (dao.checkUserExist(username)) {
            request.setAttribute("ERROR", "Tên đăng nhập này đã có người sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Tạo đối tượng User mới
        UserDTO newUser = new UserDTO();
        newUser.setUsername(username);
        newUser.setPassword(pass);
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setRole(0); // 0: Mặc định là Khách hàng (Customer)

        // 5. Gọi DAO lưu vào Database
        if (dao.register(newUser)) {
            // Đăng ký thành công -> Đá về trang đăng nhập kèm thông báo
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Đăng ký thất bại do lỗi hệ thống
            request.setAttribute("ERROR", "Lỗi hệ thống, không thể tạo tài khoản lúc này!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // --- HÀM MỚI: XỬ LÝ CẬP NHẬT THÔNG TIN ---
    protected void doUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");

        if (currentUser != null) {
            String fullName = request.getParameter("txtFullName");
            String email = request.getParameter("txtEmail");
            String phone = request.getParameter("txtPhone");

            currentUser.setFullName(fullName);
            currentUser.setEmail(email);
            currentUser.setPhone(phone);

            UserDAO dao = new UserDAO();
            if (dao.updateProfile(currentUser)) {
                session.setAttribute("user", currentUser); // Cập nhật lại session
                request.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
            } else {
                request.setAttribute("error", "Lỗi hệ thống! Không thể cập nhật thông tin.");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); // Lỡ mất session thì bắt đăng nhập lại
        }
    }

    // --- HÀM MỚI: XỬ LÝ ĐỔI MẬT KHẨU ---
    protected void doChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");

        if (currentUser != null) {
            String oldPass = request.getParameter("oldPassword");
            String newPass = request.getParameter("newPassword");
            String confirmPass = request.getParameter("confirmPassword");
            String inputOtp = request.getParameter("otp"); // Lấy OTP khách nhập

            String sessionOtp = (String) session.getAttribute("change_pass_otp"); // Lấy OTP hệ thống đã gửi

            // 1. KIỂM TRA OTP ĐẦU TIÊN
            if (sessionOtp == null || !sessionOtp.equals(inputOtp)) {
                request.setAttribute("error", "Mã OTP không chính xác hoặc bạn chưa bấm Nhận mã!");
            } else {
                // 2. NẾU OTP ĐÚNG -> TIẾP TỤC ĐỔI MẬT KHẨU
                String hashedOldPass = utils.SecurityUtils.hashPassword(oldPass);

                if (!currentUser.getPassword().equals(hashedOldPass)) {
                    request.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
                } else if (!newPass.equals(confirmPass)) {
                    request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
                } else {
                    model.UserDAO dao = new model.UserDAO();
                    String hashedNewPass = utils.SecurityUtils.hashPassword(newPass);

                    if (dao.changePassword(currentUser.getUserID(), hashedNewPass)) {
                        // Đổi thành công -> Tiêu hủy OTP để không dùng lại được nữa
                        session.removeAttribute("change_pass_otp");
                        
                        currentUser.setPassword(hashedNewPass);
                        session.setAttribute("user", currentUser);
                        
                        request.setAttribute("message", "Xác thực 2 lớp thành công! Đã cập nhật mật khẩu mới.");
                    } else {
                        request.setAttribute("error", "Đổi mật khẩu thất bại do lỗi hệ thống Database!");
                    }
                }
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
    // =========================================================================
    // HÀM MỚI: XỬ LÝ GỬI OTP VỀ EMAIL KHI ĐANG ĐĂNG NHẬP
    // =========================================================================
   protected void doSendChangePassOTP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");
        
        if (currentUser != null && currentUser.getEmail() != null) {
            // 1. Random mã OTP
            String otp = String.format("%06d", new java.util.Random().nextInt(999999));
            session.setAttribute("change_pass_otp", otp);
            
            // 2. Nhờ EmailUtils lấy cái giao diện HTML đã vẽ sẵn
            String subject = "[F-AUTO] MÃ XÁC THỰC BẢO MẬT TÀI KHOẢN";
            String bodyHtml = utils.EmailUtils.getOtpEmailTemplate(currentUser.getFullName(), otp);
            
            // 3. Tiến hành gửi mail
            utils.EmailUtils.sendEmail(currentUser.getEmail(), subject, bodyHtml);
            
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("home.jsp");
        } else if (action.equals("login")) {
            doLogin(request, response);
        } else if (action.equals("logout")) {
            doLogout(request, response);
        } else if (action.equals("register")) {
            doRegister(request, response);
        } else if (action.equals("profile")) {
            // Điều hướng sang trang jsp
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if (action.equals("updateProfile")) {
            // Gọi hàm cập nhật
            doUpdateProfile(request, response);
        } else if (action.equals("changePassword")) {
            // Gọi hàm đổi mật khẩu
            doChangePassword(request, response);
        } else if (action.equals("sendChangePassOTP")) {
            doSendChangePassOTP(request, response);
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

    @Override
    public String getServletInfo() {
        return "UserController handles login, logout, register, and profile updates via action parameter";
    }
}
