package com.movie.servlet.DownloadsManagement;

import com.movie.model.Download;
import com.movie.utils.FileHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

/**
 * Servlet to handle downloading a movie for the user.
 */
@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {

    private static final String DOWNLOAD_FILE_PATH = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\downloads.txt"; // Update this path as needed

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String username = (String) request.getSession().getAttribute("username");

        if (username != null && title != null) {
            String downloadDate = LocalDate.now().toString();
            Download download = new Download(username, title, downloadDate);

            // Load current downloads, add new one, and save
            var downloads = FileHandler.loadDownloads(DOWNLOAD_FILE_PATH);
            downloads.add(download);
            FileHandler.saveDownloads(downloads, DOWNLOAD_FILE_PATH);

            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}