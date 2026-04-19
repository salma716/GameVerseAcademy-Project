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

@WebServlet("/updateMod")
public class ModUpdateController extends HttpServlet {

    private ModService modService = new ModService();

    // Affiche le formulaire pré-rempli
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
        request.getRequestDispatcher("/WEB-INF/views/updateMod.jsp")
               .forward(request, response);
    }

    // Traite la soumission du formulaire
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        int    id          = Integer.parseInt(request.getParameter("id"));
        String title       = request.getParameter("title");
        String category    = request.getParameter("category");
        String author      = request.getParameter("author");
        String description = request.getParameter("description");

        Mod mod = new Mod();
        mod.setId(id);
        mod.setTitle(title);
        mod.setCategory(category);
        mod.setAuthor(author);
        mod.setDescription(description);

        boolean success = modService.updateMod(mod);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/mods");
        } else {
            request.setAttribute("error", "Erreur lors de la mise à jour.");
            request.setAttribute("mod", mod);
            request.getRequestDispatcher("/WEB-INF/views/updateMod.jsp")
                   .forward(request, response);
        }
    }
}
