package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.GameService;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/mods")
public class ModController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    if (!AuthUtil.verifyAuth(request)) {
	        response.sendRedirect(request.getContextPath() + "/index.html");
	        return;
	    }
	    ModService modService = new ModService();
	    GameService gameService = new GameService();

	    List<Mod> mods = modService.getAllMods();
	    List<Game> games = gameService.getAllGames();
	    java.util.Map<Integer, String> gameNames = new java.util.HashMap<>();
	    for (Game g : games) {
	        gameNames.put(g.getId(), g.getTitle());
	    }

	    request.setAttribute("mods", mods);
	    request.setAttribute("games", games);
	    request.setAttribute("gameNames", gameNames);
	    request.getRequestDispatcher("/mods.jsp").forward(request, response);
	}
}
