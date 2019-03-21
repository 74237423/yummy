package util;


import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MathUtil {
    private static int getRandom(){
        return (int)Math.floor(Math.random()*10);
    }
    public int getsevenid(){
        String Num="";
        for (int i = 0;i<7;i++){
            int n =getRandom();
            if (Num.indexOf(Integer.toString(n))!=-1){
                if (i!=0)
                    i--;
            }else {
                Num += n;
            }
        }
        return Integer.parseInt(Num);
    }
    public double twoDouble(double d){
        BigDecimal b = new BigDecimal(d);
        d = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        return d;
    }
    public String twoMinAfter(Timestamp timestamp) throws ParseException {
        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String tsStr = sdf.format(timestamp);

        long time = sdf.parse(tsStr).getTime();
        time += 2*60*1000;
        Date date = new Date(time);
        return sdf.format(date);
    }
}
