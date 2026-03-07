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

        // Nút bấm từ form login.jsp
        String txtUsername = request.getParameter("txtUsername");
        String txtPassword = request.getParameter("txtPassword");

        UserDAO udao = new UserDAO();
        UserDTO user = udao.login(txtUsername, txtPassword);

        if (user != null) {
            // Lưu thông tin user vào session
            session.setAttribute("user", user);
            url = "home.jsp";
            // Dùng sendRedirect để đổi hẳn URL thay vì forward
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
        return "UserController handles login and logout via action parameter";
    }
}
