<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.time.format.DateTimeFormatter,java.net.URLEncoder,java.util.ArrayList,java.util.List,model.Movie,model.MovieGenre,model.Showtime"%>
<%
    // =========================================================================
    // [PHẦN 1: CẤU HÌNH BỘ MÃ & HỨNG DỮ LIỆU TỪ SERVLET]
    // =========================================================================
    request.setCharacterEncoding("UTF-8");
    
    // 1.1. Từ khóa tìm kiếm do người dùng nhập (Boundary attribute: -inMovieName : text)
    String inMovieName = (String) request.getAttribute("inMovieName");
    if (inMovieName == null) {
        inMovieName = request.getParameter("inMovieName");
    }

    // 1.2. Mảng danh sách phim tìm được (Boundary attribute: -outsubMovieList : Table)
    Movie[] outsubMovieList = (Movie[]) request.getAttribute("outsubMovieList");

    // 1.3. Hai THUỘC TÍNH ẨN trên Sơ đồ lớp Boundary Class (kết quả getMovieDetail & getShowtimesByMovie)
    MovieGenre[] movieGenre = (MovieGenre[]) request.getAttribute("movieGenre"); // -movieGenre : MovieGenre[]
    Showtime[] showtime = (Showtime[]) request.getAttribute("showtime");         // -showtime : Showtime[]

    // =========================================================================
    // [PHẦN 2: BÓC TÁCH DỮ LIỆU TỪ THUỘC TÍNH ẨN ĐỂ HIỂN THỊ RA CÁC NHÃN]
    // =========================================================================
    // 2.1. Trích xuất thông tin chi tiết phim (selectedMovie) và danh sách thể loại (genreText -> txtGenre)
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

    // 2.2. Trích xuất định dạng phòng chiếu (formatText -> txtFormat) từ showtime[] -> Room
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

    // Định dạng hiển thị ngày: dd/MM/yyyy
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm phim</title>
    <!-- Nhúng file CSS thiết kế chung của hệ thống -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
    <div class="window-card" style="max-width: 1120px; min-height: 620px;">
        <!-- Tiêu đề cửa sổ giao diện -->
        <div class="window-header">Tìm kiếm phim</div>
        
        <div class="window-body">
            <!-- ========================================================================= -->
            <!-- [PHẦN 3: FORM NHẬP TỪ KHÓA TÌM KIẾM PHIM]                                 -->
            <!-- Khớp với các thuộc tính: inMovieName, subSearch, subBack                   -->
            <!-- ========================================================================= -->
            <form action="<%=request.getContextPath()%>/search-movie" method="get" style="display: flex; align-items: center; gap: 14px; margin-bottom: 24px;">
                <label for="inMovieName" style="font-weight: bold; width: 65px; line-height: 1.2;">Tên<br>phim:</label>
                
                <!-- Ô nhập tên phim cần tìm (tabindex=1) -->
                <input type="text"
                       id="inMovieName"
                       name="inMovieName"
                       tabindex="1"
                       autofocus
                       class="form-input"
                       style="width: 280px;"
                       placeholder="Nhập tên phim cần tìm..."
                       value="<%= (inMovieName != null) ? inMovieName : "" %>" />
                
                <!-- Nút bấm Tìm kiếm (tabindex=2) -->
                <button type="submit" id="subSearch" name="subSearch" tabindex="2" class="btn-primary" style="padding: 10px 24px;">
                    Tìm kiếm
                </button>
                
                <!-- Nút liên kết Trở về trang chủ khách hàng (tabindex=3) -->
                <a id="subBack"
                   tabindex="3"
                   href="<%=request.getContextPath()%>/view/Customer/CustomerHomeView.jsp"
                   class="btn-primary"
                   style="padding: 10px 48px;">
                    Trở về
                </a>
            </form>

            <!-- ========================================================================= -->
            <!-- [PHẦN 4: BỐ CỤC 2 CỘT CHÍNH (BẢNG DANH SÁCH & KHUNG CHI TIẾT PHIM)]       -->
            <!-- ========================================================================= -->
            <div style="display: flex; gap: 28px; align-items: flex-start;">
                
                <!-- ===================================================================== -->
                <!-- [PHẦN 4.1: CỘT TRÁI - BẢNG KẾT QUẢ TÌM KIẾM (-outsubMovieList : Table)] -->
                <!-- ===================================================================== -->
                <div style="flex: 1.05;">
                    <% if (inMovieName != null) { %>
                        <h3 style="margin-top: 0; margin-bottom: 10px; font-size: 16px;">Danh sách phim tìm được</h3>

                        <%-- TRƯỜNG HỢP 1: TÌM THẤY PHIM (Vẽ bảng dữ liệu outsubMovieList) --%>
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
                                        <!-- Dòng có thể click: Click vào để xem chi tiết phim bên cột phải -->
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

                            <!-- Nhãn hiển thị tổng số phim tìm thấy (-txtTotalMovies : text) -->
                            <p id="txtTotalMovies" style="font-weight: bold; margin: 14px 0;">
                                Tổng các bộ phim theo tìm kiếm: <%= outsubMovieList.length %>
                            </p>
                        
                        <%-- TRƯỜNG HỢP 2: KHÔNG TÌM THẤY PHIM (Ngoại lệ 5.1 trong Báo cáo) --%>
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

                <!-- ===================================================================== -->
                <!-- [PHẦN 4.2: CỘT PHẢI - THÔNG TIN CHI TIẾT BỘ PHIM ĐƯỢC CHỌN]           -->
                <!-- ===================================================================== -->
                <div style="flex: 1.15;">
                    <% if (selectedMovie != null) { %>
                        <div style="border: 1px solid #aebbc7; background-color: #fafbfc; padding: 18px 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.08);">
                            <h3 style="margin-top: 0; margin-bottom: 16px; font-size: 16px;">
                                Thông tin chi tiết phim
                            </h3>

                            <div style="display: flex; gap: 18px; margin-bottom: 16px;">
                                <!-- Khung hiển thị ảnh poster phim (-imgPoster : Image) -->
                                <div id="imgPoster" style="width: 125px; height: 175px; border: 1px solid #8e9ba8; background-color: #e4eaf0; display: flex; align-items: center; justify-content: center; text-align: center; color: #555; font-size: 14px; flex-shrink: 0;">
                                    Ảnh<br>poster
                                </div>

                                <!-- Bảng nhãn chi tiết từng trường thông tin phim -->
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

                            <!-- Nhãn mô tả tóm tắt nội dung phim (-txtDescription : text) -->
                            <p id="txtDescription" style="font-size: 14px; line-height: 1.5; margin-bottom: 20px;">
                                <strong>Mô tả:</strong> <%= selectedMovie.getDescription() != null ? selectedMovie.getDescription() : "" %>
                            </p>

                            <!-- Nút liên kết chuyển tiếp sang ca sử dụng Mua vé (-subBuyTicket : link) -->
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
