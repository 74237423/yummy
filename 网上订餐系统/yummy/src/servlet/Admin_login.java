package servlet;

import service.admin.AdminService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/adminLogin")
public class Admin_login extends HttpServlet {
    private AdminService adminService = new AdminService();
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


        context.getRequestDispatcher("/pages/login/admin_login.html").forward(req, resp);

        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext context = getServletContext();
            HttpSession session = req.getSession(true);
            if (req.getParameter("username") != null) {
                int username = Integer.parseInt(req.getParameter("username"));
                String password = req.getParameter("password");
                if (adminService.login(username,password)) {
                    session.setAttribute("username", username);
                    session.setAttribute("password", password);
                    String loginValue = req.getParameter("username");
                    boolean isLoginAction = (null == loginValue)? false:true;
                    if(isLoginAction){
                        session = req.getSession(true);
                        session.setAttribute("username",loginValue);
                        req.setAttribute("username",loginValue);}
                    resp.sendRedirect("/adminHome");
                } else {
                    context.getRequestDispatcher("/pages/error/login_error.html").forward(req, resp);
                }
            }
        }

}

