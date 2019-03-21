package dao.impl;

import dao.AdminDAO;
import model.Admin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class AdminDAOImpl implements AdminDAO {


    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    @Override
    public Admin getAdminById(int id) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();
        String hql = "from Admin u where u.id = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, id);
        Admin admin = (Admin) query.getSingleResult();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return admin;
    }
}
