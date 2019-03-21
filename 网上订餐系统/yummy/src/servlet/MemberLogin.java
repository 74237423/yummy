package servlet;

import model.Member;
import service.member.MemberService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="MemberLogin",urlPatterns={"/memberLogin"})
public class MemberLogin extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        ServletContext context = getServletContext();
        HttpSession session = req.getSession(true);
        if (email != null) {
            if (memberService.login(email, password)) {
                Member member = memberService.getMemberByEmail(email);
                session.setAttribute("member", member);
                session.setAttribute("email", email);
                String loginValue = req.getParameter("email");
                boolean isLoginAction = (null == loginValue) ? false : true;
                if (isLoginAction) {
                    session = req.getSession(true);
                    session.setAttribute("email", loginValue);
                    req.setAttribute("email", loginValue);
                }
                resp.sendRedirect("/memberFindRes");
            } else {
                context.getRequestDispatcher("/pages/error/login_error.html").forward(req, resp);
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        ServletContext context = getServletContext();
        if (null != req.getParameter("logout")) {

            if (null != session) {
                session.invalidate();
                session = null;
            }
        }


        context.getRequestDispatcher("/pages/login/member_login.html").forward(req, resp);

    }
}
