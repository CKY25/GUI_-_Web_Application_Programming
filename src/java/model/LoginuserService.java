/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author User
 */
public class LoginuserService {
      @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public LoginuserService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addCustomer(Loginuser loginuser) {
        mgr.persist(loginuser);
        return true;
    }

    public Loginuser findCustomerById(String userId) {
        Loginuser loginuser = mgr.find(Loginuser.class, userId);
        return loginuser;
    }

    public boolean deleteCustomer(String userId) {
        Loginuser loginuser = findCustomerById(userId);
        if (loginuser != null) {
            mgr.remove(loginuser);
            return true;
        }
        return false;
    }

    public List<Loginuser> findAll() {
        List customerList = mgr.createNamedQuery("Loginuser.findAll").getResultList();
        return customerList;
    }

    public boolean updateCustomer(Loginuser loginuser) {
        Loginuser tempUser = findCustomerById(loginuser.getUserid());
        if (tempUser != null) {
            tempUser.setUsername(loginuser.getUsername());
            tempUser.setEmail(loginuser.getEmail());
            return true;
        }
        return false;
    }
}
