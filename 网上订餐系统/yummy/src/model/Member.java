package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Member {
    private String email;
    private String phone;
    private String name;
    private double money;
    private String address;
    private Integer viplevel;
    private Double total;
    private Boolean logoff;
    private String password;
    private Boolean actived;
    private String code;

    @Id
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "money")
    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    @Basic
    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "viplevel")
    public Integer getViplevel() {
        return viplevel;
    }

    public void setViplevel(Integer viplevel) {
        this.viplevel = viplevel;
    }

    @Basic
    @Column(name = "total")
    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    @Basic
    @Column(name = "logoff")
    public Boolean getLogoff() {
        return logoff;
    }

    public void setLogoff(Boolean logoff) {
        this.logoff = logoff;
    }

    @Basic
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "actived")
    public Boolean getActived() {
        return actived;
    }

    public void setActived(Boolean actived) {
        this.actived = actived;
    }

    @Basic
    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Member member = (Member) o;
        return Double.compare(member.money, money) == 0 &&
                Objects.equals(email, member.email) &&
                Objects.equals(phone, member.phone) &&
                Objects.equals(name, member.name) &&
                Objects.equals(address, member.address) &&
                Objects.equals(viplevel, member.viplevel) &&
                Objects.equals(total, member.total) &&
                Objects.equals(logoff, member.logoff) &&
                Objects.equals(password, member.password) &&
                Objects.equals(actived, member.actived) &&
                Objects.equals(code, member.code);
    }

    @Override
    public int hashCode() {

        return Objects.hash(email, phone, name, money, address, viplevel, total, logoff, password, actived, code);
    }
}
