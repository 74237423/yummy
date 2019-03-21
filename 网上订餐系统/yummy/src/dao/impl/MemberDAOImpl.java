package dao.impl;

import dao.MemberDAO;
import model.Member;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;

public class MemberDAOImpl implements MemberDAO {
    private static SessionFactory sf = new Configuration().configure().buildSessionFactory();
    //根据用户邮箱获取用户对象
    @Override
    public Member getMemberByEmail(String email) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        String hql = "from Member u where u.email = ?1";
        Query query = session.createQuery(hql);
        query.setParameter(1, email);
        List<Member> list = query.list();
        Member memberDetail = new Member();
        if (list.size()>0)
             memberDetail= list.get(0);
        else
            memberDetail=null;

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return memberDetail;
    }
    //更新用户信息
    @Override
    public void updateMember(Member member) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.update(member);

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();
    }
    //增加用户
    @Override
    public void addNewMember(Member member) {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        session.save(member);
        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

    }
    //获取所有用户
    @Override
    public List<Member> getAllMember() {
        //根据session工厂创建session
        Session session=sf.openSession();
        //开启事务
        Transaction tx=session.beginTransaction();

        Query q=session.createQuery("from Member ");
        List<Member> list = q.list();

        //提交事务
        tx.commit();
        //关闭事务和session
        session.close();
        //sf.close();

        return list;
    }
}
