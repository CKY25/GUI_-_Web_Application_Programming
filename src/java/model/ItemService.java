/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;

/**
 *
 * @author User
 */
public class ItemService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public ItemService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addItem(Item item) {
        mgr.persist(item);
        return true;
    }

    public boolean updateItem(Item item) {
        mgr.merge(item);
        return true;
    }

    public boolean deleteItem(int itemid) {
        Item item = findItemByCode(itemid);
        if (item != null) {
            mgr.remove(item);
            return true;
        } else {
            return false;
        }
    }

    public Item findItemByCode(int itemId) {
        Item item = mgr.find(Item.class, itemId);
        return item;
    }

    public List<Item> searchItemName(String itemName) {
        List itemSearchList = mgr.createNamedQuery("Item.findSearchItem").setParameter("itemname", "%" + itemName + "%").getResultList();
        return itemSearchList;
    }

    public List<Item> findAll() {
        List itemList = mgr.createNamedQuery("Item.findAll").getResultList();
        return itemList;
    }

    public List<Item> findById(int itemid) {
        List itemList = mgr.createNamedQuery("Item.findByItemid").setParameter("itemid", itemid).getResultList();
        return itemList;
    }
    
    public List<Item> findItemByPrice(double min, double max){
        List itemList = mgr.createQuery("SELECT i FROM Item i WHERE i.itemprice BETWEEN :itemmin AND :itemmax ORDER BY i.itemprice").setParameter("itemmin", min).setParameter("itemmax", max).getResultList();
        return itemList;
    }
    
    public List<Item> generateMostReport(){
        List itemList = mgr.createQuery("SELECT i FROM Item i ORDER BY i.itemsoldqty DESC").setMaxResults(5).getResultList();
        return itemList;
    }

    public List<Item> generateLeastReport(){
        List itemList = mgr.createQuery("SELECT i FROM Item i ORDER BY i.itemsoldqty").setMaxResults(5).getResultList();
        return itemList;
    }
    
    public boolean checkExist(int itemid) {
        Item item = findItemByCode(itemid);
        if (item != null) {
            return true;
        } else {
            return false;
        }
    }

}
