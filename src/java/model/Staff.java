/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
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

@Entity
@Table(name = "STAFF")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staff.findAll", query = "SELECT s FROM Staff s"),
    @NamedQuery(name = "Staff.findByStaffid", query = "SELECT s FROM Staff s WHERE s.staffid = :staffid"),
    @NamedQuery(name = "Staff.findByStaffname", query = "SELECT s FROM Staff s WHERE s.staffname = :staffname"),
    @NamedQuery(name = "Staff.findBySemail", query = "SELECT s FROM Staff s WHERE s.semail = :semail"),
    @NamedQuery(name = "Staff.findBySpassword", query = "SELECT s FROM Staff s WHERE s.spassword = :spassword"),
    @NamedQuery(name = "Staff.findByStaffstatus", query = "SELECT s FROM Staff s WHERE s.staffstatus = :staffstatus")})
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 6)
    @Column(name = "STAFFID")
    private String staffid;
    @Size(max = 80)
    @Column(name = "STAFFNAME")
    private String staffname;
    @Size(max = 80)
    @Column(name = "SEMAIL")
    private String semail;
    @Size(max = 7)
    @Column(name = "SPASSWORD")
    private String spassword;
    @Size(max = 9)
    @Column(name = "STAFFSTATUS")
    private String staffstatus;

    public Staff() {
    }

    public Staff(String staffid) {
        this.staffid = staffid;
    }
    
    public Staff(String semail, String spassword) {
        this.semail = semail;
        this.spassword = spassword;
    }

    public Staff(String staffname, String semail, String spassword) {
        this.staffname = staffname;
        this.semail = semail;
        this.spassword = spassword;
    }

    public Staff(String staffid, String staffname, String semail, String spassword, String staffstatus) {
        this.staffid = staffid;
        this.staffname = staffname;
        this.semail = semail;
        this.spassword = spassword;
        this.staffstatus = staffstatus;
    }

    public String getStaffid() {
        return staffid;
    }

    public void setStaffid(String staffid) {
        this.staffid = staffid;
    }

    public String getStaffname() {
        return staffname;
    }

    public void setStaffname(String staffname) {
        this.staffname = staffname;
    }

    public String getSemail() {
        return semail;
    }

    public void setSemail(String semail) {
        this.semail = semail;
    }

    public String getSpassword() {
        return spassword;
    }

    public void setSpassword(String spassword) {
        this.spassword = spassword;
    }

    public String getStaffstatus() {
        return staffstatus;
    }

    public void setStaffstatus(String staffstatus) {
        this.staffstatus = staffstatus;
    }
    
    public String generateStaffID(String id) {
        // Insert additional instruction if it is first data
        String[] alpha = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
            "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
            "W", "X", "Y", "Z"};
        String maxErrorMessage = "Staff data have exceeded database limit. Please try again.";
        List<String> alphaList = Arrays.asList(alpha);
        String generatedID;

        // access data and it's index
        String fstAlphaCount = id.substring(1, 2);
        int fstAlphaIdx = alphaList.indexOf(fstAlphaCount);
        String secAlphaCount = id.substring(2, 3);
        int secAlphaIdx = alphaList.indexOf(secAlphaCount);

        int currentIdCount = Integer.parseInt(id.substring(3));
        int nextIdCount = currentIdCount + 1;

        if (nextIdCount % 1000 == 0) {
            nextIdCount = 1;
            secAlphaIdx++;
            if (secAlphaIdx % 26 == 0) {
                fstAlphaIdx++;
                if (fstAlphaIdx % 26 == 0 && secAlphaIdx % 26 == 0) {
                    System.out.println(maxErrorMessage);
                    generatedID = "null";
                    return generatedID;
                }
                secAlphaIdx = 0;
            }
        }

        if (id != null) {
            if (nextIdCount >= 1 && nextIdCount < 10) {
                generatedID = "X" + fstAlphaCount + secAlphaCount + "00" + nextIdCount;
            } else if (nextIdCount >= 10 && nextIdCount < 100) {
                generatedID = "X" + fstAlphaCount + secAlphaCount + "0" + nextIdCount;
            } else {
                generatedID = "X" + fstAlphaCount + secAlphaCount + nextIdCount;
            }

            return generatedID;
        } else {
            return generatedID = "XAA001";
        }
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffid != null ? staffid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.staffid == null && other.staffid != null) || (this.staffid != null && !this.staffid.equals(other.staffid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Staff[ staffid=" + staffid + " ]";
    }
    
}
