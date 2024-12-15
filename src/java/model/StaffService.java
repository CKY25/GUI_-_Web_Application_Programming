/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;

public class StaffService implements Serializable {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public StaffService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addStaff(Staff staff) {
        mgr.persist(staff);
        return true;
    }
    
    public boolean delStaff(Staff staff) {
        mgr.remove(staff);
        return true;
    }
    
    public boolean updateStaff(Staff staff) {
        mgr.merge(staff);
        return true;
    }

    public Staff findStaffByCode(String staffID) {
        Staff staff = mgr.find(Staff.class, staffID);
        return staff;
    }

    public String findLastStaffId() {
        String lastId;
        try {
            lastId = (String) mgr.createQuery("SELECT s.staffid FROM Staff s ORDER BY s.staffid DESC").setMaxResults(1).getSingleResult();
        } catch (NoResultException ex) {
            lastId = "";
        }
        return lastId;
    }
    
    public List<Staff> findStaffById(String staffid) {
        List staffList = mgr.createNamedQuery("Staff.findByStaffid").setParameter("staffid", staffid).getResultList();
        return staffList;
    }
    
    public List<Staff> findStaffByEmail(String semail) {
        List staffList = mgr.createNamedQuery("Staff.findBySemail").setParameter("semail", semail).getResultList();
        return staffList;
    }

    public List<Staff> findAll() {
        List staffList = mgr.createNamedQuery("Staff.findAll").getResultList();
        return staffList;
    }
    
}
