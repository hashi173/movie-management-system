package model;

import java.time.LocalDate;

public class Saler extends Staff {
    private static final long serialVersionUID = 1L;

    public Saler() {
        super();
    }

    public Saler(int id, String username, String password, String fullname,
                 String email, String phone, LocalDate dob, String address,
                 String position, String staffCode) {
        super(id, username, password, fullname, email, phone, dob, address, position, staffCode);
    }
}
