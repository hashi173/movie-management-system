package model;

import java.time.LocalDate;

public class Staff extends Member {
    private static final long serialVersionUID = 1L;

    private String position;
    private String staffCode;

    public Staff() {
        super();
    }

    public Staff(int id, String username, String password, String fullname,
                 String email, String phone, LocalDate dob, String address,
                 String position, String staffCode) {
        super(id, username, password, fullname, email, phone, dob, address);
        this.position = position;
        this.staffCode = staffCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStaffCode() {
        return staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }
}
