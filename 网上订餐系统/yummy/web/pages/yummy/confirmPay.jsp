<%@ page import="model.Member" %>
<%@ page import="model.Restaurant" %>
<%@ page import="model.Food" %>
<%@ page import="java.util.List" %>
<%@ page import="util.MathUtil" %>
<%@ page import="model.Ordercheck" %>
<%@ page import="java.text.ParseException" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/3/7
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../../css/common.css?v=2015-5-20"/>
    <link rel="stylesheet" href="../../css/checkout.css">
    <style>
        td {
            text-align: center
        }
    </style>
</head>
<body class="day " ng-controller="bodyCtrl"  day-or-night>
<%

    Member member = (Member) session.getAttribute("member");
    Restaurant restaurant = (Restaurant) session.getAttribute("enterRes");
    List<Food> foodList = (List<Food>) session.getAttribute("askfoodlist");
    List<Integer> num = (List<Integer>) session.getAttribute("asknum");
    double total = (double) session.getAttribute("payMoney");
    double save = (double) session.getAttribute("save");
    MathUtil mathUtil = new MathUtil();
    Ordercheck ordercheck = (Ordercheck) session.getAttribute("order");
    String paytime = "";
    try{
        paytime=mathUtil.twoMinAfter(ordercheck.getDatetime());
    }catch (ParseException e){
        e.printStackTrace();
    }

%>
<section class="common-back" id="wrapBackground">

    <header id="header">
        <div class="common-width clearfix">
            <h1 class="fl">
                <a class="logo base-logo">Yummy</a>
            </h1>

            <ul class="member" login-box>
                <li><a class="index">首页</a></li>
                <li class="userName">
                    <a rel="nofollow" draw-user>欢迎<em></em></a>
                </li>
                <li><a class="orderdetail-center"  rel="nofollow">余额：<%=member.getMoney()%>元</a></li>
                <li><a class="orderdetail-center"  rel="nofollow">等级：<%=member.getViplevel()%>级</a></li>

                <li><a class="orderdetail-center"  rel="nofollow" href="/memberOrder">我的订单</a></li>
                <li><a class="orderdetail-center"  rel="nofollow" href="/memberPersonalData">个人信息</a></li>
                <li><a class="orderdetail-center"  rel="nofollow" href="/memSum">历史统计</a></li>
                <li class="login-register"><a rel="nofollow"><form method='GET' action="/memberLogin">
                    <input type='submit' name='logout' value='logout'>
                </form></a></li>
            </ul>

        </div>
    </header>

    <div id="main-box">


        <section class="checkout-main common-width">
            <header class="brtrl">确认支付</header>
            <section class="user-info">
                <header><h2>（原价<%=total+save%>元，优惠<%=save%>元）您将花费<%=total%>元从<%=restaurant.getName()%>购买以下菜品：</h2></header>
                <article>
                    <table>
                        <tr>
                            <th>菜品名称</th>
                            <th>描述</th>
                            <th>数量</th>
                        </tr>
                        <%
                            for (int i=0;i<foodList.size();i++){
                                out.print("<tr><td>" +foodList.get(i).getName()+
                                        "</td><td>" +foodList.get(i).getDescription()+
                                        "</td><td>" +num.get(i)+
                                        "</td></tr>");
                            }
                        %>
                    </table>

                </article>
                <br>
                <br>
                <p>支付剩余时间：<span class="intDifftime" endTime="<%=paytime%>">0:00</span></p>

                <br>
                <br>
                <article>
                    <center>
                        <form action="/confirmPay" method="post">
                            <button id="paybtn" class="btn btn-success normal-btn">确认支付</button>
                            <button class="btn btn-cancel normal-btn" formaction='/memberOrder'>考虑一下</button>
                        </form>
                    </center>

                </article>
            </section>

        </section>

    </div>
</section>
<script src="../../js/jquery-2.1.1.min.js"></script>
<script src="../../js/countdown.js"></script>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
    $(function(){
        updateEndTime();
    });
    function updateEndTime(){
        var NowTime = new Date();
        var time = NowTime.getTime();
        $(".intDifftime").each(function(I){
            var endDate =this.getAttribute("endTime");
            console.log("aa",endDate);
            var endDate1 = eval('new Date(' + endDate.replace(/\d+(?=-[^-]+$)/, function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
            var endTime = endDate1.getTime();
            var lag =Math.floor((endTime - time) / 1000);
            console.log("秒数",endTime);
            //			判断计时是否停止
            if(lag >= 0){
                var day = Math.floor(lag / (60 * 60 * 24));
                var h = Math.floor(lag / 3600);
                var d = Math.floor(h/24);
                var m = Math.floor(lag/60%60);
                var s = lag%60;
                $(this).html( m +"分"+ s +'秒');
            }else{
                var button = $("#paybtn");
                button.disabled=true;
            }});
        setTimeout("updateEndTime()",1000);
    }
</script>
</body>
</html>