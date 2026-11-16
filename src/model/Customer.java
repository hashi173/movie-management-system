package model;

import java.time.LocalDate;

public class Customer extends Member {
    private static final long serialVersionUID = 1L;

    private String customerCode;

    public Customer() {
        super();
    }

    public Customer(int id, String username, String password, String fullname,
                    String email, String phone, LocalDate dob, String address,
                    String customerCode) {
        super(id, username, password, fullname, email, phone, dob, address);
        this.customerCode = customerCode;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }
}
