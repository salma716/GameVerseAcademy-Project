package ma.ac.esi.gameverseacademy.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Game {
    private int id;
    private String title;
    private String genre;
    private String platform;
    private String developer;
    private String publisher;
    private String releaseDate;
    private String description;
    private Timestamp createdAt;

    public Game() {}

    public Game(int id, String title, String genre, String platform,
                String developer, String publisher, String releaseDate,
                String description, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.platform = platform;
        this.developer = developer;
        this.publisher = publisher;
        this.releaseDate = releaseDate;
        this.description = description;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }
    public String getPlatform() { return platform; }
    public void setPlatform(String platform) { this.platform = platform; }
    public String getDeveloper() { return developer; }
    public void setDeveloper(String developer) { this.developer = developer; }
    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }
    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}