<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.time.format.DateTimeFormatter,java.net.URLEncoder,java.util.ArrayList,java.util.List,model.Movie,model.MovieGenre,model.Showtime"%>
<%
    request.setCharacterEncoding("UTF-8");
    String inMovieName = (String) request.getAttribute("inMovieName");
    if (inMovieName == null) {
        inMovieName = request.getParameter("inMovieName");
    }

    // Danh sách phim tìm kiếm (kết quả của MovieDAO.searchMovies)
    Movie[] outsubMovieList = (Movie[]) request.getAttribute("outsubMovieList");
    // Hai thực thể ẩn trên Class Diagram Hình 2.4 (kết quả của getMovieDetail và getShowtimesByMovie)
    MovieGenre[] movieGenre = (MovieGenre[]) request.getAttribute("movieGenre");
    Showtime[] showtime = (Showtime[]) request.getAttribute("showtime");

    // Truy xuất đối tượng Movie và danh sách thể loại Genre từ thực thể ẩn movieGenre[]
    Movie selectedMovie = null;
    String genreText = "";
    if (movieGenre != null && movieGenre.length > 0) {
        selectedMovie = movieGenre[0].getMovie();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < movieGenre.length; i++) {
            if (movieGenre[i] != null && movieGenre[i].getGenre() != null) {
                if (sb.length() > 0) {
                    sb.append(", ");
                }
                sb.append(movieGenre[i].getGenre().getGenreName());
            }
        }
        genreText = sb.toString();
    }

    // Truy xuất định dạng phòng chiếu (format) từ thực thể ẩn showtime[] -> Room
    String formatText = "";
    if (showtime != null && showtime.length > 0) {
        List<String> formats = new ArrayList<String>();
        for (int i = 0; i < showtime.length; i++) {
            if (showtime[i] != null && showtime[i].getRoom() != null) {
                String fmt = showtime[i].getRoom().getFormat();
                if (fmt != null && !formats.contains(fmt)) {
                    formats.add(fmt);
                }
            }
        }
        formatText = String.join(", ", formats);
    }

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm phim</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <div class="window-card" style="max-width: 1120px; min-height: 620px;">
        <div class="window-header">Tìm kiếm phim</div>
        <div class="window-body">
            <form action="<%=request.getContextPath()%>/search-movie" method="get" style="display: flex; align-items: center; gap: 14px; margin-bottom: 24px;">
                <label for="inMovieName" style="font-weight: bold; width: 65px; line-height: 1.2;">Tên<br>phim:</label>
                <input type="text"
                       id="inMovieName"
                       name="inMovieName"
                       tabindex="1"
                       autofocus
                       class="form-input"
                       style="width: 280px;"
                       placeholder="Nhập tên phim cần tìm..."
                       value="<%= (inMovieName != null) ? inMovieName : "" %>" />
                <button type="submit" id="subSearch" name="subSearch" tabindex="2" class="btn-primary" style="padding: 10px 24px;">
                    Tìm kiếm
                </button>
                <a id="subBack"
                   tabindex="3"
                   href="<%=request.getContextPath()%>/view/Customer/CustomerHomeView.jsp"
                   class="btn-primary"
                   style="padding: 10px 48px;">
                    Trở về
                </a>
            </form>

            <div style="display: flex; gap: 28px; align-items: flex-start;">
                <div style="flex: 1.05;">
                    <% if (inMovieName != null) { %>
                        <h3 style="margin-top: 0; margin-bottom: 10px; font-size: 16px;">Danh sách phim tìm được</h3>

                        <% if (outsubMovieList != null && outsubMovieList.length > 0) { %>
                            <div class="table-scroll-container">
                                <table id="outsubMovieList" class="data-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 50px;">STT</th>
                                            <th>Tên</th>
                                            <th>Đạo diễn</th>
                                            <th style="width: 90px;">Mã phim</th>
                                            <th style="width: 110px;">Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            String encodedKeyword = URLEncoder.encode(inMovieName, "UTF-8");
                                            for (int i = 0; i < outsubMovieList.length; i++) {
                                                Movie m = outsubMovieList[i];
                                                String detailUrl = request.getContextPath() + "/search-movie?inMovieName="
                                                                 + encodedKeyword + "&movieCode=" + URLEncoder.encode(m.getMovieCode(), "UTF-8");
                                                boolean isSelected = (selectedMovie != null && m.getMovieCode().equals(selectedMovie.getMovieCode()));
                                        %>
                                        <tr class="clickable-row <%= isSelected ? "selected-row" : "" %>" onclick="window.location.href='<%=detailUrl%>'">
                                            <td><a href="<%=detailUrl%>"><%= (i + 1) %></a></td>
                                            <td style="text-align: left;"><a href="<%=detailUrl%>"><%= m.getTitle() %></a></td>
                                            <td style="text-align: left;"><a href="<%=detailUrl%>"><%= m.getDirector() != null ? m.getDirector() : "" %></a></td>
                                            <td><a href="<%=detailUrl%>"><%= m.getMovieCode() %></a></td>
                                            <td><a href="<%=detailUrl%>"><%= m.getStatus() != null ? m.getStatus() : "" %></a></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <p id="txtTotalMovies" style="font-weight: bold; margin: 14px 0;">
                                Tổng các bộ phim theo tìm kiếm: <%= outsubMovieList.length %>
                            </p>
                        <% } else { %>
                            <div style="padding: 16px; border: 1px solid #d9534f; background-color: #fdf2f2; color: #a94442; margin-bottom: 12px;">
                                Không có bộ phim nào trùng với từ khóa. Vui lòng nhập lại tên phim.
                            </div>
                            <p id="txtTotalMovies" style="font-weight: bold; margin: 14px 0;">
                                Tổng các bộ phim theo tìm kiếm: 0
                            </p>
                        <% } %>
                    <% } %>
                </div>

                <div style="flex: 1.15;">
                    <% if (selectedMovie != null) { %>
                        <div style="border: 1px solid #aebbc7; background-color: #fafbfc; padding: 18px 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.08);">
                            <h3 style="margin-top: 0; margin-bottom: 16px; font-size: 16px;">
                                Thông tin chi tiết phim
                            </h3>

                            <div style="display: flex; gap: 18px; margin-bottom: 16px;">
                                <div id="imgPoster" style="width: 125px; height: 175px; border: 1px solid #8e9ba8; background-color: #e4eaf0; display: flex; align-items: center; justify-content: center; text-align: center; color: #555; font-size: 14px; flex-shrink: 0;">
                                    Ảnh<br>poster
                                </div>

                                <table style="border-collapse: collapse; font-size: 14px; width: 100%;">
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top; width: 110px;">Tên phim:</td>
                                        <td id="txtName" style="padding: 4px 0;"><%= selectedMovie.getTitle() %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Đạo diễn:</td>
                                        <td id="txtDirector" style="padding: 4px 0;"><%= selectedMovie.getDirector() != null ? selectedMovie.getDirector() : "" %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Diễn viên:</td>
                                        <td id="txtStars" style="padding: 4px 0;"><%= selectedMovie.getActor() != null ? selectedMovie.getActor() : "" %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Thể loại:</td>
                                        <td id="txtGenre" style="padding: 4px 0;"><%= genreText %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Ngày chiếu:</td>
                                        <td id="txtDate" style="padding: 4px 0;"><%= selectedMovie.getReleaseDate() != null ? selectedMovie.getReleaseDate().format(dtf) : "" %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Thời lượng:</td>
                                        <td id="txtDuration" style="padding: 4px 0;"><%= selectedMovie.getDuration() %> phút</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Ngôn ngữ:</td>
                                        <td id="txtLanguage" style="padding: 4px 0;"><%= selectedMovie.getLanguage() != null ? selectedMovie.getLanguage() : "" %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Giới hạn tuổi:</td>
                                        <td id="txtAge" style="padding: 4px 0;"><%= selectedMovie.getAgeLimit() != null ? selectedMovie.getAgeLimit() : "" %></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; padding: 4px 8px 4px 0; vertical-align: top;">Định dạng:</td>
                                        <td id="txtFormat" style="padding: 4px 0;"><%= formatText %></td>
                                    </tr>
                                </table>
                            </div>

                            <p id="txtDescription" style="font-size: 14px; line-height: 1.5; margin-bottom: 20px;">
                                <strong>Mô tả:</strong> <%= selectedMovie.getDescription() != null ? selectedMovie.getDescription() : "" %>
                            </p>

                            <div style="text-align: right;">
                                <a id="subBuyTicket"
                                   href="javascript:void(0);"
                                   onclick="alert('Chức năng Mua vé trực tuyến cho bộ phim <%= selectedMovie.getTitle() %>');"
                                   class="btn-primary"
                                   style="padding: 10px 36px;">
                                    Mua vé
                                </a>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
