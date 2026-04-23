package ma.ac.esi.gameverseacademy.controller;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.GameService;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.AuthUtil;

import java.io.IOException;
import java.util.List;
 
@WebServlet("/submitMod")
public class ModSubmitController extends HttpServlet {
 
    private ModService modService = new ModService();
 
    // Affiche le formulaire de soumission
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// 1. Vérifier que l'utilisateur est connecté
    	if (!AuthUtil.verifyAuth(request)) {
    		response.sendRedirect(request.getContextPath() + "/index.html");
    		return;
    	}
    	GameService gameService = new GameService();
    	request.setAttribute("games", gameService.getAllGames());
    	request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
        .forward(request, response);
    }
 
    // Traite la soumission du formulaire
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
    	
        // 2. Récupérer les paramètres du formulaire
        String title       = request.getParameter("title");
        String category    = request.getParameter("category");
        String author      = request.getParameter("author");
        String description = request.getParameter("description");
        String gameIdParam = request.getParameter("game_id");
        

 
        // 3. Construire l'objet Mod
        Mod mod = new Mod();
        mod.setTitle(title);
        mod.setCategory(category);
        mod.setAuthor(author);
        mod.setDescription(description);
        int gameId = (gameIdParam != null && !gameIdParam.isEmpty()) ? Integer.parseInt(gameIdParam) : 0;
        mod.setGameId(gameId);
 
        // 4. Appeler le service pour insérer le mod
        boolean success = modService.submitMod(mod);
 
        // 5. Transmettre le résultat à la JSP
        if (success) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        } else {
            request.setAttribute("error",
                "Erreur lors de la soumission. Vérifiez les champs.");
        }
        request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
               .forward(request, response);
    }
}