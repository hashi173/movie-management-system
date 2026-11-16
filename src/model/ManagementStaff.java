package model;

import java.time.LocalDate;

public class ManagementStaff extends Staff {
    private static final long serialVersionUID = 1L;

    public ManagementStaff() {
        super();
    }

    public ManagementStaff(int id, String username, String password, String fullname,
                           String email, String phone, LocalDate dob, String address,
                           String position, String staffCode) {
        super(id, username, password, fullname, email, phone, dob, address, position, staffCode);
    }
}
