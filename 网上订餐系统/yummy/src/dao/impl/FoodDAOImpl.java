package dao.impl;

import dao.FoodDAO;
import model.Food;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import java.util.List;

public class FoodDAOImpl implements FoodDAO {
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //根据餐厅id获取某餐厅所有食物
    @Override
    public List<Food> getAllFoodByResId(int resId) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Food f where f.restaurantid = ?1");
        q.setParameter(1, resId);
        List<Food> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //根据食物id获取该食物
    @Override
    public Food getFoodByid(int id) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Food u where u.id = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, id);
        Food food = (Food) query.getSingleResult();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return food;
    }
    //新增食物
    @Override
    public void addFood(Food food) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(food);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //更新食物信息
    @Override
    public void update(Food food) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.update(food);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
}
