<%@ page import="model.Restaurant" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordercheck" %>
<%@ page import="model.Orderdetail" %>
<%@ page import="service.restaurant.RestaurantService" %>
<%@ page import="model.Member" %>
<%@ page import="service.member.MemberService" %>
<%@ page import="model.Orderdetail" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/27
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
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
    Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");

    List<Ordercheck> orderNeedSend = (List<Ordercheck>) session.getAttribute("resNeedSend");
    List<Ordercheck> orderSending = (List<Ordercheck>) session.getAttribute("resSenting");
    List<Ordercheck> orderArrived = (List<Ordercheck>) session.getAttribute("resArrived");
    List<Ordercheck> orderAskReturn = (List<Ordercheck>) session.getAttribute("resAskReturn");
    List<Ordercheck> orderReturned = (List<Ordercheck>) session.getAttribute("resReturned");
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
                    <a rel="nofollow" draw-user><%=restaurant.getName()%><em></em></a>
                </li>
                <li class=""><a rel="nofollow"><form method='GET' action="/resLogin">
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
                        <a rel="nofollow" href="/resData">餐厅信息</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/resMenu">菜单</a>
                    </li>
                    <li class="active">
                        <a rel="nofollow" href="/resOrder">订单</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/resSum">历史统计</a>
                    </li>
                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>订单表</header>

                <section class="user-address-main">

                    <article class="mb10">
                        <center>
                            <header>
                                <h2>
                                    未配送订单
                                </h2>
                            </header>
                        </center>

                        <form method="post" action="/sendOrder">
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>顾客姓名</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>期望配送时间</th>
                                    <th>状态</th>
                                    <th>操作</th>

                                </tr>
                                </thead>


                                <%
                                    if(orderNeedSend.size()<1){
                                        out.print("<tr><td colspan='8'>暂无该类订单</td></tr>");
                                    }
                                    RestaurantService restaurantService = new RestaurantService();
                                    MemberService memberService = new MemberService();
                                    for (int i=0;i<orderNeedSend.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderNeedSend.get(i));
                                        Member member = memberService.getMemberByEmail(orderNeedSend.get(i).getMemberemail());
                                        out.print("<tr><td>" + orderNeedSend.get(i).getOrderid()+
                                                "</td><td>" + orderNeedSend.get(i).getDatetime()+
                                                "</td><td>" +member.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>"+orderNeedSend.get(i).getSendtime()+
                                                "</td><td>未配送" +
                                                "</td><td>" +
                                                "<button type='submit' class='btn btn-success' name='needSendOrderId' value='"+
                                                orderNeedSend.get(i).getOrderid()
                                                +"' >开始配送</button>"+
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
                    <article>
                        <center>
                            <header>
                                <h2>
                                    配送中订单
                                </h2>
                            </header>
                        </center>

                        <form>
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>会员名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>状态</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderSending.size()<1){
                                        out.print("<tr><td colspan='6'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderSending.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderSending.get(i));
                                        Member member = memberService.getMemberByEmail(orderSending.get(i).getMemberemail());
                                        out.print("<tr><td>" + orderSending.get(i).getOrderid()+
                                                "</td><td>" + orderSending.get(i).getDatetime()+
                                                "</td><td>" +member.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>配送中" +
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
                                <h2>
                                    已到达订单
                                </h2>
                            </header>
                        </center>

                        <form>
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>会员名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>状态</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderArrived.size()<1){
                                        out.print("<tr><td colspan='7'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderArrived.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderArrived.get(i));
                                        Member member = memberService.getMemberByEmail(orderArrived.get(i).getMemberemail());
                                        out.print("<tr><td>" + orderArrived.get(i).getOrderid()+
                                                "</td><td>" + orderArrived.get(i).getDatetime()+
                                                "</td><td>" +member.getName()+
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
                                <h2>要求退款订单</h2>
                            </header>
                        </center>

                        <form method="post" action="/aggreeReturn">
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>会员名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderAskReturn.size()<1){
                                        out.print("<tr><td colspan='6'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderAskReturn.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderAskReturn.get(i));
                                        Member member = memberService.getMemberByEmail(orderAskReturn.get(i).getMemberemail());
                                        out.print("<tr><td>" + orderAskReturn.get(i).getOrderid()+
                                                "</td><td>" + orderAskReturn.get(i).getDatetime()+
                                                "</td><td>" +member.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td><td>" +
                                                "<button type='submit' class='btn btn-success' name='aggreeReturnOrderId' value='"+
                                                orderAskReturn.get(i).getOrderid()
                                                +"' >同意退款</button><br><br>"+
                                                "<button type='submit' formaction='/disaggreeReturn' class='btn btn-cancel' name='disaggreeReturnOrderId' value='"+
                                                orderAskReturn.get(i).getOrderid()
                                                +"' >拒绝退款</button>"+
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
                            <header><h2>已退款订单</h2></header>
                        </center>

                        <form>
                            <table>
                                <thead>
                                <tr>

                                    <th>订单id</th>
                                    <th>生成时间</th>
                                    <th>会员名称</th>
                                    <th>配送地址</th>
                                    <th>收货电话</th>

                                </tr>
                                </thead>
                                <%
                                    if(orderReturned.size()<1){
                                        out.print("<tr><td colspan='5'>暂无该类订单</td></tr>");
                                    }
                                    for (int i=0;i<orderReturned.size();i++){
                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderReturned.get(i));
                                        Member member = memberService.getMemberByEmail(orderReturned.get(i).getMemberemail());
                                        out.print("<tr><td>" + orderReturned.get(i).getOrderid()+
                                                "</td><td>" + orderReturned.get(i).getDatetime()+
                                                "</td><td>" +member.getName()+
                                                "</td><td>" +member.getAddress()+
                                                "</td><td>" +member.getPhone()+
                                                "</td></tr>" +
                                                "<tr><td>订单详情</td><td colspan='4' align='center' ><table>" +
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

</body>
</html>