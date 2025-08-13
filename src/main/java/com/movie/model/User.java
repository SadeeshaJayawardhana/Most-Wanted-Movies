package com.movie.model;

/**
 * The User class represents a user in the system.
 * It stores the user's username, password, and email address.
 */
public class User {
    private String username;  // The unique identifier for the user
    private String password;  // The password used for authentication
    private String email;     // The user's email address for communication

    // Default constructor
    public User() {}

    // Parameterized constructor to initialize a User object with username, password, and email
    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    // Getter and setter methods for accessing and modifying the fields

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Converts the User object to a comma-separated string format.
     * This is useful for saving the user's data to a file or database.
     * Format: "username,password,email"
     */
    @Override
    public String toString() {
        return username + "," + password + "," + email;
    }
}
