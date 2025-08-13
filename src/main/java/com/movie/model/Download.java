package com.movie.model;

/**
 * The Download class represents a movie downloaded by a user.
 * It contains information about the user who downloaded the movie,
 * the title of the movie, and the date it was downloaded.
 */
public class Download {
    // The username of the user who downloaded the movie
    private String username;

    // The title of the downloaded movie
    private String title;

    // The date when the movie was downloaded
    private String downloadDate;

    /**
     * Constructor to initialize a Download object with username, title, and download date.
     */
    public Download(String username, String title, String downloadDate) {
        this.username = username;
        this.title = title;
        this.downloadDate = downloadDate;
    }

    // Getter for username
    public String getUsername() {
        return username;
    }

    // Getter for movie title
    public String getTitle() {
        return title;
    }

    // Getter for download date
    public String getDownloadDate() {
        return downloadDate;
    }

    // Setter for username
    public void setUsername(String username) {
        this.username = username;
    }

    // Setter for movie title
    public void setTitle(String title) {
        this.title = title;
    }

    // Setter for download date
    public void setDownloadDate(String downloadDate) {
        this.downloadDate = downloadDate;
    }

    /**
     * Returns a string representation of the Download object.
     * This is typically used when saving the object to a file.
     * Format: username,title,downloadDate
     */
    @Override
    public String toString() {
        return username + "," + title + "," + downloadDate;
    }
}
