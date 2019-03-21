package dao;

import model.*;
import java.util.List;

public interface FoodDAO {
    //根据餐厅id获取某餐厅所有食物
    public List<Food> getAllFoodByResId(int resId);
    //根据食物id获取该食物
    public Food getFoodByid(int id);
    //新增食物
    public void addFood(Food food);
    //更新食物信息
    public void update(Food food);
}
