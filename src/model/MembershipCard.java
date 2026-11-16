package model;

import java.io.Serializable;
import java.time.LocalDate;

public class MembershipCard implements Serializable {
    private static final long serialVersionUID = 1L;

    private String cardCode;
    private LocalDate issueDate;
    private int point;
    private Customer customer;
    private CardRank cardRank;

    public MembershipCard() {
        super();
    }

    public MembershipCard(String cardCode, LocalDate issueDate, int point,
                          Customer customer, CardRank cardRank) {
        super();
        this.cardCode = cardCode;
        this.issueDate = issueDate;
        this.point = point;
        this.customer = customer;
        this.cardRank = cardRank;
    }

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public CardRank getCardRank() {
        return cardRank;
    }

    public void setCardRank(CardRank cardRank) {
        this.cardRank = cardRank;
    }
}
