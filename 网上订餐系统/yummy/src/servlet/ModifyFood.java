package servlet;

import factory.ModelFactory;
import model.Food;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/modifyFood")
public class ModifyFood  extends HttpServlet {
    private RestaurantService restaurantService =new RestaurantService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int foodid = Integer.parseInt(req.getParameter("foodid"));
        Food food = restaurantService.getFoodById(foodid);
        HttpSession session=req.getSession(false);
        session.setAttribute("modifyfood",food);
        resp.sendRedirect("/pages/restaurant_check/modifyFood.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session=req.getSession(false);
        String foodname = req.getParameter("foodname");
        String type= req.getParameter("foodtype");
        String des = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("foodprice"));
        int left = Integer.parseInt(req.getParameter("left"));
        Food food = (Food) session.getAttribute("modifyfood");
        food.setType(type);
        food.setName(foodname);
        food.setDescription(des);
        food.setQuantity(left);
        food.setPrice(price);
        restaurantService.updateFood(food);
        resp.sendRedirect("/pages/success/modifyFood_success.html");
    }
}
