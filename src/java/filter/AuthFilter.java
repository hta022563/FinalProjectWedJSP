package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDTO;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String requestURI = req.getRequestURI();
        String target = req.getParameter("target");
        String action = req.getParameter("action");

        if (requestURI.matches(".*(css|jpg|png|gif|js|woff|ttf)$")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isAdminArea = requestURI.contains("admin-")
                || requestURI.contains("supplier.jsp")
                || requestURI.contains("promotion.jsp")
                || requestURI.contains("payment_method.jsp")
                || requestURI.contains("recentActivitiesTable.jsp")
                || requestURI.contains("category.jsp")
                || requestURI.contains("DashboardController")
                || requestURI.contains("SupplierController")
                || requestURI.contains("PromotionController")
                || requestURI.contains("PaymentMethodController")
                || requestURI.contains("CategoryController")
                || "Dashboard".equals(target) || "Supplier".equals(target)
                || "Promotion".equals(target) || "Payment".equals(target)
                || "Category".equals(target);

        if ("updateStatus".equals(action)) {
            isAdminArea = true;
        }

        boolean isUserArea = requestURI.contains("cart.jsp")
                || requestURI.contains("checkout.jsp")
                || requestURI.contains("profile.jsp")
                || requestURI.contains("order-")
                || requestURI.contains("contract-pdf.jsp")
                || requestURI.contains("CartController")
                || requestURI.contains("ReviewController")
                || "Cart".equals(target) || "Review".equals(target);

        if ("checkout".equals(action) || "detail".equals(action) || "delete".equals(action) || "exportContract".equals(action)
                || "profile".equals(action) || "updateProfile".equals(action) || "changePassword".equals(action)) {
            isUserArea = true;
        }

        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (isAdminArea) {
            if (currentUser == null || currentUser.getRole() != 1) { // role 1 = Admin
                req.getSession().setAttribute("msgError", "CẢNH BÁO: Khu vực này chỉ dành cho Ban Quản Trị!");
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
        } else if (isUserArea) {
            if (currentUser == null) {
                req.getSession().setAttribute("msgError", "Vui lòng đăng nhập để sử dụng tính năng này!");
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    public void destroy() {
    }
}
