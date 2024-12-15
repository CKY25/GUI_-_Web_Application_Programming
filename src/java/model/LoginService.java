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

public class LoginService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public LoginService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addUser(Loginuser user) {
        mgr.persist(user);
        return true;
    }
    
    public boolean delUser(Loginuser user) {
        mgr.remove(user);
        return true;
    }
    
    public boolean updateUser(Loginuser user) {
        mgr.merge(user);
        return true;
    }

    public Loginuser findUserByCode(String userid) {
        Loginuser user = mgr.find(Loginuser.class, userid);
        //Loginuser user = (Loginuser) mgr.createNamedQuery("Loginuser.findByUserid").setParameter("userid", userid).getSingleResult();
        return user;
    }
    
    public Loginuser findEmail(String email) {
        Loginuser user = (Loginuser) mgr.createNamedQuery("Loginuser.findByEmail").setParameter("email", email).getSingleResult();
        return user;
    }

    public String findLastUserId() {
        String lastId;
        try {
            lastId = (String) mgr.createQuery("SELECT u.userid FROM Loginuser u ORDER BY u.userid DESC").setMaxResults(1).getSingleResult();
        } catch (NoResultException ex) {
            lastId = "";
        }
        return lastId;
    }
    
    public List<Loginuser> findUserById(String userid) {
        List userResult = mgr.createNamedQuery("Loginuser.findByUserid").setParameter("userid", userid).getResultList();
        return userResult;
    }
    
    public List<Loginuser> findUserByEmail(String email) {
        List emailList = mgr.createNamedQuery("Loginuser.findByEmail").setParameter("email", email).getResultList();
        return emailList;
    }

    public List<Loginuser> findAll() {
        List userList = mgr.createNamedQuery("Loginuser.findAll").getResultList();
        return userList;
    }

}
