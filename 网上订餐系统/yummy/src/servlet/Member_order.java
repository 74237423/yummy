package servlet;

import model.Member;
import model.Ordercheck;
import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/memberOrder")
public class Member_order  extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        List<Ordercheck> orderNeedSend = memberService.getNeedSendOrder(member);
        List<Ordercheck> orderSending =memberService.getSendingOrder(member);
        List<Ordercheck> orderArrived =memberService.getOkOrdercheck(member);
        List<Ordercheck> orderAskReturn =memberService.getAskReturn(member);
        List<Ordercheck> orderNeedPay = memberService.getNeedPay(member);
        session.setAttribute("memNeedPay",orderNeedPay);
        session.setAttribute("memNeedSend",orderNeedSend);
        session.setAttribute("memSenting",orderSending);
        session.setAttribute("memArrived",orderArrived);
        session.setAttribute("memAskReturn",orderAskReturn);
        resp.sendRedirect("/pages/member_check/orderDetail2.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        doGet(req,resp);
    }
}
