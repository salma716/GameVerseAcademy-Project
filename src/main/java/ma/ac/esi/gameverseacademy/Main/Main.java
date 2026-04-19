package ma.ac.esi.gameverseacademy.Main;

import org.apache.catalina.startup.Tomcat;
import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);

        String webappDir = new File("src/main/webapp").getAbsolutePath();
        tomcat.addWebapp("/GameVerseAcademy", webappDir);

        tomcat.start();

        System.out.println("Serveur démarré : http://localhost:8080/GameVerseAcademy");

        tomcat.getServer().await();
    }
}