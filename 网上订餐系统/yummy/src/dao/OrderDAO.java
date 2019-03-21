package dao;

import model.Orderdetail;

import java.util.List;

public interface OrderDAO {
    //根据ordrerid获取订单列表
    public List<Orderdetail> getOrderById(String orderid);
    //增加订单
    public void addOrder(Orderdetail orderdetail);
}
