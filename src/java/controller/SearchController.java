package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductDAO;
import model.ProductDTO;
import model.SearchHistoryDAO;
import model.SearchHistoryDTO;

@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Chống lỗi font chữ tiếng Việt khi tìm kiếm
        
        // 1. Hứng từ khóa từ thanh tìm kiếm trên giao diện
        String keyword = request.getParameter("keyword");
        
        SearchHistoryDAO searchDAO = new SearchHistoryDAO();
        ProductDAO productDAO = new ProductDAO();

        // 2. NGHIỆP VỤ 1: LƯU TỪ KHÓA MỚI HOẶC CẬP NHẬT SỐ LẦN TÌM
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchDAO.saveOrUpdateSearch(keyword); // Tự động check và +1 cực mượt
            
            // Lấy danh sách xe khớp với từ khóa (Giả định Hảo đã có hàm này trong ProductDAO)
            List<ProductDTO> searchResults = productDAO.searchProductsByName(keyword);
           request.setAttribute("listP", searchResults);
            request.setAttribute("currentKeyword", keyword); // Giữ lại chữ đang gõ trên ô Search
        } else {
            // Nếu khách không gõ gì mà ấn Enter -> Load lại toàn bộ xe
            request.setAttribute("productList", productDAO.getAllProducts());
        }

        // 3. NGHIỆP VỤ 2: LẤY TOP 5 TỪ KHÓA HOT NHẤT
        List<SearchHistoryDTO> topSearches = searchDAO.getTopSearches(5);
        request.setAttribute("topSearches", topSearches); // Nhét vào Request để đưa sang JSP

        // 4. Đẩy kết quả về trang hiển thị (Ví dụ: shop.jsp hoặc search-result.jsp)
        request.getRequestDispatcher("product.jsp").forward(request, response);
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