package service.admin;

import dao.*;
import dao.impl.*;
import model.*;
import util.MathUtil;

import java.util.List;

public class AdminService {
    private AdminDAO adminDAO = new AdminDAOImpl();
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
    private ModifyresDAO modifyresDAO = new ModifyresDAOImpl();
    private OrdercheckDAO ordercheckDAO = new OrdercheckImpl();
    private MemberDAO memberDAO = new MemberDAOImpl();
    //管理员登录方法
    public boolean login(int id,String password){
        Admin admin = adminDAO.getAdminById(id);

        if(admin == null)
            return false;
        System.out.println(admin.getPassword());
        return admin.getPassword().equals(password);
    }
    //获取需要审批的申请
    public List<Modifyres> getNeedPass(){
        return modifyresDAO.getCheckM();
    }
    //审批拒绝
    public void disagressModify(int modifyid){
        Modifyres modifyres = modifyresDAO.getModifyById(modifyid);
        modifyres.setIscheck(true);
        modifyres.setAggree(false);
        modifyresDAO.update(modifyres);
    }
    //管理员审批同意各餐厅修改信息的申请
    public void agreeModify(int modifyid){
        Modifyres modifyres = modifyresDAO.getModifyById(modifyid);
        modifyres.setIscheck(true);
        modifyres.setAggree(true);
        modifyresDAO.update(modifyres);
        Restaurant r = restaurantDAO.getResById(modifyres.getResid());
        r.setDescription(modifyres.getDesafter());
        r.setType(modifyres.getTypeafter());
        restaurantDAO.updateRes(r);

    }
    //获取所有需要结算的账单
    public List<Ordercheck> getNeedBalance(){
        return ordercheckDAO.getNeedBalance();
    }
    //结算
    public void balance(Ordercheck ordercheck){
        ordercheck.setBalance(true);
        ordercheckDAO.update(ordercheck);
        MathUtil mathUtil = new MathUtil();
        double balance = mathUtil.twoDouble(ordercheck.getTotalprice() - ordercheck.getEarn());
        Restaurant restaurant = restaurantDAO.getResById(ordercheck.getRestauranrid());
        restaurant.setIncome(mathUtil.twoDouble(restaurant.getIncome()+balance));
        restaurantDAO.updateRes(restaurant);

    }
    //查看统计信息餐厅统计
    public List<Restaurant> getAllRes(){
        return restaurantDAO.getAllRes();
    }
    //会员统计
    public List<Member> getAllMember(){
        return memberDAO.getAllMember();
    }
    //Yummy！财务情况 总获利
    public double getEarn(){
        double num = 0;
        List<Ordercheck> list = ordercheckDAO.getBalanced();
        List<Ordercheck> list2 = ordercheckDAO.getReturnedEarn();
        for (int i = 0;i<list.size();i++){
            num += list.get(i).getEarn();
        }
        for (int i = 0;i<list2.size();i++){
            num += list.get(i).getEarn();
        }
        return num;
    }
    //获取所有结算账单
    public List<Ordercheck> getAllBalancedOrder(){
        return ordercheckDAO.getBalanced();
    }
    //获取所有退订获利订单
    public List<Ordercheck> getAllReturnEarn(){
        return ordercheckDAO.getReturnedEarn();
    }
    //根据ordercheck id 获取该对象
    public Ordercheck getOrdercheckById(String ordercheckid){
        return ordercheckDAO.getOrdercheckById(ordercheckid);
    }
}
