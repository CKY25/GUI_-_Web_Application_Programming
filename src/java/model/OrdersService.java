/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

/**
 *
 * @author User
 */
public class OrdersService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public OrdersService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addOrder(String customerName, String itemName, int qty, String methodName, double totalPrice, Date orderDate, String orderStatus) {
        TypedQuery<Loginuser> customerQuery = mgr.createNamedQuery("Loginuser.findByUsername", Loginuser.class).setParameter("username", customerName);
        Loginuser loginuser = customerQuery.getSingleResult();
        
        TypedQuery<Item> itemQuery = mgr.createNamedQuery("Item.findByItemname", Item.class).setParameter("itemname", itemName);
        Item item = itemQuery.getSingleResult();
        Orders order = new Orders(loginuser, item, qty, methodName, totalPrice, orderDate, orderStatus);
        mgr.persist(order);

        return true;
    }

    public Orders findOrderById(int orderId) {
        Orders order = mgr.find(Orders.class, orderId);
        return order;
    }

    public boolean deleteOrder(int orderId) {
        Orders order = findOrderById(orderId);
        if (order != null) {
            mgr.remove(order);
            return true;
        }
        return false;
    }

    public List<Orders> findAll() {
        List orderList = mgr.createNamedQuery("Orders.findAll").getResultList();
        return orderList;
    }

    public boolean updateOrder(int orderId, String orderStatus) {
        Orders order = findOrderById(orderId);
        if (order != null) {
            order.setOrderStatus(orderStatus);
            mgr.merge(order);
            return true;
        }
        return false;
    }

}
