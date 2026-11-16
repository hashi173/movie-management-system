package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class CardRank implements Serializable {
    private static final long serialVersionUID = 1L;

    private String rankCode;
    private String rankName;
    private int minPoint;
    private BigDecimal discountRate;

    public CardRank() {
        super();
    }

    public CardRank(String rankCode, String rankName, int minPoint, BigDecimal discountRate) {
        super();
        this.rankCode = rankCode;
        this.rankName = rankName;
        this.minPoint = minPoint;
        this.discountRate = discountRate;
    }

    public String getRankCode() {
        return rankCode;
    }

    public void setRankCode(String rankCode) {
        this.rankCode = rankCode;
    }

    public String getRankName() {
        return rankName;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    public int getMinPoint() {
        return minPoint;
    }

    public void setMinPoint(int minPoint) {
        this.minPoint = minPoint;
    }

    public BigDecimal getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(BigDecimal discountRate) {
        this.discountRate = discountRate;
    }
}
