package servlet;

import service.admin.AdminService;
import service.member.MemberService;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/arrivedOrder")
public class ArrivedOrder extends HttpServlet {
    private AdminService adminService = new AdminService();
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        String orderid = req.getParameter("arrivedId");
        Ordercheck ordercheck= adminService.getOrdercheckById(orderid);
        memberService.arrived(ordercheck);
        resp.sendRedirect("/pages/success/arrived.html");
    }
}
