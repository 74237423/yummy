package service.restaurant;

import dao.*;
import dao.impl.*;
import model.*;
import util.MathUtil;

import java.util.List;

public class RestaurantService {
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrdercheckDAO ordercheckDAO = new OrdercheckImpl();
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
    private FoodDAO foodDAO = new FoodDAOImpl();
    private ModifyresDAO modifyresDAO = new ModifyresDAOImpl();
    private MemberDAO memberDAO = new MemberDAOImpl();
    //确认配送
    public void sendOrder(Ordercheck ordercheck){
        ordercheck.setSent(true);
        List<Orderdetail> orderdetailList = orderDAO.getOrderById(ordercheck.getOrderid());
        for (int i = 0; i< orderdetailList.size(); i++){
            Food food = getFoodById(orderdetailList.get(i).getFoodid());
            food.setQuantity(food.getQuantity()- orderdetailList.get(i).getNum());
            foodDAO.update(food);
        }
        ordercheckDAO.update(ordercheck);
    }
    //根据resid获取餐厅
    public Restaurant getResById(int id){
        return restaurantDAO.getResById(id);
    }
    //登录
    public boolean login(int id,String ps){
        Restaurant restaurant = restaurantDAO.getResById(id);
        if(restaurant == null)
            return false;
        if (restaurant.getPassword().equals(ps))
            return true;
        return false;
    }
    //注册
    public void register(Restaurant restaurant){
        restaurantDAO.addNewRes(restaurant);
    }
    //新增食物
    public void addFood(Food food){
        foodDAO.addFood(food);
    }
    //更新食物
    public void updateFood(Food food){
        foodDAO.update(food);
    }
    //修改注册信息
    public void modifyResData(Modifyres modifyres){
        modifyresDAO.addModify(modifyres);
    }
    //获取需要退订订单
    public List<Ordercheck> getAskReturn(Restaurant restaurant){
        return ordercheckDAO.getAskReturnByRes(restaurant.getId());
    }
    //获取已经退订订单
    public List<Ordercheck> getReturned(Restaurant restaurant){
        return ordercheckDAO.getReturnByRes(restaurant.getId());
    }
    //获取需要配送订单
    public List<Ordercheck> getNeedSend(Restaurant restaurant){
        return ordercheckDAO.getNeedSendByRes(restaurant.getId());
    }
    //获取配送中订单
    public List<Ordercheck> getSending(Restaurant restaurant){
        return ordercheckDAO.getSendingByRes(restaurant.getId());
    }
    //获取已到达订单
    public List<Ordercheck> getArrived(Restaurant restaurant){
        return ordercheckDAO.getSentByRes(restaurant.getId());
    }
    //获取已结算订单
    public List<Ordercheck> getBalanced(Restaurant restaurant){
        return ordercheckDAO.getBalancedByRes(restaurant.getId());
    }
    //获取餐厅未结算订单
    public List<Ordercheck> getNoBalanced(Restaurant restaurant){
        return ordercheckDAO.getNoBalancedByRes(restaurant.getId());
    }
    //获取某账单所点内容
    public List<Orderdetail> getOrderContext(Ordercheck ordercheck){
        return orderDAO.getOrderById(ordercheck.getOrderid());
    }

    //同意退款
    public void passReturn(Ordercheck ordercheck){
        ordercheck.setDesideRerutn(true);
        ordercheck.setReturned(true);
        ordercheckDAO.update(ordercheck);
        Member member = memberDAO.getMemberByEmail(ordercheck.getMemberemail());

        MathUtil mathUtil=new MathUtil();
        if(!ordercheck.getSent() && ordercheck.getPaid()){//未配送时要求退款退全额
            member.setMoney(mathUtil.twoDouble(member.getMoney()+ordercheck.getTotalprice()));
            member.setTotal(mathUtil.twoDouble(member.getTotal()-ordercheck.getTotalprice()));
        }else {//配送后的退款只得0.9*原价
            member.setMoney(mathUtil.twoDouble(member.getMoney()+mathUtil.twoDouble(ordercheck.getTotalprice()*0.9)));
            member.setTotal(mathUtil.twoDouble(member.getTotal()-mathUtil.twoDouble(ordercheck.getTotalprice()*0.9)));
        }
        double totalPay = member.getTotal();
        if(totalPay>100)
            member.setViplevel(3);
        else if (totalPay>50 &&totalPay<=100)
            member.setViplevel(2);
        else if(totalPay<=50)
            member.setViplevel(1);
        memberDAO.updateMember(member);
    }
    //拒绝退款
    public void unpassReturn(Ordercheck ordercheck){
        ordercheck.setDesideRerutn(true);
        ordercheck.setReturned(false);
        ordercheckDAO.update(ordercheck);

    }
    //获取该餐厅所有食物
    public List<Food> getAllFoodByRes(int resid){
        return foodDAO.getAllFoodByResId(resid);
    }
    //根据foodid查找food
    public Food getFoodById(int id){
        return foodDAO.getFoodByid(id);
    }
    //新ordercheck
    public void addOrdercheck(Ordercheck ordercheck){
        ordercheckDAO.addOrdercheck(ordercheck);
    }
    //新order
    public void addOrder(Orderdetail orderdetail){
        orderDAO.addOrder(orderdetail);
    }

}
