package dao;


import model.Member;

import java.util.List;

public interface MemberDAO {
    //根据用户邮箱获取用户对象
    public Member getMemberByEmail(String email);
    //更新用户信息
    public void updateMember(Member member);
    //增加用户
    public void addNewMember(Member member);
    //获取所有用户
    public List<Member> getAllMember();
}
