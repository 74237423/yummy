package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Orderdetail {
    private int id;
    private Integer foodid;
    private Integer num;
    private String orderid;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "foodid")
    public Integer getFoodid() {
        return foodid;
    }

    public void setFoodid(Integer foodid) {
        this.foodid = foodid;
    }

    @Basic
    @Column(name = "num")
    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    @Basic
    @Column(name = "orderid")
    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Orderdetail that = (Orderdetail) o;
        return id == that.id &&
                Objects.equals(foodid, that.foodid) &&
                Objects.equals(num, that.num) &&
                Objects.equals(orderid, that.orderid);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, foodid, num, orderid);
    }
}
