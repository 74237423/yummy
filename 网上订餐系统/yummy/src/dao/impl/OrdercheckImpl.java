package dao.impl;
import model.*;
import dao.OrdercheckDAO;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class OrdercheckImpl implements OrdercheckDAO {
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //新增账单详细内容
    @Override
    public void addOrdercheck(Ordercheck ordercheck) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(ordercheck);
        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //更新账单信息
    @Override
    public void update(Ordercheck ordercheck) {
//根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.update(ordercheck);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //获取某用户所有订单
    @Override
    public List<Ordercheck> getOrdercheckByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取某用户正在送达订单
    @Override
    public List<Ordercheck> getSendingOrdercheckByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.sent = true and o.arrived = false ");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取某用户已完成订单
    @Override
    public List<Ordercheck> getOkOrdercheckByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.arrived = true and o.paid = true and returned = false ");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取某用户可支付订单
    @Override
    public List<Ordercheck> getNeedPayOrdercheckByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.paid = false ");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //根据id获取账单
    @Override
    public Ordercheck getOrdercheckById(String id) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Ordercheck u where u.id = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, id);
        Ordercheck ordercheck = (Ordercheck) query.getSingleResult();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return ordercheck;
    }
    //获取某餐厅所有订单
    @Override
    public List<Ordercheck> getOrdercheckByRes(int Resid) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1");
        q.setParameter(1, Resid);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取某餐厅正在配送订单
    @Override
    public List<Ordercheck> getSendingByRes(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.sent = true and o.arrived = false ");
        q.setParameter(1, resId);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取餐厅已配送完订单
    @Override
    public List<Ordercheck> getSentByRes(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.arrived = true ");
        q.setParameter(1, resId);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取餐厅已结算订单
    @Override
    public List<Ordercheck> getBalancedByRes(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.balance = true ");
        q.setParameter(1, resId);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取需要结算的订单
    @Override
    public List<Ordercheck> getNeedBalance() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.balance = false and o.paid = true and o.arrived =true and o.returned = false ");
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取所有已经结算的订单
    @Override
    public List<Ordercheck> getBalanced() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.balance = true ");
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }

    //获取餐厅被要求退订订单
    @Override
    public List<Ordercheck> getAskReturnByRes(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.askReturn = true and o.desideRerutn = false ");
        q.setParameter(1, resId);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取餐厅已退订订单
    @Override
    public List<Ordercheck> getReturnByRes(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.returned = true and o.desideRerutn = true ");
        q.setParameter(1, resId);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取顾客已退订订单
    @Override
    public List<Ordercheck> getReturnByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.returned = true and o.desideRerutn = true");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取顾客要求退订订单
    @Override
    public List<Ordercheck> getAskReturnByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.askReturn = true");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取顾客未配送订单
    @Override
    public List<Ordercheck> getNeedSendByMem(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.memberemail = ?1 and o.arrived = false and o.paid = true and o.sent = false and o.askReturn = false ");
        q.setParameter(1, email);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取餐厅需配送订单
    @Override
    public List<Ordercheck> getNeedSendByRes(int resid) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.arrived = false and o.paid = true and o.sent = false and o.askReturn = false ");
        q.setParameter(1, resid);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取餐厅未结算订单
    @Override
    public List<Ordercheck> getNoBalancedByRes(int resid) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.restauranrid = ?1 and o.balance = false and o.arrived = true and o.returned = false and o.paid = true ");
        q.setParameter(1, resid);
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取退订获利订单
    @Override
    public List<Ordercheck> getReturnedEarn() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Ordercheck o where o.sent = true and o.returned = true ");
        List<Ordercheck> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }

    @Override
    public void deleteOrdercheck(Ordercheck ordercheck) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.delete(ordercheck);
        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
}
