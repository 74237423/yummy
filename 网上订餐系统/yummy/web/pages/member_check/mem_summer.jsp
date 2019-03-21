<%@ page import="java.util.List" %>
<%@ page import="service.restaurant.RestaurantService" %>
<%@ page import="model.*" %>
<%@ page import="service.member.MemberService" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/3/15
  Time: 19:18
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
    <style>
        table {
            table-layout:fixed;
        }
        td {
            white-space:nowrap;/*文本不会换行，文本会在在同一行上继续，直到遇到 <br> 标签为止。*/
            overflow:hidden;/*隐藏多余的内容*/
            text-overflow: ellipsis;
        }

        td:hover{
            overflow:auto;
            text-overflow:clip;
        }

    </style>
</head>
<body class="day " ng-controller="bodyCtrl"  day-or-night>
<%
    Member member = (Member) session.getAttribute("member");
    List<Ordercheck> arrivedOrder = (List<Ordercheck>) session.getAttribute("memArrived");
    List<Ordercheck> returnedOrder = (List<Ordercheck>) session.getAttribute("memReturned");
    RestaurantService restaurantService = new RestaurantService();
    MemberService memberService = new MemberService();
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
                    <li>
                        <a rel="nofollow" href="/memberOrder">我的订单</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memberPersonalData">个人信息</a>
                    </li>
                    <li class="active">
                        <a rel="nofollow" href="/memSum">历史统计</a>
                    </li>

                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>历史统计</header>

                <section class="user-address-main">

                    <article>


                        <section class="add-address-box">
                            <div class="example">
                                <center>
                                    <header>
                                        <h2>消费历史</h2>
                                    </header>
                                </center>
                                <table>
                                    <thead>
                                    <tr><th  class="no-sort">订单id</th><th>生成时间</th><th>餐厅名称</th><th>支付(元)</th><th  class="no-sort">订单详情</th></tr>

                                    </thead>
                                    <tbody>
                                    <%
                                        if(arrivedOrder.size()<1){
                                            out.print("<tr><td colspan='5'>暂无该类订单</td></tr>");
                                        }
                                        for (int i=0;i<arrivedOrder.size();i++){
                                            Restaurant restaurant = restaurantService.getResById(arrivedOrder.get(i).getRestauranrid());
                                            String detail="";
                                            List<Orderdetail> orderdetails = restaurantService.getOrderContext(arrivedOrder.get(i));
                                            for (int j=0;j<orderdetails.size();j++){
                                                Food food = restaurantService.getFoodById(orderdetails.get(j).getFoodid());
                                                detail = detail + food.getName()+ " X"+orderdetails.get(j).getNum().toString();
                                                detail+="<br>";
                                            }
                                            out.print("<tr><td>" +arrivedOrder.get(i).getOrderid()+
                                                    "</td><td>" +arrivedOrder.get(i).getDatetime()+
                                                    "</td><td>" +restaurant.getName()+
                                                    "</td><td>" +arrivedOrder.get(i).getTotalprice()+
                                                    "</td><td>" +detail+
                                                    "</td></tr>");
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                            <header><h3>总共：<%=arrivedOrder.size()%>条记录</h3></header>
                        </section>
                    </article>
                    <article>

                        <section class="add-address-box">
                            <div class="example">
                                <center>
                                    <header>
                                        <h2>
                                            退款历史
                                        </h2>
                                    </header>
                                </center>

                                <table>
                                    <thead>
                                    <tr><th  class="no-sort">订单id</th>
                                        <th>生成时间</th>
                                        <th>餐厅名称</th>
                                        <th>支付(元)</th>
                                        <th class="no-sort">退款结果</th>
                                        <th class="no-sort">订单详情</th></tr>

                                    </thead>
                                    <tbody>
                                    <%
                                        if(returnedOrder.size()<1){
                                            out.print("<tr><td colspan='6'>暂无该类订单</td></tr>");
                                        }
                                        for (int i=0;i<returnedOrder.size();i++){
                                            Restaurant restaurant = restaurantService.getResById(returnedOrder.get(i).getRestauranrid());
                                            String detail="";
                                            List<Orderdetail> orderdetails = restaurantService.getOrderContext(returnedOrder.get(i));
                                            for (int j=0;j<orderdetails.size();j++){
                                                Food food = restaurantService.getFoodById(orderdetails.get(j).getFoodid());
                                                detail = detail + food.getName()+ " X"+orderdetails.get(j).getNum().toString();
                                                detail+="<br>";
                                            }
                                            String state = memberService.stateOfReturnOrder(returnedOrder.get(i));
                                            out.print("<tr><td>" +returnedOrder.get(i).getOrderid()+
                                                    "</td><td>" +returnedOrder.get(i).getDatetime()+
                                                    "</td><td>" +restaurant.getName()+
                                                    "</td><td>" +returnedOrder.get(i).getTotalprice()+
                                                    "</td><td>" +state+
                                                    "</td><td>" +detail+
                                                    "</td></tr>");
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                            <header><h3>总共：<%=returnedOrder.size()%>条记录</h3></header>
                        </section>
                    </article>
                </section>
            </article>
        </div>
    </section>

</section>
<script type="text/javascript" src="../../js/sort/jquery-1.9.0.min.js" ></script>
<script type="text/javascript" src="../../js/sort/jquery.tablesort.js" ></script>
<script type="text/javascript">
    $(function() {

        var table = $('<table class="ex-2"></table>');
        table.append('<thead><tr><th class="number">Number</th></tr></thead>');
        var tbody = $('<tbody></tbody>');
        for (var i = 0; i < 20; i++) {
            tbody.append('<tr><td>' + Math.floor(Math.random() * 100) + '</td></tr>');
        }
        table.append(tbody);

        $('.example.ex-2').append(table);

        $('table').tablesort().data('tablesort');

        $('thead th.number').data('sortBy', function(th, td, sorter) {
            return parseInt(td.text(), 10);
        });
        //Sorting indicator example
        $('table.ex-2').on('tablesort:start', function(event, tablesort) {
            $('table.ex-2 tbody').addClass("disabled");
            $('.ex-2 th.number').removeClass("sorted").text('Sorting..');
        });
        $('table.ex-2').on('tablesort:complete', function(event, tablesort) {
            $('table.ex-2 tbody').removeClass("disabled");
            $('.ex-2 th.number').text('Number');
        });

    });

</script>
</body>
</html>