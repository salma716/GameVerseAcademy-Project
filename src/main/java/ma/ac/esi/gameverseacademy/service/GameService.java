package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.repository.GameRepository;

import java.util.List;

public class GameService {

    private final GameRepository gameRepository = new GameRepository();

    public List<Game> getAllGames() {
        return gameRepository.getAllGames();
    }

    public Game getGameById(int id) {
        return gameRepository.getGameById(id);
    }

    public boolean addGame(Game game) {
        return gameRepository.insertGame(game);
    }

    public boolean updateGame(Game game) {
        return gameRepository.updateGame(game);
    }

    public boolean deleteGame(int id) {
        return gameRepository.deleteGame(id);
    }
}