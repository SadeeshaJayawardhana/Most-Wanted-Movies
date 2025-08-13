package com.movie.model;

/**
 * The Movie class represents a movie with attributes such as title, genre, rating, poster URL, description, and watch URL.
 * It provides constructors for different initialization scenarios, getters and setters, and a custom toString method for file storage.
 */
public class Movie {
    private String title;         // The title of the movie
    private String genre;         // The genre of the movie (e.g., Action, Comedy, Drama)
    private double rating;        // The rating of the movie (e.g., IMDb rating)
    private String posterUrl;     // URL to the poster image of the movie
    private String description;   // A short description of the movie
    private String watchUrl;      // URL to watch the movie online (if available)

    // 3-argument constructor: Used for creating a movie with title, genre, and rating
    // Default values are used for poster URL, description, and watch URL
    public Movie(String title, String genre, double rating) {
        this.title = title;
        this.genre = genre;
        this.rating = rating;
        this.posterUrl = "default-poster.jpg"; // Default poster if not provided
        this.description = "";               // Default empty description
        this.watchUrl = "default-watch.jpg";  // Default watch URL if not provided
    }

    // 4-argument constructor: Used for creating a movie with title, genre, rating, and poster URL
    // The poster URL is assigned a default value if it's null
    public Movie(String title, String genre, double rating, String posterUrl) {
        this.title = title;
        this.genre = genre;
        this.rating = rating;
        this.posterUrl = posterUrl != null ? posterUrl : "default-poster.jpg"; // Default to "default-poster.jpg" if null
        this.description = "";               // Default empty description
        this.watchUrl = "default-watch.jpg";  // Default watch URL if not provided
    }

    // Full constructor: Used for creating a movie with all attributes including title, genre, rating, poster URL, description, and watch URL
    // It ensures that invalid or empty poster URLs are replaced by default values
    public Movie(String title, String genre, double rating, String posterUrl, String description, String watchUrl) {
        this.title = title;
        this.genre = genre;
        this.rating = rating;
        this.posterUrl = (posterUrl == null || posterUrl.trim().isEmpty()) ? "default-poster.jpg" : posterUrl; // Default poster if null or empty
        this.description = description != null ? description : "";  // Default empty description if null
        this.watchUrl = watchUrl; // Watch URL is allowed to be null if no URL is provided
    }

    public Movie() {
    }

    // Getters and Setters for each field
    public String getTitle() {
        return title;
    }

    public String getGenre() {
        return genre;
    }

    public double getRating() {
        return rating;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public String getWatchUrl() {
        return watchUrl;
    }

    public void setWatchUrl(String watchUrl) {
        this.watchUrl = watchUrl;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Override toString method to provide a custom string representation of the movie.
    // This format is useful for saving movie data to a file (comma-separated values).
    @Override
    public String toString() {
        // Return a formatted string with movie details
        return title + "," +
                genre + "," +
                rating + "," +
                posterUrl + "," +
                (description != null ? description.replace(",", " ") : "") + "," + // Replace commas in description to prevent format issues
                (watchUrl != null ? watchUrl : "default-watch.jpg"); // Default watch URL if null
    }
}
