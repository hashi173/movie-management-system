package model;

import java.io.Serializable;

public class Seat implements Serializable {
    private static final long serialVersionUID = 1L;

    private String seatCode;
    private String rowCoord;
    private int colCoord;
    private String seatType;
    private String description;

    public Seat() {
        super();
    }

    public Seat(String seatCode, String rowCoord, int colCoord,
                String seatType, String description) {
        super();
        this.seatCode = seatCode;
        this.rowCoord = rowCoord;
        this.colCoord = colCoord;
        this.seatType = seatType;
        this.description = description;
    }

    public String getSeatCode() {
        return seatCode;
    }

    public void setSeatCode(String seatCode) {
        this.seatCode = seatCode;
    }

    public String getRowCoord() {
        return rowCoord;
    }

    public void setRowCoord(String rowCoord) {
        this.rowCoord = rowCoord;
    }

    public int getColCoord() {
        return colCoord;
    }

    public void setColCoord(int colCoord) {
        this.colCoord = colCoord;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
