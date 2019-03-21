package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
public class Ordercheck {
    private String orderid;
    private String memberemail;
    private Integer restauranrid;
    private Double totalprice;
    private Boolean paid;
    private Boolean sent;
    private Boolean arrived;
    private Boolean askReturn;
    private Boolean returned;
    private Boolean balance;
    private Double earn;
    private Timestamp datetime;
    private Boolean desideRerutn;
    private String sendtime;

    @Id
    @Column(name = "orderid")
    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    @Basic
    @Column(name = "memberemail")
    public String getMemberemail() {
        return memberemail;
    }

    public void setMemberemail(String memberemail) {
        this.memberemail = memberemail;
    }

    @Basic
    @Column(name = "restauranrid")
    public Integer getRestauranrid() {
        return restauranrid;
    }

    public void setRestauranrid(Integer restauranrid) {
        this.restauranrid = restauranrid;
    }

    @Basic
    @Column(name = "totalprice")
    public Double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(Double totalprice) {
        this.totalprice = totalprice;
    }

    @Basic
    @Column(name = "paid")
    public Boolean getPaid() {
        return paid;
    }

    public void setPaid(Boolean paid) {
        this.paid = paid;
    }

    @Basic
    @Column(name = "sent")
    public Boolean getSent() {
        return sent;
    }

    public void setSent(Boolean sent) {
        this.sent = sent;
    }

    @Basic
    @Column(name = "arrived")
    public Boolean getArrived() {
        return arrived;
    }

    public void setArrived(Boolean arrived) {
        this.arrived = arrived;
    }

    @Basic
    @Column(name = "askReturn")
    public Boolean getAskReturn() {
        return askReturn;
    }

    public void setAskReturn(Boolean askReturn) {
        this.askReturn = askReturn;
    }

    @Basic
    @Column(name = "returned")
    public Boolean getReturned() {
        return returned;
    }

    public void setReturned(Boolean returned) {
        this.returned = returned;
    }

    @Basic
    @Column(name = "balance")
    public Boolean getBalance() {
        return balance;
    }

    public void setBalance(Boolean balance) {
        this.balance = balance;
    }

    @Basic
    @Column(name = "earn")
    public Double getEarn() {
        return earn;
    }

    public void setEarn(Double earn) {
        this.earn = earn;
    }

    @Basic
    @Column(name = "datetime")
    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }

    @Basic
    @Column(name = "desideRerutn")
    public Boolean getDesideRerutn() {
        return desideRerutn;
    }

    public void setDesideRerutn(Boolean desideRerutn) {
        this.desideRerutn = desideRerutn;
    }

    @Basic
    @Column(name = "sendtime")
    public String getSendtime() {
        return sendtime;
    }

    public void setSendtime(String sendtime) {
        this.sendtime = sendtime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ordercheck that = (Ordercheck) o;
        return Objects.equals(orderid, that.orderid) &&
                Objects.equals(memberemail, that.memberemail) &&
                Objects.equals(restauranrid, that.restauranrid) &&
                Objects.equals(totalprice, that.totalprice) &&
                Objects.equals(paid, that.paid) &&
                Objects.equals(sent, that.sent) &&
                Objects.equals(arrived, that.arrived) &&
                Objects.equals(askReturn, that.askReturn) &&
                Objects.equals(returned, that.returned) &&
                Objects.equals(balance, that.balance) &&
                Objects.equals(earn, that.earn) &&
                Objects.equals(datetime, that.datetime) &&
                Objects.equals(desideRerutn, that.desideRerutn) &&
                Objects.equals(sendtime, that.sendtime);
    }

    @Override
    public int hashCode() {

        return Objects.hash(orderid, memberemail, restauranrid, totalprice, paid, sent, arrived, askReturn, returned, balance, earn, datetime, desideRerutn, sendtime);
    }
}
