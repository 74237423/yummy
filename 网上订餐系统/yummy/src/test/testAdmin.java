package test;

import util.MathUtil;

import java.sql.Timestamp;
import java.text.ParseException;

public class testAdmin {
    public static void main(String[] args) throws ParseException {
    //   AdminService adminService =new AdminService();
    //    adminService.login(1,"123");
       // FoodDAO foodDAO = new FoodDAOImpl();
        //foodDAO.addFood();
       // OrdercheckDAO ordercheckDAO = new OrdercheckImpl();
      //  List<Ordercheck> list = ordercheckDAO.getNeedSendByMem("844691213@qq.com");
        //List<Ordercheck> list = ordercheckDAO.getOkOrdercheckByMem("234@qq.com");
       // System.out.println(list.get(0).getDatetime());
        MathUtil mathUtil = new MathUtil();
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        System.out.println(mathUtil.twoMinAfter(timestamp));
   }
}
