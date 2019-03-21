package servlet;

import model.Member;
import model.Restaurant;
import service.admin.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.*;
@WebServlet(name="Adminhome",urlPatterns={"/adminHome"})
public class Admin_home  extends HttpServlet {
    private AdminService adminService=new AdminService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        List<Member> members = adminService.getAllMember();
        List<Restaurant> restaurants = adminService.getAllRes();
        List<Ordercheck> orderchecks = adminService.getAllBalancedOrder();
        List<Ordercheck> orderchecks1 = adminService.getAllReturnEarn();
        session.setAttribute("memberlist",members);
        session.setAttribute("reslist",restaurants);
        session.setAttribute("balabcedlist",orderchecks);
        session.setAttribute("returnlist",orderchecks1);
        resp.sendRedirect("/pages/home/admin_home.jsp");
    }
}
