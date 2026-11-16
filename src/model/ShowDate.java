package model;

import java.io.Serializable;
import java.time.LocalDate;

public class ShowDate implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private LocalDate dateValue;
    private String dateType;

    public ShowDate() {
        super();
    }

    public ShowDate(int id, LocalDate dateValue, String dateType) {
        super();
        this.id = id;
        this.dateValue = dateValue;
        this.dateType = dateType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getDateValue() {
        return dateValue;
    }

    public void setDateValue(LocalDate dateValue) {
        this.dateValue = dateValue;
    }

    public String getDateType() {
        return dateType;
    }

    public void setDateType(String dateType) {
        this.dateType = dateType;
    }
}
