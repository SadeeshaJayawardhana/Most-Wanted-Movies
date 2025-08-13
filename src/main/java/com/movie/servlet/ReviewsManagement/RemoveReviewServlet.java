package com.movie.servlet.ReviewsManagement;

import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle the removal of a movie review.
 * Mapped to: /RemoveReviewServlet
 */
@WebServlet("/RemoveReviewServlet")
public class RemoveReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from the request
        String username = request.getParameter("username");
        String movieTitle = request.getParameter("title");
        String comment = request.getParameter("comment");

        // Delete the specified review from the data store
        FileHandler.deleteReview(username, movieTitle, comment);

        // Redirect to confirmation page with success message
        response.sendRedirect("remove_review.jsp?success=true");
    }
}
