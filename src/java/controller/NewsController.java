package controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.NewsDAO;
import model.NewsDTO;

@WebServlet(name = "NewsController", urlPatterns = {"/NewsController"})
public class NewsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Đảm bảo tiếng Việt không bị lỗi font khi form gửi lên
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        NewsDAO dao = new NewsDAO();

        try {
            if ("delete".equals(action)) {
                // XÓA BÀI VIẾT
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteNews(id);
                response.sendRedirect("NewsController");
                
            } else if ("edit".equals(action)) {
                // SỬA BÀI VIẾT
                int id = Integer.parseInt(request.getParameter("id"));
                NewsDTO editNews = dao.getNewsByID(id);
                request.setAttribute("editNews", editNews); 
                
                // Load danh sách tin tức
                List<NewsDTO> listNews = dao.getAllNews();
                request.setAttribute("listN", listNews);
                request.getRequestDispatcher("news.jsp").forward(request, response);
                
            } else if ("save".equals(action)) {
                // LƯU BÀI VIẾT (THÊM MỚI & CẬP NHẬT)
                String idStr = request.getParameter("newsID");
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String thumbnail = request.getParameter("thumbnail");
                String externalLink = request.getParameter("externalLink");

                NewsDTO news = new NewsDTO();
                news.setTitle(title);
                news.setContent(content);
                news.setThumbnail(thumbnail);
                news.setExternalLink(externalLink);
                news.setPublishDate(new Date());

                if (idStr == null || idStr.trim().isEmpty()) {
                    dao.addNews(news); 
                } else {
                    news.setNewsID(Integer.parseInt(idStr));
                    dao.updateNews(news); 
                }
                response.sendRedirect("NewsController");
                
            } else {
                // MẶC ĐỊNH LÀ DANH SÁCH
                List<NewsDTO> listNews = dao.getAllNews();
                request.setAttribute("listN", listNews);
                request.getRequestDispatcher("news.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("NewsController");
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