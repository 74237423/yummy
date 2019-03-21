package dao;

import model.*;

public interface AdminDAO {
    //根据管理员id查找管理员对象
    public Admin getAdminById(int id);
}
