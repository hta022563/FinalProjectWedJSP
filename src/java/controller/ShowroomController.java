package controller;

import model.ShowroomDAO;
import model.ShowroomDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ShowroomController", urlPatterns = {"/ShowroomController"})
public class ShowroomController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ShowroomDAO dao = new ShowroomDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String hotline = request.getParameter("hotline");
                if (name != null && !name.trim().isEmpty()) {
                    dao.insert(name, address, hotline);
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.softDelete(id);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String hotline = request.getParameter("hotline");
                dao.update(id, name, address, hotline);
            } else if ("restore".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.restore(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.setAttribute("listShowroom", dao.getAllActive());
            request.setAttribute("listDeleted", dao.getDeletedAll());
            request.getRequestDispatcher("showroom.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
