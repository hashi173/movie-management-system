package model;

import java.io.Serializable;
import java.time.LocalTime;

public class Showtime implements Serializable {
    private static final long serialVersionUID = 1L;

    private String showtimeCode;
    private LocalTime startTime;
    private LocalTime endTime;
    private String status;
    private Movie movie;
    private Room room;
    private ShowDate showDate;
    private TimeSlot timeSlot;

    public Showtime() {
        super();
    }

    public Showtime(String showtimeCode, LocalTime startTime, LocalTime endTime,
                    String status, Movie movie, Room room, ShowDate showDate, TimeSlot timeSlot) {
        super();
        this.showtimeCode = showtimeCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.movie = movie;
        this.room = room;
        this.showDate = showDate;
        this.timeSlot = timeSlot;
    }

    public String getShowtimeCode() {
        return showtimeCode;
    }

    public void setShowtimeCode(String showtimeCode) {
        this.showtimeCode = showtimeCode;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public ShowDate getShowDate() {
        return showDate;
    }

    public void setShowDate(ShowDate showDate) {
        this.showDate = showDate;
    }

    public TimeSlot getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(TimeSlot timeSlot) {
        this.timeSlot = timeSlot;
    }
}
