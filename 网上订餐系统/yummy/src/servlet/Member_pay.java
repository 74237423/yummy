package servlet;

import factory.ModelFactory;
import model.*;
import service.member.MemberService;
import service.restaurant.RestaurantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/memberPay")
public class Member_pay  extends HttpServlet {
    private MemberService memberService = new MemberService();
    private RestaurantService restaurantService = new RestaurantService();
    private ModelFactory modelFactory = new ModelFactory();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        String[] foodid = req.getParameterValues("foodid");
        String[] number = req.getParameterValues("number");

        ArrayList<Food> foodList = new ArrayList<Food>();
        ArrayList<Integer> num = new ArrayList<Integer>();
        for (int i=0;i<foodid.length;i++){
            Food food = restaurantService.getFoodById(Integer.parseInt(foodid[i]));
            foodList.add(food);
            num.add(Integer.parseInt(number[i]));
        }
        session.setAttribute("askfoodlist",foodList);
        session.setAttribute("asknum",num);
        boolean canPay = true;
        String message = "";
        for (int i=0;i<foodid.length;i++){
            int left = restaurantService.getFoodById(Integer.parseInt(foodid[i])).getQuantity();
            if(Integer.parseInt(number[i])>left){
                canPay = false;
                message = "库存不足！";
            }
        }
        int level = member.getViplevel();
        double total = 0;

        for (int i=0;i<foodid.length;i++){
            Food food = restaurantService.getFoodById(Integer.parseInt(foodid[i]));
            total += food.getPrice()*Integer.parseInt(number[i]);
        }
        if(level==3)
            total = total*0.8;
        else if (level==2)
            total = total*0.9;
        if (total>50)
            total = total-3;
        if(total>member.getMoney()){
            canPay = false;
            message = "余额不足！";
        }
        session.setAttribute("payMessage",message);
        session.setAttribute("canPay",canPay);

        resp.sendRedirect("/pages/yummy/pay.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session=req.getSession(false);
        Member member = (Member) session.getAttribute("member");
        Restaurant restaurant = (Restaurant) session.getAttribute("enterRes");
        List<Food> foodList = (List<Food>) session.getAttribute("askfoodlist");
        List<Integer> num = (List<Integer>) session.getAttribute("asknum");
        String sendtime=req.getParameter("sendtime").replace("T"," ");
        double payMoney = (double) session.getAttribute("payMoney");
        Ordercheck ordercheck = modelFactory.NewOrdercheck(member.getEmail(),restaurant.getId(),payMoney,sendtime);

        restaurantService.addOrdercheck(ordercheck);
        for (int i=0;i<foodList.size();i++){
            Orderdetail orderdetail = modelFactory.NewOrder(foodList.get(i).getId(),num.get(i),ordercheck.getOrderid());
            restaurantService.addOrder(orderdetail);
        }
        session.setAttribute("order",ordercheck);
        //memberService.payOrder(ordercheck);
        member=memberService.getMemberByEmail(member.getEmail());
        session.setAttribute("member",member);
        resp.sendRedirect("pages/yummy/confirmPay.jsp");
    }
}
