package com.movie.model;

/**
 * The WatchLater class represents a movie that a user has added to their "Watch Later" list.
 * It includes the username of the user and the title of the movie.
 */
public class WatchLater {
    // The username of the user who wants to watch the movie later
    private String username;

    // The title of the movie to be watched later
    private String title;

    /**
     * Constructor to initialize a WatchLater object with username and movie title.
     */
    public WatchLater(String username, String title) {
        this.username = username;
        this.title = title;
    }

    // Getter for username
    public String getUsername() {
        return username;
    }

    // Getter for movie title
    public String getTitle() {
        return title;
    }

    // Setter for username
    public void setUsername(String username) {
        this.username = username;
    }

    // Setter for movie title
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Returns a comma-separated string representation of the WatchLater object.
     * Useful for storing in a text file.
     * Format: username,title
     */
    @Override
    public String toString() {
        return username + "," + title;
    }
}
