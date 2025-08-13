package com.movie.servlet.ReviewsManagement;

import com.movie.model.Review;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles review operations (submit, update, delete) for movies.
 * Mapped to: /submitReview
 */
@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set character encoding to handle special characters properly
        request.setCharacterEncoding("UTF-8");

        // Retrieve parameters from the request
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String title = request.getParameter("title");
        String openReview = request.getParameter("openReview");
        String oldComment = request.getParameter("oldComment");
        String comment = request.getParameter("comment");

        // Validate essential parameters
        if (action == null || username == null || title == null) {
            System.out.println("⚠️ Missing required parameters: action, username, or title.");
            response.sendRedirect("movies.jsp");
            return;
        }

        // Perform action based on the 'action' parameter
        switch (action) {

            // Submit a new review
            case "submit":
                if (comment != null && !comment.trim().isEmpty()) {
                    FileHandler.saveReview(new Review(username, title, comment));
                    System.out.println("✅ Review submitted.");
                } else {
                    System.out.println("⚠️ Comment is empty. Submission skipped.");
                }
                break;

            // Update an existing review (delete old + save new)
            case "update":
                if (comment != null && oldComment != null && !comment.trim().isEmpty()) {
                    FileHandler.deleteReview(username, title, oldComment);
                    FileHandler.saveReview(new Review(username, title, comment));
                    System.out.println("✅ Review updated.");
                } else {
                    System.out.println("⚠️ Update failed due to missing comment or oldComment.");
                }
                break;

            // Delete an existing review
            case "delete":
                if (comment != null) {
                    FileHandler.deleteReview(username, title, comment);
                    System.out.println("✅ Review deleted.");
                }
                break;

            // Handle invalid action values
            default:
                System.out.println("⚠️ Unknown action: " + action);
                break;
        }

        // Redirect back to the movies page and reopen the review section if applicable
        response.sendRedirect("movies.jsp?openReview=" + openReview);
    }
}
