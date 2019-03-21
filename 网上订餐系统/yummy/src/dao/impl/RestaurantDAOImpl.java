package dao.impl;

import dao.RestaurantDAO;
import model.Restaurant;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO{
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //增加新餐厅
    @Override
    public void addNewRes(Restaurant restaurant) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(restaurant);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //更新餐厅信息
    @Override
    public void updateRes(Restaurant restaurant) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.update(restaurant);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //获取所有餐厅
    @Override
    public List<Restaurant> getAllRes() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Restaurant ");
        List<Restaurant> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //根据id查找餐厅
    @Override
    public Restaurant getResById(int id) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Restaurant u where u.id = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, id);
        Restaurant restaurant = (Restaurant) query.getSingleResult();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return restaurant;
    }

    @Override
    public Restaurant getResByName(String name) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Restaurant u where u.name = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, name);
        Restaurant restaurant = (Restaurant) query.getSingleResult();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return restaurant;
    }
}
