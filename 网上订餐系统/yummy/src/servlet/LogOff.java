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

@WebServlet("/logoff")
public class LogOff extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        memberService.logOff(member);
        if (null != session) {
            session.invalidate();
            session = null;
        }
        resp.sendRedirect("/pages/success/logoff.html");
    }
}
