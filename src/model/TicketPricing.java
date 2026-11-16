package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class TicketPricing implements Serializable {
    private static final long serialVersionUID = 1L;

    private String pricingCode;
    private BigDecimal basePrice;
    private BigDecimal dateSurcharge;
    private BigDecimal timeSurcharge;
    private BigDecimal formatSurcharge;
    private BigDecimal seatSurcharge;

    public TicketPricing() {
        super();
    }

    public TicketPricing(String pricingCode, BigDecimal basePrice, BigDecimal dateSurcharge,
                         BigDecimal timeSurcharge, BigDecimal formatSurcharge, BigDecimal seatSurcharge) {
        super();
        this.pricingCode = pricingCode;
        this.basePrice = basePrice;
        this.dateSurcharge = dateSurcharge;
        this.timeSurcharge = timeSurcharge;
        this.formatSurcharge = formatSurcharge;
        this.seatSurcharge = seatSurcharge;
    }

    public String getPricingCode() {
        return pricingCode;
    }

    public void setPricingCode(String pricingCode) {
        this.pricingCode = pricingCode;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public BigDecimal getDateSurcharge() {
        return dateSurcharge;
    }

    public void setDateSurcharge(BigDecimal dateSurcharge) {
        this.dateSurcharge = dateSurcharge;
    }

    public BigDecimal getTimeSurcharge() {
        return timeSurcharge;
    }

    public void setTimeSurcharge(BigDecimal timeSurcharge) {
        this.timeSurcharge = timeSurcharge;
    }

    public BigDecimal getFormatSurcharge() {
        return formatSurcharge;
    }

    public void setFormatSurcharge(BigDecimal formatSurcharge) {
        this.formatSurcharge = formatSurcharge;
    }

    public BigDecimal getSeatSurcharge() {
        return seatSurcharge;
    }

    public void setSeatSurcharge(BigDecimal seatSurcharge) {
        this.seatSurcharge = seatSurcharge;
    }
}
