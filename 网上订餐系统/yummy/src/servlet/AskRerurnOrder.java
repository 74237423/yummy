package servlet;

import service.admin.AdminService;
import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.*;
@WebServlet("/askReturn")
public class AskRerurnOrder extends HttpServlet {
    private AdminService adminService = new AdminService();
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        String orderid = req.getParameter("askReturnId");
        Ordercheck ordercheck= adminService.getOrdercheckById(orderid);
        memberService.askReturn(ordercheck);
        resp.sendRedirect("/pages/success/askReturn.html");
    }
}
