package model;

import java.io.Serializable;
import java.time.LocalTime;

public class TimeSlot implements Serializable {
    private static final long serialVersionUID = 1L;

    private String timeSlotCode;
    private LocalTime startTime;
    private LocalTime endTime;
    private String status;

    public TimeSlot() {
        super();
    }

    public TimeSlot(String timeSlotCode, LocalTime startTime, LocalTime endTime, String status) {
        super();
        this.timeSlotCode = timeSlotCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public String getTimeSlotCode() {
        return timeSlotCode;
    }

    public void setTimeSlotCode(String timeSlotCode) {
        this.timeSlotCode = timeSlotCode;
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
}
