package servlet;

import factory.ModelFactory;

import model.Member;
import service.member.MemberService;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

@WebServlet(name="MemberRegister",urlPatterns={"/memberRegister"})
public class RegisterServlet extends HttpServlet {
    private MemberService memberService =new MemberService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ServletContext context = getServletContext();
        context.getRequestDispatcher("/pages/register/member_register.html").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String email=req.getParameter("email");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        Member member = modelFactory.NewMember(email,username,address,phone,password);
        if (memberService.register(member)){
            //向用户发送激活邮件
            sendMail(email,member.getCode());
            resp.sendRedirect("/pages/success/registersuccess.html");
        }else {
            resp.sendRedirect("/pages/error/register_error.html");
        }


    }
    /**
     * 发送激活右键
     * @param to 收件人邮箱地址
     * @param code 激活码
     */
    public static boolean sendMail(String to, String code) {

        try {
            Properties props = new Properties();
            props.put("username", "mtzq_peng@163.com");
            props.put("password", "mtzqpeng163com");
            props.put("mail.transport.protocol", "smtp" );
            props.put("mail.smtp.host", "smtp.163.com");
            props.put("mail.smtp.port", "25" );

            Session mailSession = Session.getDefaultInstance(props);

            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress("mtzq_peng@163.com"));
            msg.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject("激活邮件,请点击链接激活账号");
            msg.setContent("<h1>此邮件为官方激活邮件！请点击下面链接完成激活操作！</h1><h3><a href='http://127.0.0.1:8080/ActiveServlet?email="+to+"&code="+code+"'>http://127.0.0.1:8080/ActiveServlet</a></h3>","text/html;charset=UTF-8");
            msg.saveChanges();

            Transport transport = mailSession.getTransport("smtp");
            transport.connect(props.getProperty("mail.smtp.host"), props
                    .getProperty("username"), props.getProperty("password"));
            transport.sendMessage(msg, msg.getAllRecipients());
            transport.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            return false;
        }
        return true;
    }


}

