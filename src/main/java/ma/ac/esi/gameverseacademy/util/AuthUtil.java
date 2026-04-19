package ma.ac.esi.gameverseacademy.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthUtil {

    public static boolean verifyAuth(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
          
            return false;
        }
        return true;
    }
}


