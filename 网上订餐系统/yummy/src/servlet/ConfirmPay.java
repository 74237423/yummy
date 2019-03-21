package servlet;

import model.*;

import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/confirmPay")
public class ConfirmPay extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect("/pages/yummy/confirmPay.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Ordercheck ordercheck = (Ordercheck) session.getAttribute("order");
        boolean left = true;
        boolean money =true;
        List<Food> foodList = (List<Food>) session.getAttribute("askfoodlist");
        List<Integer> num = (List<Integer>) session.getAttribute("asknum");
        double total = (double) session.getAttribute("payMoney");
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        for (int i=0;i<foodList.size();i++){
            if(num.get(i)>foodList.get(i).getQuantity()){
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
