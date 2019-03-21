package service.member;

import dao.FoodDAO;
import dao.MemberDAO;
import dao.OrderDAO;
import dao.OrdercheckDAO;
import dao.impl.FoodDAOImpl;
import dao.impl.MemberDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.OrdercheckImpl;
import model.*;
import util.MathUtil;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MemberService {
    private MemberDAO memberDAO = new MemberDAOImpl();
    private OrdercheckDAO ordercheckDAO = new OrdercheckImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private FoodDAO foodDAO= new FoodDAOImpl();
    //根据email获取该用户
    public Member getMemberByEmail(String email){
        return memberDAO.getMemberByEmail(email);
    }
    /**
     * 激活用户
     * @param code 用户激活码
     * @return 是否激活成功
     */
    public Boolean Active(String email,String code){
        Member member = memberDAO.getMemberByEmail(email);
        if(member!=null && member.getCode().equals(code)){
            //如果存在用户，将此用户状态设为可用
            member.setActived(true);
            memberDAO.updateMember(member);
            return true;
        }else{
            return false;
        }
    }
    //登录
    public boolean login(String email,String ps){
        Member member = memberDAO.getMemberByEmail(email);
        if(member == null)
            return false;
        if((!member.getLogoff()) && member.getPassword().equals(ps) && member.getActived())
            return true;
        return false;
    }
    //注销
    public void logOff(Member member){
        member.setLogoff(true);
        memberDAO.updateMember(member);
    }
    //修改用户信息
    public void updateMemData(Member member){
        memberDAO.updateMember(member);
    }
    //注册
    public boolean register(Member member){
        if(memberDAO.getMemberByEmail(member.getEmail())!=null)
            return false;
        else {
            memberDAO.addNewMember(member);
            return true;
        }
    }

    //支付账单
    public void payOrder(Ordercheck ordercheck){
        Member member = memberDAO.getMemberByEmail(ordercheck.getMemberemail());
        double totalPay = member.getTotal()+ordercheck.getTotalprice();
        double money = member.getMoney()-ordercheck.getTotalprice();
        MathUtil mathUtil =new MathUtil();
        member.setMoney(mathUtil.twoDouble(money));
        member.setTotal(mathUtil.twoDouble(totalPay));
        if(totalPay>100)
            member.setViplevel(3);
        else if (totalPay>50 &&totalPay<=100)
            member.setViplevel(2);
        else if(totalPay<=50)
            member.setViplevel(1);
        ordercheck.setPaid(true);
        updateQuantity(ordercheck);
        memberDAO.updateMember(member);
        ordercheckDAO.update(ordercheck);
    }
    //更新库存
    private void updateQuantity(Ordercheck ordercheck){
        List<Orderdetail> orderdetails = getOrderContext(ordercheck);
        for (int i=0;i<orderdetails.size();i++){
            int num = orderdetails.get(i).getNum();
            Food food = foodDAO.getFoodByid(orderdetails.get(i).getFoodid());
            food.setQuantity(food.getQuantity()-num);
            foodDAO.update(food);
        }
    }
    //获取可以支付的账单
    public List<Ordercheck> getNeedPay(Member member){
        List<Ordercheck> orderchecks= ordercheckDAO.getNeedPayOrdercheckByMem(member.getEmail());
        ArrayList<Ordercheck> orderchecks1 = new ArrayList<Ordercheck>();
        for (int i=0;i<orderchecks.size();i++){
            if (countMin(orderchecks.get(i))>2&& !orderchecks.get(i).getPaid()){
                ordercheckDAO.deleteOrdercheck(orderchecks.get(i));
            }else {
                orderchecks1.add(orderchecks.get(i));
            }
        }
        return orderchecks1;
    }
    //取消订单
    public void cancleOrder(Ordercheck ordercheck){
        ordercheckDAO.deleteOrdercheck(ordercheck);
    }
    //要求退订账单
    public void askReturn(Ordercheck ordercheck){
        ordercheck.setAskReturn(true);
        ordercheck.setDesideRerutn(false);
        ordercheckDAO.update(ordercheck);
    }
    //计算账单生成据现在的时间(minutes)
    public long countMin(Ordercheck ordercheck){
        Timestamp ts = ordercheck.getDatetime();
        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String tsStr = sdf.format(ts);
        long minutes = 0;
        try {
            Date date1 = sdf.parse(currTime());
            Date date2 = sdf.parse(tsStr);
            long diff = date1.getTime() - date2.getTime();
            //System.out.println("毫秒数：" + diff);
            //计算两个时间之间差了多少分钟
            minutes = diff / (1000 * 60);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return minutes;
    }
    /**
     * 得到当前时间	yyyy-MM-dd HH:mm:ss格式
     * @return	当前时间
     */
    private static String currTime() throws Exception{
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();

        return df.format(date);
    }


    //确认送达
    public void arrived(Ordercheck ordercheck){
        ordercheck.setArrived(true);
        ordercheckDAO.update(ordercheck);
    }
    //获取已完成账单
    public List<Ordercheck> getOkOrdercheck(Member member){
        return ordercheckDAO.getOkOrdercheckByMem(member.getEmail());
    }
    //获取正在配送账单
    public List<Ordercheck> getSendingOrder(Member member){
        return ordercheckDAO.getSendingOrdercheckByMem(member.getEmail());
    }
    //获取未配送的订单
    public List<Ordercheck> getNeedSendOrder(Member member){
        return ordercheckDAO.getNeedSendByMem(member.getEmail());
    }
    //判断退款订单状态
    public String stateOfReturnOrder(Ordercheck ordercheck){
        MathUtil mathUtil = new MathUtil();
        if(ordercheck.getAskReturn()){
            if(ordercheck.getDesideRerutn()){
                if(ordercheck.getReturned()){
                    if(ordercheck.getSent()){
                        return "退款90%:"+mathUtil.twoDouble(ordercheck.getTotalprice()*0.9)+"元";
                    }
                    return "全额退款:"+mathUtil.twoDouble(ordercheck.getTotalprice())+"元";
                }
                return "商家拒绝退款！";
            }
            return "商家未审批退款请求！";
        }
        return "没有要求退款！";
    }
    //获取某账单所点内容
    public List<Orderdetail> getOrderContext(Ordercheck ordercheck){
        return orderDAO.getOrderById(ordercheck.getOrderid());
    }
    //获取退订记录
    public List<Ordercheck> getReturnedOrder(Member member){
        return ordercheckDAO.getReturnByMem(member.getEmail());
    }
    //获取要求退订中的记录
    public List<Ordercheck> getAskReturn(Member member){
        return ordercheckDAO.getAskReturnByMem(member.getEmail());
    }
    //获取未配送订单
    public List<Ordercheck> getPaidOrder(Member member){
        return ordercheckDAO.getNeedSendByMem(member.getEmail());
    }
}
