package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Game;
import ma.ac.esi.gameverseacademy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GameRepository {

    private static final String SELECT_ALL =
        "SELECT id, title, genre, platform, developer, publisher, " +
        "       release_date, description, created_at " +
        "FROM games ORDER BY id ASC";

    public List<Game> getAllGames() {
        List<Game> games = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                games.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur getAllGames: " + e.getMessage());
            e.printStackTrace();
        }
        return games;
    }

    public Game getGameById(int id) {
        String sql = "SELECT id, title, genre, platform, developer, publisher, " +
                     "release_date, description, created_at FROM games WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertGame(Game game) {
        String sql = "INSERT INTO games (title, genre, platform, developer, publisher, release_date, description) " +
                     "VALUES (?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getGenre());
            stmt.setString(3, game.getPlatform());
            stmt.setString(4, game.getDeveloper());
            stmt.setString(5, game.getPublisher());
            stmt.setString(6, game.getReleaseDate());
            stmt.setString(7, game.getDescription());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateGame(Game game) {
        String sql = "UPDATE games SET title=?, genre=?, platform=?, developer=?, " +
                     "publisher=?, release_date=TO_DATE(?,'YYYY-MM-DD'), description=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getGenre());
            stmt.setString(3, game.getPlatform());
            stmt.setString(4, game.getDeveloper());
            stmt.setString(5, game.getPublisher());
            stmt.setString(6, game.getReleaseDate());
            stmt.setString(7, game.getDescription());
            stmt.setInt(8, game.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteGame(int id) {
        String sql = "DELETE FROM games WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Game mapRow(ResultSet rs) throws SQLException {
        return new Game(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("genre"),
            rs.getString("platform"),
            rs.getString("developer"),
            rs.getString("publisher"),
            rs.getString("release_date"),
            rs.getString("description"),
            rs.getTimestamp("created_at")
        );
    }
}