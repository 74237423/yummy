package servlet;

import service.admin.AdminService;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import model.*;
@WebServlet("/sendOrder")
public class SendOrder extends HttpServlet {
    private RestaurantService restaurantService = new RestaurantService();
    private AdminService adminService = new AdminService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session=req.getSession(false);
        String orderid = req.getParameter("needSendOrderId");
        Ordercheck ordercheck= adminService.getOrdercheckById(orderid);
        restaurantService.sendOrder(ordercheck);
        resp.sendRedirect("/pages/success/sendOrder.html");
    }
}
