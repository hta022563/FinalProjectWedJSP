package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;
import javax.servlet.http.Part;
import java.io.File;
import model.ActivityDAO;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    // --- 1. XỬ LÝ ĐĂNG NHẬP ---
    protected void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String txtUsername = request.getParameter("txtUsername");
        String txtPassword = request.getParameter("txtPassword");
        String remember = request.getParameter("remember");

        UserDAO udao = new UserDAO();
        UserDTO user = udao.login(txtUsername, txtPassword);

        if (user != null) {
            session.setAttribute("user", user);

            if (remember != null) {
                String encryptedUser = utils.SecurityUtils.encrypt(txtUsername);
                String encryptedPass = utils.SecurityUtils.encrypt(txtPassword);

                javax.servlet.http.Cookie cUser = new javax.servlet.http.Cookie("cUser", encryptedUser);
                javax.servlet.http.Cookie cPass = new javax.servlet.http.Cookie("cPass", encryptedPass);
                
                cUser.setPath("/");
                cPass.setPath("/");
                cUser.setMaxAge(7 * 24 * 60 * 60); 
                cPass.setMaxAge(7 * 24 * 60 * 60);
                
                response.addCookie(cUser);
                response.addCookie(cPass);
            } else {
                javax.servlet.http.Cookie cUser = new javax.servlet.http.Cookie("cUser", "");
                javax.servlet.http.Cookie cPass = new javax.servlet.http.Cookie("cPass", "");
                cUser.setPath("/");
                cPass.setPath("/");
                cUser.setMaxAge(0);
                cPass.setMaxAge(0);
                response.addCookie(cUser);
                response.addCookie(cPass);
            }
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // --- 2. XỬ LÝ ĐĂNG XUẤT ---
    protected void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            session.invalidate(); 
        }
        response.sendRedirect("login.jsp");
    }

    // --- 3. XỬ LÝ ĐĂNG KÝ (SẠCH BONG TIẾNG VIỆT) ---
    protected void doRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nhờ có Filter gác cổng, sếp cứ lấy Parameter bình thường, tự ra tiếng Việt chuẩn
        String username = request.getParameter("txtUsername");
        String pass = request.getParameter("txtPassword");
        String confirmPass = request.getParameter("txtConfirmPassword");
        String fullName = request.getParameter("txtFullName");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");

        if (!pass.equals(confirmPass)) {
            request.setAttribute("ERROR", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.checkUserExist(username)) {
            request.setAttribute("ERROR", "Tên đăng nhập này đã có người sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDTO newUser = new UserDTO();
        newUser.setUsername(username);
        newUser.setPassword(pass); 
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setRole(0); 

        if (dao.register(newUser)) {
            // Log activity nhận fullName tiếng Việt nét căng
            ActivityDAO actDao = new ActivityDAO();
            actDao.logActivity("SYSTEM", "Gia nhập hệ thống: " + fullName, username, "NEW-USER", null);
            
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // LỖI NÀY THƯỜNG DO DATABASE KHÔNG NHẬN ĐƯỢC DỮ LIỆU (Check độ dài cột Password nhé)
            request.setAttribute("ERROR", "Lỗi hệ thống Database!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // --- 4. CẬP NHẬT PROFILE ---
    protected void doUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");

        if (currentUser != null) {
            // Lấy dữ liệu trực tiếp, Filter đã lo phần xử lý ISO -> UTF-8
            currentUser.setFullName(request.getParameter("txtFullName"));
            currentUser.setEmail(request.getParameter("txtEmail"));
            currentUser.setPhone(request.getParameter("txtPhone"));

            if (new UserDAO().updateProfile(currentUser)) {
                session.setAttribute("user", currentUser); 
                request.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
            } else {
                request.setAttribute("error", "Lỗi hệ thống!");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); 
        }
    }

    // --- 5. ĐỔI MẬT KHẨU ---
    protected void doChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");

        if (currentUser != null) {
            String oldPass = request.getParameter("oldPassword");
            String newPass = request.getParameter("newPassword");
            String confirmPass = request.getParameter("confirmPassword");
            String inputOtp = request.getParameter("otp"); 
            String sessionOtp = (String) session.getAttribute("change_pass_otp"); 

            if (sessionOtp == null || !sessionOtp.equals(inputOtp)) {
                request.setAttribute("error", "Mã OTP không chính xác!");
            } else {
                String hashedOldPass = utils.SecurityUtils.hashPassword(oldPass);

                if (!currentUser.getPassword().equals(hashedOldPass)) {
                    request.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
                } else if (!newPass.equals(confirmPass)) {
                    request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
                } else {
                    String hashedNewPass = utils.SecurityUtils.hashPassword(newPass);
                    if (new model.UserDAO().changePassword(currentUser.getUserID(), hashedNewPass)) {
                        session.removeAttribute("change_pass_otp");
                        currentUser.setPassword(hashedNewPass);
                        session.setAttribute("user", currentUser);
                        request.setAttribute("message", "Đã cập nhật mật khẩu mới.");
                    } else {
                        request.setAttribute("error", "Lỗi hệ thống Database!");
                    }
                }
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doSendChangePassOTP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");

        if (currentUser != null && currentUser.getEmail() != null) {
            String otp = String.format("%06d", new java.util.Random().nextInt(999999));
            session.setAttribute("change_pass_otp", otp);
            String subject = "[F-AUTO] MÃ XÁC THỰC BẢO MẬT TÀI KHOẢN";
            String bodyHtml = utils.EmailUtils.getOtpEmailTemplate(currentUser.getFullName(), otp);
            utils.EmailUtils.sendEmail(currentUser.getEmail(), subject, bodyHtml);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }

    // --- ĐIỀU PHỐI CHÍNH ---
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if (action.equals("updateProfile")) {
            doUpdateProfile(request, response);
        } else if (action.equals("changePassword")) {
            doChangePassword(request, response);
        } else if (action.equals("sendChangePassOTP")) {
            doSendChangePassOTP(request, response);
        } else if (action.equals("uploadAvatar")) {
            handleAvatarUpload(request, response);
        }
    }

    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("user");
        if (currentUser != null) {
            try {
                Part filePart = request.getPart("avatarFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = "avatar_" + currentUser.getUserID() + ".jpg";
                    String uploadPath = request.getServletContext().getRealPath("") + File.separator + "IMG" + File.separator + "avatars";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    filePart.write(uploadPath + File.separator + fileName);
                    request.setAttribute("message", "Đã cập nhật ảnh đại diện thành công!");
                } else {
                    request.setAttribute("error", "Vui lòng chọn một ảnh hợp lệ.");
                }
            } catch (Exception e) {
                request.setAttribute("error", "Hệ thống lỗi lưu ảnh: " + e.getMessage());
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
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
        return "UserController handles all user-related actions";
    }
}