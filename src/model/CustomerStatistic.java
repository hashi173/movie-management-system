package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

public class CustomerStatistic extends Customer {
    private static final long serialVersionUID = 1L;

    private LocalTime lastTransactionTime;
    private LocalDate lastTransactionDate;
    private BigDecimal totalAmount;

    public CustomerStatistic() {
        super();
    }

    public CustomerStatistic(int id, String username, String password, String fullname,
                             String email, String phone, LocalDate dob, String address,
                             String customerCode, LocalTime lastTransactionTime,
                             LocalDate lastTransactionDate, BigDecimal totalAmount) {
        super(id, username, password, fullname, email, phone, dob, address, customerCode);
        this.lastTransactionTime = lastTransactionTime;
        this.lastTransactionDate = lastTransactionDate;
        this.totalAmount = totalAmount;
    }

    public LocalTime getLastTransactionTime() {
        return lastTransactionTime;
    }

    public void setLastTransactionTime(LocalTime lastTransactionTime) {
        this.lastTransactionTime = lastTransactionTime;
    }

    public LocalDate getLastTransactionDate() {
        return lastTransactionDate;
    }

    public void setLastTransactionDate(LocalDate lastTransactionDate) {
        this.lastTransactionDate = lastTransactionDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
}
