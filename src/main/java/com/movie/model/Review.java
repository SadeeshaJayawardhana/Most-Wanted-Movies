package com.movie.model;

/**
 * The Review class represents a review left by a user for a movie.
 * It includes the username of the reviewer, the movie title, and the comment they left.
 */
public class Review {
    private String username;    // Username of the person who wrote the review
    private String movieTitle;  // Title of the movie being reviewed
    private String comment;     // The review comment left by the user

    // Default constructor
    public Review() {}

    // Constructor to initialize a Review object with the username, movie title, and comment
    public Review(String username, String movieTitle, String comment) {
        this.username = username;
        this.movieTitle = movieTitle;
        this.comment = comment;
    }

    // Getter and setter methods for the fields

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getTitle() {
        return movieTitle;
    }

    /**
     * Returns a CSV format string for storing a Review.
     * The format is: "username,movieTitle,comment"
     * This method is useful for saving reviews in a file or database.
     */
    @Override
    public String toString() {
        return username + "," + movieTitle + "," + comment;
    }
}
