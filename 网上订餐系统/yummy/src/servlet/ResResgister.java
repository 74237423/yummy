package servlet;

import factory.ModelFactory;
import model.Restaurant;
import service.restaurant.RestaurantService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static servlet.RegisterServlet.sendMail;

@WebServlet(name="ResRegister",urlPatterns={"/resRegister"})
public class ResResgister extends HttpServlet {
    private RestaurantService restaurantService = new RestaurantService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ServletContext context = getServletContext();
        context.getRequestDispatcher("/pages/register/res_register.html").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username=req.getParameter("username");//餐厅名
        String password=req.getParameter("password");
        String type = req.getParameter("type");
        String des = req.getParameter("description");
        Restaurant restaurant = modelFactory.NewRes(username,type,password,des);
        restaurantService.register(restaurant);
        HttpSession session = req.getSession(true);
        session.setAttribute("resid",restaurant.getId());
        resp.sendRedirect("/pages/success/resResgister.jsp");


    }

}
