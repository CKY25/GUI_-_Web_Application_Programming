package dao;

import java.sql.*;
import java.util.*;

import model.CartItem;
import model.Item;

public class ItemDao {

    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ItemDao() {
        super();
        createDBConnection();
    }

    private void createDBConnection() {
        try {
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/assignment", "nbuser", "nbuser");
        } catch (SQLException ex) {
            System.out.print("connected");
        }
    }

//    public List<CartItem> getAllProducts() {
//        List<CartItem> book = new ArrayList<>();
//        try {
//
//            query = "select * from products";
//            pst = this.con.prepareStatement(query);
//            rs = pst.executeQuery();
//
//            while (rs.next()) {
//                Item row = new Item();
//                row.setItemid(rs.getInt("id"));
//                row.setName(rs.getString("name"));
//                row.setCategory(rs.getString("category"));
//                row.setPrice(rs.getDouble("price"));
//                row.setImage(rs.getString("image"));
//
//                book.add(row);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            System.out.println(e.getMessage());
//        }
//        return book;
//    }
//
//    public Product getSingleProduct(int id) {
//        Product row = null;
//        try {
//            query = "select * from products where id=? ";
//
//            pst = this.con.prepareStatement(query);
//            pst.setInt(1, id);
//            ResultSet rs = pst.executeQuery();
//
//            while (rs.next()) {
//                row = new Product();
//                row.setId(rs.getInt("id"));
//                row.setName(rs.getString("name"));
//                row.setCategory(rs.getString("category"));
//                row.setPrice(rs.getDouble("price"));
//                row.setImage(rs.getString("image"));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            System.out.println(e.getMessage());
//        }
//
//        return row;
//    }
//
    public double getTotalCartPrice(List<CartItem> cartItemList) {
        double sum = 0;
        try {
            if (cartItemList != null) {
                if (cartItemList.size() > 0) {
                    for (CartItem item : cartItemList) {
                        query = "select ITEMPRICE from ITEM where ITEMID=?";
                        pst = this.con.prepareStatement(query);
                        pst.setInt(1, item.getItemid());
                        rs = pst.executeQuery();
                        while (rs.next()) {
                            sum += rs.getDouble("ITEMPRICE") * item.getItemqty();
                        }
                    }
                }
            }

            if (sum == 0) {
                sum -= 0;
            }
            if (sum < 200 && sum != 0) {
                sum += 25;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sum;
    }

    public List<CartItem> getCartProducts(List<CartItem> cartItemList) {
        List<CartItem> book = new ArrayList<>();
        try {
            if (cartItemList.size() > 0) {
                for (CartItem item : cartItemList) {
                    query = "select * from Item where ITEMID=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getItemid());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        CartItem row = new CartItem();
                        row.setItemid(rs.getInt("ITEMID"));
                        row.setItemname(rs.getString("ITEMNAME"));
                        row.setItemimage(rs.getString("ITEMIMAGE"));
                        row.setItemprice(rs.getDouble("ITEMPRICE"));
                        row.setItemSubtotal(rs.getDouble("ITEMPRICE") * item.getItemqty());
                        row.setItemqty(item.getItemqty());
                        book.add(row);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        System.out.print("ITEMDAO =" + book);
        return book;
    }
}
