package servlet;

import model.Food;
import model.Member;
import model.Orderdetail;
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
import model.*;
@WebServlet("/goPay")
public class goPay extends HttpServlet {
    private MemberService memberService = new MemberService();
    private AdminService adminService = new AdminService();
    private RestaurantService restaurantService = new RestaurantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());

        boolean left = true;
        boolean money =true;

        String orderid=req.getParameter("payId");
        Ordercheck ordercheck = adminService.getOrdercheckById(orderid);
        if(memberService.countMin(ordercheck)>2){
            resp.sendRedirect("/pages/error/timeout.html");
        }else {
            List<Orderdetail> orderdetails = memberService.getOrderContext(ordercheck);
            double total = ordercheck.getTotalprice();

            for (int i=0;i<orderdetails.size();i++){
                Food food = restaurantService.getFoodById(orderdetails.get(i).getFoodid());
                if (food.getQuantity()<orderdetails.get(i).getNum()){
                    left=false;
                    break;
                }
            }
            if (member.getMoney()<total)
                money=false;

            if(money&&left){
                memberService.payOrder(ordercheck);
                member=memberService.getMemberByEmail(member.getEmail());
                session.setAttribute("member",member);
                resp.sendRedirect("/pages/success/pay_success.html");
            }else if(!left){
                resp.sendRedirect("/pages/error/noleft.html");
            }else if(!money){
                resp.sendRedirect("/pages/error/nomoney.html");
            }
        }


    }
}
