package com.movie.servlet.RentalManagement;

import com.movie.utils.FileHandler;
import com.movie.utils.RentalManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/refundMovie")
public class RefundMovieServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the movie title from the request
        String title = request.getParameter("title");

        // 2. Get the current session and username from it
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // 3. If valid username and title are present, proceed to refund (unrent)
        if (username != null && title != null) {
            // Process the refund (remove from rentals)
            RentalManager.unrentMovie(username, title, session);

            //Remove from downloads if it exists
            FileHandler.deleteDownload(username, title, FileHandler.getDownloadFilePath());
        }

        // 4. Redirect user to the rented movies page
        response.sendRedirect("rented_movies.jsp");
    }
}