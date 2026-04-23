package ma.ac.esi.gameverseacademy.Main;

import ma.ac.esi.gameverseacademy.controller.*;
import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

import java.net.URI;
import java.nio.file.*;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) throws Exception {

        Path tempWebapp = Files.createTempDirectory("webapp");
        copyResourceDirectory("webapp", tempWebapp);

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.getConnector();

        Context ctx = tomcat.addWebapp("/GameVerseAcademy", tempWebapp.toAbsolutePath().toString());

        // Enregistrement de tous les servlets
        Tomcat.addServlet(ctx, "LoginController",       new LoginController());
        Tomcat.addServlet(ctx, "LogoutController",      new LogoutController());
        Tomcat.addServlet(ctx, "GameController",        new GameController());
        Tomcat.addServlet(ctx, "GameSubmitController",  new GameSubmitController());
        Tomcat.addServlet(ctx, "GameUpdateController",  new GameUpdateController());
        Tomcat.addServlet(ctx, "GameDeleteController",  new GameDeleteController());
        Tomcat.addServlet(ctx, "ModController",         new ModController());
        Tomcat.addServlet(ctx, "ModSubmitController",   new ModSubmitController());
        Tomcat.addServlet(ctx, "ModUpdateController",   new ModUpdateController());
        Tomcat.addServlet(ctx, "DeleteModController",   new DeleteModController());

        // Mappings
        ctx.addServletMappingDecoded("/LoginController",      "LoginController");
        ctx.addServletMappingDecoded("/logout",     "LogoutController");
        ctx.addServletMappingDecoded("/games",       "GameController");
        ctx.addServletMappingDecoded("/submitGame", "GameSubmitController");
        ctx.addServletMappingDecoded("/updateGame", "GameUpdateController");
        ctx.addServletMappingDecoded("/deleteGame", "GameDeleteController");
        ctx.addServletMappingDecoded("/mods",                 "ModController");      
        ctx.addServletMappingDecoded("/submitMod",  "ModSubmitController");
        ctx.addServletMappingDecoded("/updateMod",  "ModUpdateController");
        ctx.addServletMappingDecoded("/deleteMod",  "DeleteModController");

        tomcat.start();
        System.out.println("Serveur démarré : http://localhost:8080/GameVerseAcademy");
        tomcat.getServer().await();
    }

    private static void copyResourceDirectory(String resourceDir, Path target) throws Exception {
        URI uri = Main.class.getClassLoader().getResource(resourceDir).toURI();

        if (uri.getScheme().equals("jar")) {
            try (FileSystem fs = FileSystems.newFileSystem(uri, java.util.Collections.emptyMap())) {
                Path jarPath = fs.getPath("/" + resourceDir);
                copyAll(jarPath, target);
            }
        } else {
            copyAll(Path.of(uri), target);
        }
    }

    private static void copyAll(Path source, Path target) throws Exception {
        try (Stream<Path> walk = Files.walk(source)) {
            for (Path src : (Iterable<Path>) walk::iterator) {
                Path dest = target.resolve(source.relativize(src).toString());
                if (Files.isDirectory(src)) {
                    Files.createDirectories(dest);
                } else {
                    Files.copy(src, dest, StandardCopyOption.REPLACE_EXISTING);
                }
            }
        }
    }
}