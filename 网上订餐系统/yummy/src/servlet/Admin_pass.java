package servlet;


import model.Modifyres;
import service.admin.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminPass")
public class Admin_pass  extends HttpServlet {
    private AdminService adminService = new AdminService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);

        List<Modifyres> modifyresList = adminService.getNeedPass();
        session.setAttribute("modifyresList",modifyresList);
        resp.sendRedirect("/pages/admin_check/admin_pass.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int modifyid = Integer.parseInt(req.getParameter("passModify"));
        adminService.agreeModify(modifyid);
        resp.sendRedirect("/pages/success/passModify.html");
    }
}
