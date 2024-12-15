package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import model.Cart;
import model.CartItem;

import model.Item;

public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @PersistenceContext
    EntityManager mgr;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            //Cart cartitem = null;
            Item item = mgr.createNamedQuery("Item.findByItemid", Item.class).setParameter("itemid", id)
                    .getSingleResult();
            System.out.println("ITEM=" + item);
            System.out.println(item.getItemname());

            CartItem cartitem = new CartItem();
            List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cartItemList");
            cartitem.setItemid(id);
            cartitem.setItemqty(1);
            if (cartItemList == null) {
                cartItemList = new ArrayList<>();
                //cartItemList.add(cartitem);
            }
            boolean itemExists = false;
            System.out.println("cartItemList: " + cartItemList);
            System.out.println("Cart Item: " + cartitem);
            for (CartItem existingItem : cartItemList) {
                System.out.print("ID =" + id);
                System.out.print("existingItem.getItemid() =" + existingItem.getItemid());
                if (existingItem.getItemid() == id) {
                    //if (1 == id) {
                    // If item already exists, increase its quantity and set the flag
                    existingItem.setItemqty(existingItem.getItemqty() + 1);
                    itemExists = true;
                    break;
                }
            }
            System.out.print("ITEM EXISTS:" + itemExists);
            if (!itemExists) {
                cartitem.setItemid(id);
                cartitem.setItemqty(1);
                //cartitem = new CartItem(item, 1);
                cartItemList.add(cartitem);
            }
            session.setAttribute("cartItemList", cartItemList);

            response.sendRedirect("cart.jsp");

        } catch (Exception ex) {
            ex.printStackTrace();
            //response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

//    	private int isExisting(String id, List<Item> cartItemList) {
//		for (int i = 0; i < cartItemList.size(); i++) {
//			if (cartItemList.get(i).getProduct().getItemid().equals(id)) {
//				return i;
//			}
//		}
//		return -1;
//	}
}
