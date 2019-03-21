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

@WebServlet("/canclePay")
public class canclePay extends HttpServlet {
    private MemberService memberService = new MemberService();
    private AdminService adminService = new AdminService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {}
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //HttpSession session=req.getSession(false);

        String orderid= req.getParameter("cancleId");
        Ordercheck ordercheck = adminService.getOrdercheckById(orderid);
        memberService.cancleOrder(ordercheck);
        resp.sendRedirect("/pages/success/canclePay.html");
    }

}
