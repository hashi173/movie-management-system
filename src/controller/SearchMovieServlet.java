package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.MovieDAO;
import model.Movie;
import model.MovieGenre;
import model.Showtime;

@WebServlet("/search-movie")
public class SearchMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MovieDAO movieDAO;

    public SearchMovieServlet() {
        super();
    }

    @Override
    public void init() {
        movieDAO = new MovieDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String inMovieName = request.getParameter("inMovieName");
        String movieCode = request.getParameter("movieCode");

        if (inMovieName != null) {
            Movie[] outsubMovieList = movieDAO.searchMovies(inMovieName);
            request.setAttribute("inMovieName", inMovieName);
            request.setAttribute("outsubMovieList", outsubMovieList);
        }

        if (movieCode != null && !movieCode.trim().isEmpty()) {
            MovieGenre[] movieGenre = movieDAO.getMovieDetail(movieCode);
            Showtime[] showtime = movieDAO.getShowtimesByMovie(movieCode);
            request.setAttribute("movieGenre", movieGenre);
            request.setAttribute("showtime", showtime);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/Customer/SearchMovieView.jsp");
        dispatcher.forward(request, response);
    }
}
