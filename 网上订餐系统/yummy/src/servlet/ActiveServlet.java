package servlet;

import service.member.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="MemberActive",urlPatterns={"/ActiveServlet"})
public class ActiveServlet extends HttpServlet {
    private MemberService memberService = new MemberService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String code=req.getParameter("code");
        String email = req.getParameter("email");
        if(memberService.Active(email,code)){
            //激活成功后，转发到成功界面
            req.getRequestDispatcher("/pages/success/activesuccess.html").forward(req,resp);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req,resp);
    }
}
