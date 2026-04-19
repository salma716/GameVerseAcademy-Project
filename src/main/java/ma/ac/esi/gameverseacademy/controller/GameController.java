package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.service.GameService;
import ma.ac.esi.gameverseacademy.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet("/games")
public class GameController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        GameService gameService = new GameService();
        List<Game> games = gameService.getAllGames();

        request.setAttribute("games", games);
        request.getRequestDispatcher("/games.jsp").forward(request, response);
    }
}