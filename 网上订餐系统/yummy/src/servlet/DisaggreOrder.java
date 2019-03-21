package servlet;

import model.Ordercheck;
import service.admin.AdminService;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/disaggreeReturn")
public class DisaggreOrder extends HttpServlet {
    private AdminService adminService=new AdminService();
    private RestaurantService restaurantService = new RestaurantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        String orderid = req.getParameter("disaggreeReturnOrderId");
        Ordercheck ordercheck= adminService.getOrdercheckById(orderid);
        restaurantService.unpassReturn(ordercheck);
        resp.sendRedirect("/pages/success/unpassReturn.html");
    }
}
