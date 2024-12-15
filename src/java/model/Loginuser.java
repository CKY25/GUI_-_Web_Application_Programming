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
@Table(name = "LOGINUSER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Loginuser.findAll", query = "SELECT l FROM Loginuser l"),
    @NamedQuery(name = "Loginuser.findByUserid", query = "SELECT l FROM Loginuser l WHERE l.userid = :userid"),
    @NamedQuery(name = "Loginuser.findByUsername", query = "SELECT l FROM Loginuser l WHERE l.username = :username"),
    @NamedQuery(name = "Loginuser.findByEmail", query = "SELECT l FROM Loginuser l WHERE l.email = :email"),
    @NamedQuery(name = "Loginuser.findByPassword", query = "SELECT l FROM Loginuser l WHERE l.password = :password"),
    @NamedQuery(name = "Loginuser.findByUserstatus", query = "SELECT l FROM Loginuser l WHERE l.userstatus = :userstatus")})
public class Loginuser implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 6)
    @Column(name = "USERID")
    private String userid;
    @Size(max = 80)
    @Column(name = "USERNAME")
    private String username;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 80)
    @Column(name = "EMAIL")
    private String email;
    @Size(max = 7)
    @Column(name = "PASSWORD")
    private String password;
    @Size(max = 9)
    @Column(name = "USERSTATUS")
    private String userstatus;

    public Loginuser() {
    }

    public Loginuser(String userid) {
        this.userid = userid;
    }

    public Loginuser(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public Loginuser(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public Loginuser(String userid, String username, String email, String password, String userstatus) {
        this.userid = userid;
        this.username = username;
        this.email = email;
        this.password = password;
        this.userstatus = userstatus;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserstatus() {
        return userstatus;
    }

    public void setUserstatus(String userstatus) {
        this.userstatus = userstatus;
    }

    public String generateID(String id) {
        // Insert additional instruction if it is first data
        String[] alpha = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
            "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
            "W", "X", "Y", "Z"};
        String maxErrorMessage = "Customer data have exceeded database limit. Please try again.";
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
                generatedID = "S" + fstAlphaCount + secAlphaCount + "00" + nextIdCount;
            } else if (nextIdCount >= 10 && nextIdCount < 100) {
                generatedID = "S" + fstAlphaCount + secAlphaCount + "0" + nextIdCount;
            } else {
                generatedID = "S" + fstAlphaCount + secAlphaCount + nextIdCount;
            }

            return generatedID;
        } else {
            return generatedID = "SAA001";
        }
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userid != null ? userid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Loginuser)) {
            return false;
        }
        Loginuser other = (Loginuser) object;
        if ((this.userid == null && other.userid != null) || (this.userid != null && !this.userid.equals(other.userid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Loginuser[ userid=" + userid + " ]";
    }

}
