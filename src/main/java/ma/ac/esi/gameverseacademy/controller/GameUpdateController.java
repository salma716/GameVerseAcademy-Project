package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.service.GameService;
import ma.ac.esi.gameverseacademy.util.AuthUtil;

import java.io.IOException;

@WebServlet("/updateGame")
public class GameUpdateController extends HttpServlet {

    private GameService gameService = new GameService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Game game = gameService.getGameById(id);
        if (game == null) {
            response.sendRedirect(request.getContextPath() + "/games");
            return;
        }
        request.setAttribute("game", game);
        request.getRequestDispatcher("/WEB-INF/views/updateGame.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }
        Game game = new Game();
        game.setId(Integer.parseInt(request.getParameter("id")));
        game.setTitle(request.getParameter("title"));
        game.setGenre(request.getParameter("genre"));
        game.setPlatform(request.getParameter("platform"));
        game.setDeveloper(request.getParameter("developer"));
        game.setPublisher(request.getParameter("publisher"));
        game.setReleaseDate(request.getParameter("release_date"));
        game.setDescription(request.getParameter("description"));

        boolean success = gameService.updateGame(game);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/games");
        } else {
            request.setAttribute("error", "Erreur lors de la mise à jour.");
            request.setAttribute("game", game);
            request.getRequestDispatcher("/WEB-INF/views/updateGame.jsp").forward(request, response);
        }
    }
}