package model;

import java.io.Serializable;

public class Room implements Serializable {
    private static final long serialVersionUID = 1L;

    private String roomCode;
    private String roomName;
    private String format;
    private int capacity;
    private String status;
    private Seat[] seats;

    public Room() {
        super();
    }

    public Room(String roomCode, String roomName, String format,
                int capacity, String status, Seat[] seats) {
        super();
        this.roomCode = roomCode;
        this.roomName = roomName;
        this.format = format;
        this.capacity = capacity;
        this.status = status;
        this.seats = seats;
    }

    public String getRoomCode() {
        return roomCode;
    }

    public void setRoomCode(String roomCode) {
        this.roomCode = roomCode;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Seat[] getSeats() {
        return seats;
    }

    public void setSeats(Seat[] seats) {
        this.seats = seats;
    }
}
