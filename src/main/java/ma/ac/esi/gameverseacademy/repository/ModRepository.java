package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ModRepository {

    // ── Requête SELECT avec toutes les colonnes ──────────────────
    private static final String SELECT_ALL =
        "SELECT id, title, category, author, description, " +
        "       downloads, created_at, developer, publisher, " +
        "       platform, release_date, metacritic            " +
        "FROM mods                                             " +
        "ORDER BY id ASC";

    public List<Mod> getAllMods() {

        List<Mod> mods = new ArrayList<>();

        // try-with-resources : ferme automatiquement conn, stmt, rs
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs           = stmt.executeQuery()) {

            while (rs.next()) {

                // Lire chaque colonne par son nom exact (= nom SQL)
                int    id          = rs.getInt("id");
                String title       = rs.getString("title");
                String category    = rs.getString("category");
                String author      = rs.getString("author");
                String description = rs.getString("description");
                int    downloads   = rs.getInt("downloads");
                // created_at → java.sql.Timestamp
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                String developer   = rs.getString("developer");
                String publisher   = rs.getString("publisher");
                String platform    = rs.getString("platform");
                // release_date stockée en DATE SQL → on la lit comme String
                String releaseDate = rs.getString("release_date");
                int    metacritic  = rs.getInt("metacritic");

                // Créer l'objet Mod et l'ajouter à la liste
                mods.add(new Mod(
                    id, title, category, author, description,
                    downloads, createdAt, developer, publisher,
                    platform, releaseDate, metacritic
                ));
            }

        } catch (SQLException e) {
            System.err.println("Erreur SQL dans getAllMods() : " + e.getMessage());
            e.printStackTrace();
        }

        return mods;
    }
    public Mod getModById(int id) {

        final String sql =
            "SELECT id, title, category, author, description, " +
            "       downloads, created_at, developer, publisher, " +
            "       platform, release_date, metacritic            " +
            "FROM mods WHERE id = ?";

        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);   // remplace le ? par l'id

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Mod(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("author"),
                        rs.getString("description"),
                        rs.getInt("downloads"),
                        rs.getTimestamp("created_at"),
                        rs.getString("developer"),
                        rs.getString("publisher"),
                        rs.getString("platform"),
                        rs.getString("release_date"),
                        rs.getInt("metacritic")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur SQL dans getModById() : " + e.getMessage());
            e.printStackTrace();
        }
        return null; // mod introuvable
        }
        public boolean insertMod(Mod mod) {
            String sql = "INSERT INTO mods (title, category, author, description) "
                       + "VALUES (?, ?, ?, ?)";
         
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
         
                stmt.setString(1, mod.getTitle());
                stmt.setString(2, mod.getCategory());
                stmt.setString(3, mod.getAuthor());
                stmt.setString(4, mod.getDescription());
         
                int rowsAffected = stmt.executeUpdate();

                return rowsAffected > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
    }
        public boolean updateMod(Mod mod) {
            String sql = "UPDATE mods SET title=?, category=?, author=?, description=? WHERE id=?";

            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, mod.getTitle());
                stmt.setString(2, mod.getCategory());
                stmt.setString(3, mod.getAuthor());
                stmt.setString(4, mod.getDescription());
                stmt.setInt(5, mod.getId());

                return stmt.executeUpdate() > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
        public boolean deleteMod(int id) {
            String sql = "DELETE FROM mods WHERE id = ?";

            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, id);
                return stmt.executeUpdate() > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
}

