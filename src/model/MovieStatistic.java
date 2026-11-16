package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class MovieStatistic extends Movie {
    private static final long serialVersionUID = 1L;

    private int totalTicketsSold;
    private BigDecimal totalRevenue;

    public MovieStatistic() {
        super();
    }

    public MovieStatistic(String movieCode, String title, int duration, String ageLimit,
                          String director, String actor, String language, String description,
                          String status, String poster, LocalDate releaseDate,
                          int totalTicketsSold, BigDecimal totalRevenue) {
        super(movieCode, title, duration, ageLimit, director, actor, language,
              description, status, poster, releaseDate);
        this.totalTicketsSold = totalTicketsSold;
        this.totalRevenue = totalRevenue;
    }

    public int getTotalTicketsSold() {
        return totalTicketsSold;
    }

    public void setTotalTicketsSold(int totalTicketsSold) {
        this.totalTicketsSold = totalTicketsSold;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
