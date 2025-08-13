package com.movie.model;

/**
 * The Rental class represents a movie that has been rented by a user.
 * It includes the username of the renter, the movie title, and the rental date.
 */
public class Rental {
    // The username of the user who rented the movie
    private String username;

    // The title of the rented movie
    private String title;

    // The date when the movie was rented
    private String rentalDate;

    /**
     * Constructor to initialize a Rental object with user, title, and rental date.
     */
    public Rental(String username, String title, String rentalDate) {
        this.username = username;
        this.title = title;
        this.rentalDate = rentalDate;
    }

    // Getter for username
    public String getUsername() {
        return username;
    }

    // Getter for movie title
    public String getTitle() {
        return title;
    }

    // Getter for rental date
    public String getRentalDate() {
        return rentalDate;
    }

    // Setter for username
    public void setUsername(String username) {
        this.username = username;
    }

    // Setter for movie title
    public void setTitle(String title) {
        this.title = title;
    }

    // Setter for rental date
    public void setRentalDate(String rentalDate) {
        this.rentalDate = rentalDate;
    }

    /**
     * Returns a comma-separated string representation of the Rental object.
     * Useful for storing in text files or logs.
     * Format: username,title,rentalDate
     */
    @Override
    public String toString() {
        return username + "," + title + "," + rentalDate;
    }
}
