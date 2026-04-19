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

@WebServlet("/deleteGame")
public class GameDeleteController extends HttpServlet {

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
        request.getRequestDispatcher("/WEB-INF/views/deleteGame.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.verifyAuth(request)) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        gameService.deleteGame(id);
        response.sendRedirect(request.getContextPath() + "/games");
    }
}