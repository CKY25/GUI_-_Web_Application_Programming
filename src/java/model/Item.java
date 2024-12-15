/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author User
 */
@Entity
@Table(name = "ITEM")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Item.findAll", query = "SELECT i FROM Item i"),
    @NamedQuery(name = "Item.findByItemid", query = "SELECT i FROM Item i WHERE i.itemid = :itemid"),
    @NamedQuery(name = "Item.findByItemname", query = "SELECT i FROM Item i WHERE i.itemname = :itemname"),
    @NamedQuery(name = "Item.findByItemprice", query = "SELECT i FROM Item i WHERE i.itemprice = :itemprice"),
    @NamedQuery(name = "Item.findByItemstock", query = "SELECT i FROM Item i WHERE i.itemstock = :itemstock"),
    @NamedQuery(name = "Item.findByItemreview", query = "SELECT i FROM Item i WHERE i.itemreview = :itemreview"),
    @NamedQuery(name = "Item.findByItemsoldqty", query = "SELECT i FROM Item i WHERE i.itemsoldqty = :itemsoldqty"),
    @NamedQuery(name = "Item.findByItemimage", query = "SELECT i FROM Item i WHERE i.itemimage = :itemimage"),
    @NamedQuery(name = "Item.findByItemdesc", query = "SELECT i FROM Item i WHERE i.itemdesc = :itemdesc"),
    @NamedQuery(name = "Item.findSearchItem", query = "SELECT i FROM Item i WHERE LOWER(i.itemname) LIKE :itemname")})
public class Item implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ITEMID")
    private Integer itemid;
    @Size(max = 80)
    @Column(name = "ITEMNAME")
    private String itemname;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "ITEMPRICE")
    private Double itemprice;
    @Column(name = "ITEMSTOCK")
    private Integer itemstock;
    @Size(max = 1000)
    @Column(name = "ITEMREVIEW")
    private String itemreview;
    @Column(name = "ITEMSOLDQTY")
    private Integer itemsoldqty;
    @Size(max = 1000)
    @Column(name = "ITEMIMAGE")
    private String itemimage;
    @Size(max = 100)
    @Column(name = "ITEMDESC")
    private String itemdesc;

    public Item() {
    }

    public Item(Integer itemid) {
        this.itemid = itemid;
    }

    public Item(Integer itemid, String itemname, Double itemprice, Integer itemstock, Integer itemsoldqty, String itemimage, String itemdesc) {
        this.itemid = itemid;
        this.itemname = itemname;
        this.itemprice = itemprice;
        this.itemstock = itemstock;
        this.itemsoldqty = itemsoldqty;
        this.itemimage = itemimage;
        this.itemdesc = itemdesc;
    }

    public Item(Integer itemid, Double itemprice) {
        this.itemid = itemid;
        this.itemprice = itemprice;
    }

    public Item(Integer itemid, String itemname, Double itemprice) {
        this.itemid = itemid;
        this.itemname = itemname;
        this.itemprice = itemprice;
    }

    public Item(Integer itemid, String itemname, Double itemprice, String itemimage) {
        this.itemid = itemid;
        this.itemname = itemname;
        this.itemprice = itemprice;
        this.itemimage = itemimage;
    }

    public Integer getItemid() {
        return itemid;
    }

    public void setItemid(Integer itemid) {
        this.itemid = itemid;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public Double getItemprice() {
        return itemprice;
    }

    public void setItemprice(Double itemprice) {
        this.itemprice = itemprice;
    }

    public Integer getItemstock() {
        return itemstock;
    }

    public void setItemstock(Integer itemstock) {
        this.itemstock = itemstock;
    }

    public String getItemreview() {
        return itemreview;
    }

    public void setItemreview(String itemreview) {
        this.itemreview = itemreview;
    }

    public Integer getItemsoldqty() {
        return itemsoldqty;
    }

    public void setItemsoldqty(Integer itemsoldqty) {
        this.itemsoldqty = itemsoldqty;
    }

    public String getItemimage() {
        return "./src/img/" + itemimage;
    }

    public void setItemimage(String itemimage) {
        this.itemimage = itemimage;
    }

    public String getItemdesc() {
        return itemdesc;
    }

    public void setItemdesc(String itemdesc) {
        this.itemdesc = itemdesc;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemid != null ? itemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Item)) {
            return false;
        }
        Item other = (Item) object;
        if ((this.itemid == null && other.itemid != null) || (this.itemid != null && !this.itemid.equals(other.itemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Item[ itemid=" + itemid + " ]";
    }

}
