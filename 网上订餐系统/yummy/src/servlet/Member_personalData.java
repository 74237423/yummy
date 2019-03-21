package servlet;

import model.Member;
import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/memberPersonalData")
public class Member_personalData  extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        resp.sendRedirect("/pages/member_check/personalData.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    }
}
