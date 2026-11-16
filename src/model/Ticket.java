package model;

import java.io.Serializable;

public class Ticket implements Serializable {
    private static final long serialVersionUID = 1L;

    private String ticketCode;
    private String ticketStatus;
    private Showtime showtime;
    private Seat seat;
    private TicketPricing ticketPricing;

    public Ticket() {
        super();
    }

    public Ticket(String ticketCode, String ticketStatus, Showtime showtime,
                  Seat seat, TicketPricing ticketPricing) {
        super();
        this.ticketCode = ticketCode;
        this.ticketStatus = ticketStatus;
        this.showtime = showtime;
        this.seat = seat;
        this.ticketPricing = ticketPricing;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

    public TicketPricing getTicketPricing() {
        return ticketPricing;
    }

    public void setTicketPricing(TicketPricing ticketPricing) {
        this.ticketPricing = ticketPricing;
    }
}
