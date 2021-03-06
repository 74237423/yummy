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

@WebServlet("/memberModifyData")
public class Member_modifyData  extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        String name= req.getParameter("name");
        String ps = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        member.setPhone(phone);
        member.setName(name);
        member.setPassword(ps);
        member.setAddress(address);
        memberService.updateMemData(member);
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        resp.sendRedirect("/pages/success/modifyMem.html");

    }
}
