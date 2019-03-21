package servlet;

import model.Food;
import model.Member;
import model.Restaurant;
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

@WebServlet("/resFood")
public class ResFood  extends HttpServlet {
    private RestaurantService restaurantService= new RestaurantService();
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Restaurant restaurant = (Restaurant) session.getAttribute("enterRes");
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        List<Food> foods = restaurantService.getAllFoodByRes(restaurant.getId());
        session.setAttribute("foodlist",foods);
        resp.sendRedirect("/pages/yummy/resFood.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        resp.sendRedirect("/memberPay");
    }
}
