/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
public class CartItem extends Item {

    //private Integer itemid;
    private Integer itemqty;
    private double itemSubtotal;
//    Item item;
    
    

    public CartItem() {
        //super();
    }
    
//    public CartItem(int itemqty){
//        super();
//        this.itemqty = itemqty;
//    }
//    
//    public CartItem(Item item, Integer itemqty) {
//        this.item = item;
//        this.itemqty = itemqty;
//    }

    public Integer getItemqty() {
        return itemqty;
    }

    public void setItemqty(Integer itemqty) {
        this.itemqty = itemqty;
    }
    
    //public getTotalCartPrice()

    public double getItemSubtotal() {
        return itemSubtotal;
    }

    public void setItemSubtotal(double itemSubtotal) {
        this.itemSubtotal = itemSubtotal;
    }
    

}
