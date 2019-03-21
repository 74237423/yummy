package dao.impl;

import dao.OrderDAO;
import model.Orderdetail;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //根据orderid获取订单列表
    @Override
    public List<Orderdetail> getOrderById(String orderid) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Orderdetail f where f.orderid = ?1");
        q.setParameter(1, orderid);
        List<Orderdetail> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //增加订单
    @Override
    public void addOrder(Orderdetail orderdetail) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(orderdetail);
        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
}
