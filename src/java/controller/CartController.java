package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartDAO;
import model.CartDTO;
import model.CartItemDAO;
import model.CartItemDTO;
import model.PromotionDAO;
import model.PromotionDTO;
import model.UserDTO;
import utils.JPAUtil;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        CartDAO cartDAO = new CartDAO();
        CartItemDAO cartItemDAO = new CartItemDAO();

        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");

            if (user == null) {
                session.setAttribute("msgError", "Vui lòng đăng nhập để sử dụng tính năng này!");
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = user.getUserID();

            if ("addToCart".equals(action)) {
                String productIdStr = request.getParameter("productId");
                String quantityStr = request.getParameter("quantity");

                if (productIdStr != null) {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

                    cartDAO.getCartByUserId(userId);

                    boolean success = cartItemDAO.addToCart(userId, productId, quantity);
                    if (success) {
                        session.setAttribute("msg", "Đã thêm siêu phẩm vào gara thành công!");
                    }
                }

                String returnUrl = request.getParameter("returnUrl");
                if (returnUrl == null || returnUrl.isEmpty()) {
                    returnUrl = "home.jsp";
                }

                response.sendRedirect(returnUrl);
                return;

            } else if ("viewCart".equals(action)) {
                CartDTO cart = cartDAO.getCartByUserId(userId);
                List<CartItemDTO> cartItems = cartItemDAO.getCartItems(cart.getCartID());

                Map<Integer, BigDecimal> productPrices = new HashMap<>();
                BigDecimal cartTotal = BigDecimal.ZERO;

                EntityManager em = JPAUtil.getEntityManager();
                try {
                    for (CartItemDTO item : cartItems) {
                        Object priceObj = em.createNativeQuery("SELECT Price FROM Product WHERE ProductID = ?").setParameter(1, item.getProductID()).getSingleResult();
                        BigDecimal price = new BigDecimal(priceObj.toString());
                        productPrices.put(item.getProductID(), price);
                        cartTotal = cartTotal.add(price.multiply(new BigDecimal(item.getQuantity())));
                    }
                } catch (Exception ex) {
                    System.out.println("Lỗi khi tính tổng tiền giỏ hàng: " + ex.getMessage());
                    ex.printStackTrace();
                }

                request.setAttribute("productPrices", productPrices);
                request.setAttribute("cartTotal", cartTotal);
                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("cart.jsp").forward(request, response);

            } else if ("remove".equals(action)) {
                String itemIdStr = request.getParameter("itemId");
                if (itemIdStr != null) {
                    cartItemDAO.removeCartItem(Integer.parseInt(itemIdStr));
                }
                response.sendRedirect("CartController?action=viewCart");

            } else if ("update".equals(action)) {
                String cartItemIdStr = request.getParameter("cartItemId");
                String quantityStr = request.getParameter("quantity");
                if (cartItemIdStr != null && quantityStr != null) {
                    cartItemDAO.updateQuantity(Integer.parseInt(cartItemIdStr), Integer.parseInt(quantityStr));
                }
                response.sendRedirect("CartController?action=viewCart");

            } else if ("applyPromo".equals(action)) {
                String promoCode = request.getParameter("promoCode");

                PromotionDAO promoDao = new PromotionDAO();
                PromotionDTO promo = promoDao.getPromotionByCode(promoCode);

                if (promo != null && promo.getIsActive() == 1) {
                    session.setAttribute("appliedPromoCode", promo.getPromoCode());
                    session.setAttribute("discountPercent", promo.getDiscountPercent());
                    session.setAttribute("promotionId", promo.getPromotionID());
                    session.setAttribute("promoMsg", "Áp dụng mã giảm " + promo.getDiscountPercent() + "% thành công!");
                } else {
                    session.removeAttribute("appliedPromoCode");
                    session.removeAttribute("discountPercent");
                    session.removeAttribute("promotionId");
                    session.setAttribute("promoError", "Mã không hợp lệ hoặc đã hết hạn!");
                }
                response.sendRedirect("MainController?target=Cart&action=viewCart");
                return;
            } else {
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msgError", "Hệ thống bận, vui lòng thử lại sau!");
            response.sendRedirect("ProductController");
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
        return "Short description";
    }

}
