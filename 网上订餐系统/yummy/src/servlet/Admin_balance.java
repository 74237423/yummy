package servlet;

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
@WebServlet("/adminBalance")
public class Admin_balance  extends HttpServlet {
    private AdminService adminService = new AdminService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        List<Ordercheck> orderchecks = adminService.getNeedBalance();


        session.setAttribute("needBalance",orderchecks);
        resp.sendRedirect("/pages/admin_check/admin_balance.jsp");
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ordercheckid = req.getParameter("balanceOrder");
        Ordercheck ordercheck = adminService.getOrdercheckById(ordercheckid);
        adminService.balance(ordercheck);
        resp.sendRedirect("/pages/success/balance.html");
    }
}
