package ma.ac.esi.gameverseacademy.repository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import ma.ac.esi.gameverseacademy.util.DBUtil;

public class UserRepository {

    public boolean userExists(String email, String password) throws SQLException {
        System.out.println("🔍 email=" + email + " password=" + password);

        Connection connection = DBUtil.getConnection();
        if (connection == null) {
            System.out.println("❌ Connection NULL");
            return false;
        }

        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet resultset = statement.executeQuery();
            boolean found = resultset.next();
            System.out.println("✅ Trouvé: " + found);
            return found;
        } catch (SQLException e) {
            System.out.println("❌ SQL Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}