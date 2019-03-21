package servlet;

import model.Member;
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
import model.*;
@WebServlet("/memSum")
public class memSum extends HttpServlet {
    private RestaurantService restaurantService = new RestaurantService();
    private MemberService memberService = new MemberService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        List<Ordercheck> arrivedOrder = memberService.getOkOrdercheck(member);
        session.setAttribute("memArrived",arrivedOrder);
        List<Ordercheck> returnedOrder = memberService.getReturnedOrder(member);
        session.setAttribute("memReturned",returnedOrder);
        resp.sendRedirect("/pages/member_check/mem_summer.jsp");

    }
}
