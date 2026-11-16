package model;

import java.io.Serializable;
import java.time.LocalDate;

public class Movie implements Serializable {
    private static final long serialVersionUID = 1L;

    private String movieCode;
    private String title;
    private int duration;
    private String ageLimit;
    private String director;
    private String actor;
    private String language;
    private String description;
    private String status;
    private String poster;
    private LocalDate releaseDate;

    public Movie() {
        super();
    }

    public Movie(String movieCode, String title, int duration, String ageLimit,
                 String director, String actor, String language, String description,
                 String status, String poster, LocalDate releaseDate) {
        super();
        this.movieCode = movieCode;
        this.title = title;
        this.duration = duration;
        this.ageLimit = ageLimit;
        this.director = director;
        this.actor = actor;
        this.language = language;
        this.description = description;
        this.status = status;
        this.poster = poster;
        this.releaseDate = releaseDate;
    }

    public String getMovieCode() {
        return movieCode;
    }

    public void setMovieCode(String movieCode) {
        this.movieCode = movieCode;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getAgeLimit() {
        return ageLimit;
    }

    public void setAgeLimit(String ageLimit) {
        this.ageLimit = ageLimit;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }
}
