package ma.ac.esi.gameverseacademy.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/XEPDB1";
    private static final String USER = "projet_user";
    private static final String PASSWORD = "projet123";

    static {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Oracle JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Connexion Oracle OK");
            return conn;
        } catch (SQLException e) {
            System.out.println("❌ Connexion échouée: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}