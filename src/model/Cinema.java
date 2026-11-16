package model;

import java.io.Serializable;

public class Cinema implements Serializable {
    private static final long serialVersionUID = 1L;

    private String cinemaCode;
    private String cinemaName;
    private String address;
    private String description;
    private Room[] rooms;

    public Cinema() {
        super();
    }

    public Cinema(String cinemaCode, String cinemaName, String address,
                  String description, Room[] rooms) {
        super();
        this.cinemaCode = cinemaCode;
        this.cinemaName = cinemaName;
        this.address = address;
        this.description = description;
        this.rooms = rooms;
    }

    public String getCinemaCode() {
        return cinemaCode;
    }

    public void setCinemaCode(String cinemaCode) {
        this.cinemaCode = cinemaCode;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Room[] getRooms() {
        return rooms;
    }

    public void setRooms(Room[] rooms) {
        this.rooms = rooms;
    }
}
