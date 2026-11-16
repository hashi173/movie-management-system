package model;

import java.io.Serializable;

public class Genre implements Serializable {
    private static final long serialVersionUID = 1L;

    private String genreCode;
    private String genreName;

    public Genre() {
        super();
    }

    public Genre(String genreCode, String genreName) {
        super();
        this.genreCode = genreCode;
        this.genreName = genreName;
    }

    public String getGenreCode() {
        return genreCode;
    }

    public void setGenreCode(String genreCode) {
        this.genreCode = genreCode;
    }

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }
}
