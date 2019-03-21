package servlet;

import factory.ModelFactory;
import model.Food;
import model.Restaurant;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/addFood")
public class AddFood  extends HttpServlet {
    private RestaurantService restaurantService =new RestaurantService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("/pages/restaurant_check/newFood.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
        String foodname = req.getParameter("foodname");
        String type= req.getParameter("foodtype");
        String des = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("foodprice"));
        int left = Integer.parseInt(req.getParameter("left"));
        Food food = modelFactory.NewFood(foodname,restaurant.getId(),price,left,des,type);
        restaurantService.addFood(food);
        resp.sendRedirect("/pages/success/addFood_success.html");

    }
}
