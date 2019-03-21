package servlet;

import factory.ModelFactory;
import model.Modifyres;
import model.Restaurant;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/resData")
public class ResData  extends HttpServlet {
    private RestaurantService restaurantService =new RestaurantService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect("/pages/restaurant_check/resData.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
        String typeafter = req.getParameter("restype");
        String desafter = req.getParameter("description");
        Modifyres modifyres = modelFactory.NewModifyes(restaurant.getId(),restaurant.getType(),typeafter,restaurant.getDescription(),desafter);
        restaurantService.modifyResData(modifyres);
        resp.sendRedirect("/pages/success/modifyRes.html");
    }
}
