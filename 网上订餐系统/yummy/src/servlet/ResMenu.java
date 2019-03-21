package servlet;

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
import java.util.List;

@WebServlet("/resMenu")
public class ResMenu extends HttpServlet {
    private RestaurantService restaurantService =new RestaurantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Restaurant restaurant =(Restaurant) session.getAttribute("restaurant");
        List<Food> foodList = restaurantService.getAllFoodByRes(restaurant.getId());
        session.setAttribute("menuFood",foodList);
        resp.sendRedirect("/pages/restaurant_check/menu.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    }
}
