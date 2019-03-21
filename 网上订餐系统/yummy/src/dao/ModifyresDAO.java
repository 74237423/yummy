package dao;

import model.*;
import java.util.List;

public interface ModifyresDAO {
    //新增修改要求
    public void addModify(Modifyres modifyres);
    //更新修改要求
    public void update(Modifyres modifyres);
    //获取所有修改要求
    public List<Modifyres> getAllM();
    //获取需审批的修改要求
    public List<Modifyres> getCheckM();
    //获取已审批的修改要求
    public List<Modifyres> getOkM();
    //根据id查找修改要求
    public Modifyres getModifyById(int id);
}
