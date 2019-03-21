package factory;

import model.*;
import util.MathUtil;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class ModelFactory {
    public Member NewMember(String email, String name, String address, String phone, String password){
        Member member = new Member();
        member.setEmail(email);
        member.setName(name);
        member.setPassword(password);
        member.setPhone(phone);
        member.setViplevel(1);
        member.setLogoff(false);
        member.setMoney(10000);
        member.setTotal(0.0);
        member.setAddress(address);
        member.setActived(false);
        member.setCode(UUID.randomUUID().toString().replace("-", ""));
        return member;
    }
    public Food NewFood(String name, int resid, double price,
                        int left, String description, String type){
        Food food = new Food();
        food.setName(name);
        food.setDescription(description);
        food.setQuantity(left);
        food.setPrice(price);
        food.setCreatetime(getNowTime());
        food.setRestaurantid(resid);
        food.setType(type);
        return food;
    }
    public Orderdetail NewOrder(int foodid, Integer num, String orderid){
        Orderdetail orderdetail = new Orderdetail();
        orderdetail.setFoodid(foodid);
        orderdetail.setNum(num);
        orderdetail.setOrderid(orderid);
        return orderdetail;
    }
    public Modifyres NewModifyes(Integer resid,String typebefore,
                                 String typeafter,String desbefore,String desafter){
        Modifyres modifyres = new Modifyres();
        modifyres.setIscheck(false);
        modifyres.setResid(resid);
        modifyres.setDatetime(getNowTime());
        modifyres.setDesbefore(desbefore);
        modifyres.setDesafter(desafter);
        modifyres.setTypebefore(typebefore);
        modifyres.setTypeafter(typeafter);
        return modifyres;
    }
    private Timestamp getNowTime(){
        return new Timestamp(System.currentTimeMillis());
    }
    public Ordercheck NewOrdercheck(String memberemail,Integer restauranrid,Double totalprice,String sendtime){
        Ordercheck ordercheck = new Ordercheck();
        ordercheck.setSent(false);
        ordercheck.setPaid(false);
        ordercheck.setArrived(false);
        ordercheck.setBalance(false);
        ordercheck.setMemberemail(memberemail);
        ordercheck.setRestauranrid(restauranrid);
        ordercheck.setDatetime(getNowTime());
        ordercheck.setAskReturn(false);
        ordercheck.setTotalprice(totalprice);
        ordercheck.setDesideRerutn(false);
        ordercheck.setReturned(false);
        ordercheck.setSendtime(sendtime);
        MathUtil mathUtil = new MathUtil();
        ordercheck.setEarn(mathUtil.twoDouble(totalprice/10));
        ordercheck.setOrderid(createOrdercheckId());
        return ordercheck;
    }
    private String createOrdercheckId(){
        String id="";
        //获取当前时间戳
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
        String temp = sf.format(new Date());
        //获取随机数
        int random=(int) ((Math.random()+1)*1000);
        id=temp+random;
        return id;

    }
    public Restaurant NewRes(String name,String type,String password,String description){
        Restaurant restaurant = new Restaurant();
        restaurant.setIncome(0.0);
        restaurant.setType(type);
        restaurant.setDescription(description);
        restaurant.setPassword(password);
        restaurant.setName(name);
        restaurant.setId(new MathUtil().getsevenid());
        return restaurant;
    }
}
