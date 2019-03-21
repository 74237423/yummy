package servlet;

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

@WebServlet(name="ResLogin",urlPatterns={"/resLogin"})
public class ResLogin extends HttpServlet {
    private RestaurantService restaurantService = new RestaurantService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int resid = Integer.parseInt(req.getParameter("resid"));
        String ps = req.getParameter("password");
        ServletContext context = getServletContext();
        HttpSession session = req.getSession(true);
        if(restaurantService.login(resid,ps)){
            Restaurant restaurant = restaurantService.getResById(resid);
            session.setAttribute("restaurant",restaurant);
            resp.sendRedirect("/resData");
        }else {
            context.getRequestDispatcher("/pages/error/login_error.html").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        ServletContext context = getServletContext();
        if (null != req.getParameter("logout")) {

            if (null != session) {
                session.invalidate();
                session = null;
            }
        }


        context.getRequestDispatcher("/pages/login/res_login.html").forward(req, resp);

    }
}
