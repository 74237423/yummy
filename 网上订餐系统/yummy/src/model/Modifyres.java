package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
public class Modifyres {
    private int id;
    private Integer resid;
    private Timestamp datetime;
    private String typebefore;
    private String typeafter;
    private String desbefore;
    private String desafter;
    private boolean ischeck;
    private boolean aggree;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "resid")
    public Integer getResid() {
        return resid;
    }

    public void setResid(Integer resid) {
        this.resid = resid;
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
    @Column(name = "typebefore")
    public String getTypebefore() {
        return typebefore;
    }

    public void setTypebefore(String typebefore) {
        this.typebefore = typebefore;
    }

    @Basic
    @Column(name = "typeafter")
    public String getTypeafter() {
        return typeafter;
    }

    public void setTypeafter(String typeafter) {
        this.typeafter = typeafter;
    }

    @Basic
    @Column(name = "desbefore")
    public String getDesbefore() {
        return desbefore;
    }

    public void setDesbefore(String desbefore) {
        this.desbefore = desbefore;
    }

    @Basic
    @Column(name = "desafter")
    public String getDesafter() {
        return desafter;
    }

    public void setDesafter(String desafter) {
        this.desafter = desafter;
    }

    @Basic
    @Column(name = "ischeck")
    public boolean getIscheck() {
        return ischeck;
    }

    public void setIscheck(boolean ischeck) {
        this.ischeck = ischeck;
    }

    @Basic
    @Column(name = "aggree")
    public boolean getAggree() {
        return aggree;
    }

    public void setAggree(boolean aggree) {
        this.aggree = aggree;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Modifyres modifyres = (Modifyres) o;
        return id == modifyres.id &&
                Objects.equals(resid, modifyres.resid) &&
                Objects.equals(datetime, modifyres.datetime) &&
                Objects.equals(typebefore, modifyres.typebefore) &&
                Objects.equals(typeafter, modifyres.typeafter) &&
                Objects.equals(desbefore, modifyres.desbefore) &&
                Objects.equals(desafter, modifyres.desafter) &&
                Objects.equals(ischeck, modifyres.ischeck) &&
                Objects.equals(aggree, modifyres.aggree);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, resid, datetime, typebefore, typeafter, desbefore, desafter, ischeck, aggree);
    }
}
