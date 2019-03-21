package servlet;

import model.Restaurant;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.*;
@WebServlet("/resOrder")
public class ResOrder extends HttpServlet {
    private RestaurantService restaurantService =new RestaurantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
        List<Ordercheck> orderNeedSend = restaurantService.getNeedSend(restaurant);
        List<Ordercheck> orderSending = restaurantService.getSending(restaurant);
        List<Ordercheck> orderArrived = restaurantService.getArrived(restaurant);
        List<Ordercheck> orderAskReturn = restaurantService.getAskReturn(restaurant);
        List<Ordercheck> orderReturned = restaurantService.getReturned(restaurant);
        session.setAttribute("resNeedSend",orderNeedSend);
        session.setAttribute("resSenting",orderSending);
        session.setAttribute("resArrived",orderArrived);
        session.setAttribute("resAskReturn",orderAskReturn);
        session.setAttribute("resReturned",orderReturned);
        resp.sendRedirect("/pages/restaurant_check/orderDetail2.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    }
}
