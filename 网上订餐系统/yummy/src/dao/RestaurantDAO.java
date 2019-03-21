package dao;

import model.Restaurant;

import java.util.List;

public interface RestaurantDAO {
    //增加新餐厅
    public void addNewRes(Restaurant restaurant);
    //更新餐厅信息
    public void updateRes(Restaurant restaurant);
    //获取所有餐厅
    public List<Restaurant> getAllRes();
    //根据id查找餐厅
    public Restaurant getResById(int id);
    //根据餐厅名称查找餐厅
    public Restaurant getResByName(String name);

}
