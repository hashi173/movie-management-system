package model;

import java.io.Serializable;

public class MovieGenre implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Movie movie;
    private Genre genre;

    public MovieGenre() {
        super();
    }

    public MovieGenre(int id, Movie movie, Genre genre) {
        super();
        this.id = id;
        this.movie = movie;
        this.genre = genre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }
}
