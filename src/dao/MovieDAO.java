package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import model.Genre;
import model.Movie;
import model.MovieGenre;
import model.Room;
import model.Showtime;

public class MovieDAO extends DAO {

    public MovieDAO() {
        super();
    }

    /**
     * [Bước 7 - 11 trên Sequence Hình 2.8]
     * Tìm kiếm danh sách các bộ phim có tên chứa từ khóa keyword
     */
    public Movie[] searchMovies(String keyword) {
        List<Movie> list = new ArrayList<>();
        // Câu truy vấn SQL tìm phim theo tên (title) và sắp xếp theo ngày khởi chiếu
        String sql = "SELECT movieCode, title, duration, ageLimit, director, actor, "
                   + "language, description, status, poster, releaseDate "
                   + "FROM tblMovie WHERE title LIKE ? ORDER BY releaseDate DESC";
        try {
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(sql);
                String searchPattern = "%" + (keyword != null ? keyword.trim() : "") + "%";
                ps.setString(1, searchPattern);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    // Bước 8 - 10: Khởi tạo và đóng gói thông tin thực thể Movie
                    Movie movie = new Movie();
                    movie.setMovieCode(rs.getString("movieCode"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setAgeLimit(rs.getString("ageLimit"));
                    movie.setDirector(rs.getString("director"));
                    movie.setActor(rs.getString("actor"));
                    movie.setLanguage(rs.getString("language"));
                    movie.setDescription(rs.getString("description"));
                    movie.setStatus(rs.getString("status"));
                    movie.setPoster(rs.getString("poster"));
                    Date releaseDate = rs.getDate("releaseDate");
                    if (releaseDate != null) {
                        movie.setReleaseDate(releaseDate.toLocalDate());
                    }
                    list.add(movie);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Bước 11: Trả về mảng Movie[] cho SearchMovieServlet
        return list.toArray(new Movie[0]);
    }

    /**
     * [Bước 17 - 27 trên Sequence Hình 2.8]
     * Lấy thông tin chi tiết của bộ phim và danh sách thể loại (MovieGenre[]) theo mã phim
     * Thứ tự đóng gói: Movie (18-20) -> Genre (21-23) -> MovieGenre (24-26)
     */
    public MovieGenre[] getMovieDetail(String movieCode) {
        List<MovieGenre> list = new ArrayList<>();
        String sqlMovie = "SELECT movieCode, title, duration, ageLimit, director, actor, "
                        + "language, description, status, poster, releaseDate "
                        + "FROM tblMovie WHERE movieCode = ?";
        String sqlGenre = "SELECT mg.id, g.genreCode, g.genreName "
                        + "FROM tblMovieGenre mg "
                        + "INNER JOIN tblGenre g ON mg.tblGenregenreCode = g.genreCode "
                        + "WHERE mg.tblMoviemovieCode = ? ORDER BY mg.id ASC";
        try {
            if (con != null && movieCode != null) {
                PreparedStatement ps = con.prepareStatement(sqlMovie);
                ps.setString(1, movieCode.trim());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    // Bước 18 - 20: Đóng gói thực thể Movie
                    Movie movie = new Movie();
                    movie.setMovieCode(rs.getString("movieCode"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setAgeLimit(rs.getString("ageLimit"));
                    movie.setDirector(rs.getString("director"));
                    movie.setActor(rs.getString("actor"));
                    movie.setLanguage(rs.getString("language"));
                    movie.setDescription(rs.getString("description"));
                    movie.setStatus(rs.getString("status"));
                    movie.setPoster(rs.getString("poster"));
                    Date releaseDate = rs.getDate("releaseDate");
                    if (releaseDate != null) {
                        movie.setReleaseDate(releaseDate.toLocalDate());
                    }

                    PreparedStatement psGenre = con.prepareStatement(sqlGenre);
                    psGenre.setString(1, movie.getMovieCode());
                    ResultSet rsGenre = psGenre.executeQuery();
                    while (rsGenre.next()) {
                        // Bước 21 - 23: Đóng gói thực thể Genre
                        Genre genre = new Genre(rsGenre.getString("genreCode"), rsGenre.getString("genreName"));
                        // Bước 24 - 26: Đóng gói thực thể MovieGenre (chứa movie và genre)
                        MovieGenre mg = new MovieGenre(rsGenre.getInt("id"), movie, genre);
                        list.add(mg);
                    }

                    if (list.isEmpty()) {
                        list.add(new MovieGenre(0, movie, null));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Bước 27: Trả về mảng MovieGenre[] cho SearchMovieServlet
        return list.toArray(new MovieGenre[0]);
    }

    /**
     * [Bước 28 - 35 trên Sequence Hình 2.8]
     * Lấy danh sách các suất chiếu kèm thông tin phòng chiếu (format) của bộ phim
     * Thứ tự đóng gói: Room (29-31) -> Showtime (32-34)
     */
    public Showtime[] getShowtimesByMovie(String movieCode) {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT st.showtimeCode, st.startTime, st.endTime, st.status, "
                   + "r.roomCode, r.roomName, r.format, r.capacity, r.status AS roomStatus "
                   + "FROM tblShowtime st "
                   + "INNER JOIN tblRoom r ON st.tblRoomroomCode = r.roomCode "
                   + "WHERE st.tblMoviemovieCode = ?";
        try {
            if (con != null && movieCode != null) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, movieCode.trim());
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    // Bước 29 - 31: Đóng gói thực thể Room (chứa định dạng phòng chiếu format)
                    Room room = new Room();
                    room.setRoomCode(rs.getString("roomCode"));
                    room.setRoomName(rs.getString("roomName"));
                    room.setFormat(rs.getString("format"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setStatus(rs.getString("roomStatus"));

                    // Bước 32 - 34: Đóng gói thực thể Showtime (gắn đối tượng Room)
                    Showtime showtime = new Showtime();
                    showtime.setShowtimeCode(rs.getString("showtimeCode"));
                    Time start = rs.getTime("startTime");
                    if (start != null) {
                        showtime.setStartTime(start.toLocalTime());
                    }
                    Time end = rs.getTime("endTime");
                    if (end != null) {
                        showtime.setEndTime(end.toLocalTime());
                    }
                    showtime.setStatus(rs.getString("status"));
                    showtime.setRoom(room);

                    list.add(showtime);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Bước 35: Trả về mảng Showtime[] cho SearchMovieServlet
        return list.toArray(new Showtime[0]);
    }
}
