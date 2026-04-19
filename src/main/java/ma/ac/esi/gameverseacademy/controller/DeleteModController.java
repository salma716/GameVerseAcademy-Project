package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.AuthUtil;
import java.io.IOException;

@WebServlet("/deleteMod")
public class DeleteModController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ModService modService = new ModService();

    // Affiche la page de confirmation
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        }

        Mod mod = modService.getModById(Integer.parseInt(idParam));
        if (mod == null) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        }

        request.setAttribute("mod", mod);
        request.getRequestDispatcher("/WEB-INF/views/deleteMod.jsp")
               .forward(request, response);
    }

    // Effectue la suppression
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null) {
            modService.deleteMod(Integer.parseInt(idParam));
        }

        response.sendRedirect(request.getContextPath() + "/mods");
    }
}