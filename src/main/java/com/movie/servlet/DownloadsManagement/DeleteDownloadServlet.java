package com.movie.servlet.DownloadsManagement;

import com.movie.utils.FileHandler;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * Servlet to handle deletion of a downloaded movie for a user.
 */
@WebServlet("/DeleteDownloadServlet")
public class DeleteDownloadServlet extends HttpServlet {

    private static final String DOWNLOAD_FILE_PATH = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\downloads.txt"; // Update this path as needed

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String username = (String) request.getSession().getAttribute("username");

        if (username != null && title != null) {
            FileHandler.deleteDownload(username, title, DOWNLOAD_FILE_PATH);
        }

        response.sendRedirect("view_downloads.jsp");
    }
}