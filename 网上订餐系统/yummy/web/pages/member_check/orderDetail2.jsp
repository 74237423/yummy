<%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/3/5
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.Ordercheck" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Member" %>
<%@ page import="service.restaurant.RestaurantService" %>
<%@ page import="service.member.MemberService" %>
<%@ page import="model.Orderdetail" %>
<%@ page import="model.Restaurant" %>
<%@ page import="util.MathUtil" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
    <meta name="description" content="" />
    <meta name="viewport" content="user-scalable=no">

    <meta name="google-site-verification" content="BstJA3X9z6f9HcvoN9AZTwaKo_9Abj_j7dVBPfy640s" />
    <meta name="baidu-site-verification" content="IYCrtVH0i1" />
    <meta property="wb:webmaster" content="239d3d1dbdde1b2c" />

    <script type="text/javascript">

        (function(document, screen) {if (screen.width < 760) {document.location.href="/mobile/";}}(document, screen));
    </script>

    <link rel="stylesheet" href="../../css/common.css?v=2015-5-20"/>
    <link rel="stylesheet" href="../../css/user_center.css"/>
    <title>Title</title>
</head>
<body class="day " ng-controller="bodyCtrl"  day-or-night>
<%
    Member member = (Member) session.getAttribute("member");
    List<Ordercheck> orderNeedSend = (List<Ordercheck>) session.getAttribute("memNeedSend");
    List<Ordercheck> orderSending = (List<Ordercheck>) session.getAttribute("memSenting");
    List<Ordercheck> orderArrived = (List<Ordercheck>) session.getAttribute("memArrived");
    List<Ordercheck> orderAskReturn = (List<Ordercheck>) session.getAttribute("memAskReturn");
    List<Ordercheck> orderNeedPay = (List<Ordercheck>) session.getAttribute("memNeedPay");
    RestaurantService restaurantService = new RestaurantService();
    MathUtil mathUtil = new MathUtil();

%>
<section class="common-back" id="wrapBackground">

    <header id="header">
        <div class="common-width clearfix">
            <h1 class="fl">
                <a class="logo base-logo" >Yummy</a>
            </h1>

            <ul class="member logging" ng-init="loginInfo=true">
                <li><a class="index">首页</a></li>
                <li class="userName">
                    <a rel="nofollow" draw-user>欢迎，<%=member.getName()%><em></em></a>
                </li>
                <li class=""><a rel="nofollow"><form method='GET' action="/memberLogin">
                    <input type='submit' name='logout' value='logout'>
                </form></a></li>
            </ul>

        </div>
    </header>


    <section>
        <div class="user-center-main-box common-width clearfix">
            <aside class="fl">
                <ul>
                    <li>
                        <a rel="nofollow" href="/memberFindRes">外卖店家</a>
                    </li>
                    <li class="active">
                        <a rel="nofollow" href="/memberOrder">我的订单</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memberPersonalData">个人信息</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memSum">历史统计</a>
                    </li>
                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>各类订单</header>

                <section class="user-address-main">

                    <article>
                        <center>
                            <header>
                                <h2>
                                    未支付订单
                                </h2>
                            </header>
                        </center>

                        <form method="post" action="/goPay">
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>剩余支付时间</th>
                                    <th>餐厅名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>期望配送时间</th>
                                    <th>支付(元)</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderNeedPay.size()<1){
                                        out.print("<tr><td colspan='8'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderNeedPay.size();i++){
                                        String paytime = "";
                                        try{
                                            paytime=mathUtil.twoMinAfter(orderNeedPay.get(i).getDatetime());
                                        }catch (ParseException e){
                                            e.printStackTrace();
                                        }
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderNeedPay.get(i));
                                        Restaurant restaurant = restaurantService.getResById(orderNeedPay.get(i).getRestauranrid());
                                        out.print("<tr><td>" + orderNeedPay.get(i).getOrderid()+
                                                "</td><td><span class='intDifftime' endTime='"+paytime+"'>0:00</span>"+
                                                "</td><td>" +restaurant.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>"+orderNeedPay.get(i).getSendtime()+
                                                "</td><td>" +orderNeedPay.get(i).getTotalprice()+

                                                "</td><td>" +
                                                "<button type='submit' class='btn btn-success' name='payId' value='"+
                                                orderNeedPay.get(i).getOrderid()
                                                +"' >确认支付</button><br><br>"+
                                                "<button type='submit' formaction='/canclePay' class='btn btn-cancel' name='cancleId' value='"+
                                                orderNeedPay.get(i).getOrderid()
                                                +"' >取消订单</button>"+
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='7' align='center' ><table>" +
                                                "<tr><th>菜品</th><th>数量</th><th>单价(元)</th><th>描述</th></tr>");
                                        for (int j = 0; j< orderdetails.size(); j++){
                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getName()+
                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getPrice()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getDescription()+
                                                    "</td></tr>");
                                        }
                                        out.print("</table></td></tr>");
                                    }
                                %>
                            </table>
                        </form>
                    </article>
                    <article class="mb10">
                        <center>
                            <header><h2>未配送订单</h2></header>
                        </center>

                        <form action="/askReturn" method="post">
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>餐厅名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>期望配送时间</th>
                                    <th>支付(元)</th>
                                    <th>状态</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderNeedSend.size()<1){
                                        out.print("<tr><td colspan='9'>暂无该类订单</td></tr>");
                                    }


                                    for (int i=0;i<orderNeedSend.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderNeedSend.get(i));
                                        Restaurant restaurant = restaurantService.getResById(orderNeedSend.get(i).getRestauranrid());
                                        out.print("<tr><td>" + orderNeedSend.get(i).getOrderid()+
                                                "</td><td>" + orderNeedSend.get(i).getDatetime()+
                                                "</td><td>" +restaurant.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>"+orderNeedSend.get(i).getSendtime()+
                                                "</td><td>" +orderNeedSend.get(i).getTotalprice()+
                                                "</td><td>未配送" +
                                                "</td><td>" +
                                                "<button title='退全款' type='submit' class='btn btn-success' name='askReturnId' value='"+
                                                orderNeedSend.get(i).getOrderid()
                                                +"' >请求退款</button>"+
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='8' align='center' ><table>" +
                                                "<tr><th>菜品</th><th>数量</th><th>单价(元)</th><th>描述</th></tr>");
                                        for (int j = 0; j< orderdetails.size(); j++){
                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getName()+
                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getPrice()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getDescription()+
                                                    "</td></tr>");
                                        }
                                        out.print("</table></td></tr>");
                                    }
                                %>
                            </table>
                        </form>

                    </article>
                    <article>
                        <center>
                            <header><h2>配送中订单</h2></header>
                        </center>

                        <form method="post" action="/arrivedOrder">
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>餐厅名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>状态</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderSending.size()<1){
                                        out.print("<tr><td colspan='7'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderSending.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderSending.get(i));
                                        Restaurant restaurant = restaurantService.getResById(orderSending.get(i).getRestauranrid());
                                        out.print("<tr><td>" + orderSending.get(i).getOrderid()+
                                                "</td><td>" + orderSending.get(i).getDatetime()+
                                                "</td><td>" +restaurant.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>配送中" +
                                                "</td><td>" +
                                                "<button type='submit' class='btn btn-success' name='arrivedId' value='"+
                                                orderSending.get(i).getOrderid()
                                                +"' >确认到达</button><br><br>"+
                                                "<button title='只能退90%' type='submit' formaction='/askReturn' class='btn btn-cancel' name='askReturnId' value='"+
                                                orderSending.get(i).getOrderid()
                                                +"' >请求退款</button>"+
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='6' align='center' ><table>" +
                                                "<tr><th>菜品</th><th>数量</th><th>单价(元)</th><th>描述</th></tr>");
                                        for (int j = 0; j< orderdetails.size(); j++){
                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getName()+
                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getPrice()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getDescription()+
                                                    "</td></tr>");
                                        }
                                        out.print("</table></td></tr>");
                                    }
                                %>
                            </table>
                        </form>
                    </article>

                    <article>
                        <center>
                            <header><h2>已到达订单</h2></header>
                        </center>

                        <form>
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>餐厅名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>状态</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderArrived.size()<1){
                                        out.print("<tr><td colspan='6'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderArrived.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderArrived.get(i));
                                        Restaurant restaurant = restaurantService.getResById(orderArrived.get(i).getRestauranrid());
                                        out.print("<tr><td>" + orderArrived.get(i).getOrderid()+
                                                "</td><td>" + orderArrived.get(i).getDatetime()+
                                                "</td><td>" +restaurant.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>已到达" +
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='5' align='center' ><table>" +
                                                "<tr><th>菜品</th><th>数量</th><th>单价(元)</th><th>描述</th></tr>");
                                        for (int j = 0; j< orderdetails.size(); j++){
                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getName()+
                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getPrice()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getDescription()+
                                                    "</td></tr>");
                                        }
                                        out.print("</table></td></tr>");
                                    }
                                %>

                            </table>
                        </form>
                    </article>

                    <article>
                        <center>
                            <header>
                                <h2>请求退款订单</h2>
                            </header>
                        </center>

                        <form>
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>餐厅名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>退款状态</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderAskReturn.size()<1){
                                        out.print("<tr><td colspan='6'>暂无该类订单</td></tr>");
                                    }
                                    MemberService memberService = new MemberService();
                                    for (int i=0;i<orderAskReturn.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderAskReturn.get(i));
                                        Restaurant restaurant = restaurantService.getResById(orderAskReturn.get(i).getRestauranrid());
                                        String state = memberService.stateOfReturnOrder(orderAskReturn.get(i));

                                        out.print("<tr><td>" + orderAskReturn.get(i).getOrderid()+
                                                "</td><td>" + orderAskReturn.get(i).getDatetime()+
                                                "</td><td>" +restaurant.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>" +state+
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='5' align='center' ><table>" +
                                                "<tr><th>菜品</th><th>数量</th><th>单价(元)</th><th>描述</th></tr>");
                                        for (int j = 0; j< orderdetails.size(); j++){
                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getName()+
                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getPrice()+
                                                    "</td><td>" + restaurantService.getFoodById(orderdetails.get(j).getFoodid()).getDescription()+
                                                    "</td></tr>");
                                        }
                                        out.print("</table></td></tr>");
                                    }
                                %>

                            </table>
                        </form>
                    </article>
                </section>
            </article>
        </div>
    </section>

</section>

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

                var tr = this.parentNode.parentNode;

                var button = tr.getElementsByTagName("td")[7].getElementsByTagName("button")[0];
                button.disabled=true;

            }});
        setTimeout("updateEndTime()",1000);
    }
</script>
</body>
</html>