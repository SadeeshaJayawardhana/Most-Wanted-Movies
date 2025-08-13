package com.movie.servlet.RentalManagement;

import com.movie.model.Rental;
import com.movie.utils.FileHandler;
import com.movie.utils.RentalManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/rent")
public class RentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve the movie title from the request
        String title = request.getParameter("title");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // 2. Call RentalManager to handle rental logic
        if (username != null && title != null) {
            // Create Rental object
            String rentalDate = LocalDate.now().toString();
            Rental rental = new Rental(username, title, rentalDate);

            // Save using FileHandler (or keep using RentalManager if preferred)
            FileHandler.saveRental(rental);

            // Update session
            RentalManager.rentMovie(session, title); // This still updates the session
        }

        // 3. Redirect back to the movies page with success flag
        response.sendRedirect("movies.jsp?rent=success");
    }
}