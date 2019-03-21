package servlet;

import model.Member;
import model.Restaurant;
import service.admin.AdminService;
import service.member.MemberService;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/memberFindRes")
public class Member_findRes  extends HttpServlet {
    private MemberService memberService = new MemberService();
    private AdminService adminService = new AdminService();
    private RestaurantService restaurantService = new RestaurantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        List<Restaurant> restaurants = adminService.getAllRes();
        session.setAttribute("restaurantlist",restaurants);
        resp.sendRedirect("/pages/member_check/findRes.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        int resId = Integer.parseInt(req.getParameter("getRes"));
        Restaurant restaurant = restaurantService.getResById(resId);
        session.setAttribute("enterRes",restaurant);
        resp.sendRedirect("/resFood");
    }
}
