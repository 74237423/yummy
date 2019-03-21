package dao.impl;

import dao.ModifyresDAO;
import model.Modifyres;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;

public class ModifyresDAOImpl implements ModifyresDAO {
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //新增修改要求
    @Override
    public void addModify(Modifyres modifyres) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(modifyres);
        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

    }
    //更新修改要求
    @Override
    public void update(Modifyres modifyres) {
//根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.update(modifyres);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //获取所有修改要求
    @Override
    public List<Modifyres> getAllM() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Modifyres ");
        List<Modifyres> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取需审批的修改要求
    @Override
    public List<Modifyres> getCheckM() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Modifyres m where m.ischeck = false ");
        List<Modifyres> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
    //获取已审批的修改要求
    @Override
    public List<Modifyres> getOkM() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Modifyres m where m.ischeck = true ");
        List<Modifyres> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }

    @Override
    public Modifyres getModifyById(int id) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Modifyres u where u.id = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, id);
        List<Modifyres> list = query.list();
        Modifyres modifyres = new Modifyres();
        if (list.size()>0)
            modifyres = list.get(0);
        else
            modifyres = null;

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return modifyres;
    }
}
