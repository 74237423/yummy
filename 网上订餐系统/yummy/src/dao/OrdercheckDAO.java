package dao;

import model.*;

import java.util.List;

public interface OrdercheckDAO {
    //新增账单详细内容
    public void addOrdercheck(Ordercheck ordercheck);
    //更新账单信息
    public void update(Ordercheck ordercheck);
    //获取某用户所有订单
    public List<Ordercheck> getOrdercheckByMem(String email);
    //获取某用户正在送达订单
    public List<Ordercheck> getSendingOrdercheckByMem(String email);
    //获取某用户已完成订单
    public List<Ordercheck> getOkOrdercheckByMem(String email);
    //获取某用户可支付订单
    public List<Ordercheck> getNeedPayOrdercheckByMem(String email);
    //根据id获取账单
    public Ordercheck getOrdercheckById(String id);
    //获取某餐厅所有订单
    public  List<Ordercheck> getOrdercheckByRes(int Resid);
    //获取某餐厅正在配送订单
    public List<Ordercheck> getSendingByRes(int resId);
    //获取餐厅已配送完订单
    public List<Ordercheck> getSentByRes(int resId);
    //获取餐厅已结算订单
    public List<Ordercheck> getBalancedByRes(int resId);
    //获取需要结算的订单
    public List<Ordercheck> getNeedBalance();
    //获取所有已经结算的订单
    public List<Ordercheck> getBalanced();
    //获取餐厅被要求退订订单
    public List<Ordercheck> getAskReturnByRes(int resId);
    //获取餐厅已退订订单
    public List<Ordercheck> getReturnByRes(int resId);
    //获取顾客已退订订单
    public List<Ordercheck> getReturnByMem(String email);
    //获取顾客要求退订订单
    public List<Ordercheck> getAskReturnByMem(String email);
    //获取顾客未配送订单
    public List<Ordercheck> getNeedSendByMem(String email);
    //获取餐厅需配送订单
    public List<Ordercheck> getNeedSendByRes(int resid);
    //获取餐厅未结算订单
    public List<Ordercheck> getNoBalancedByRes(int resid);
    //获取退订获利订单
    public List<Ordercheck> getReturnedEarn();
    //删除订单
    public void deleteOrdercheck(Ordercheck ordercheck);
}
