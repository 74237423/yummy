<%@ page import="model.Member" %>
<%@ page import="model.Restaurant" %>
<%@ page import="model.Food" %>
<%@ page import="java.util.List" %>
<%@ page import="util.MathUtil" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/27
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="120;url=/resFood" />
    <title>支付界面</title>
    <link rel="stylesheet" href="../../css/common.css?v=2015-5-20"/>
    <link rel="stylesheet" href="../../css/checkout.css">
    <style>
        h3{margin-top: 30px}
        .ys1{
            color: #009AC1;
            font-weight: bold;
        }
        .ys2{
            color: #2FAB11;
            font-weight: bold;
        }
        .ys3{
            color: #C16000;
            font-weight: bold;
        }
    </style>
</head>
<body class="day " ng-controller="bodyCtrl"  day-or-night>
<%
    Member member = (Member) session.getAttribute("member");
    Restaurant restaurant = (Restaurant) session.getAttribute("enterRes");
    List<Food> foodList = (List<Food>) session.getAttribute("askfoodlist");
    List<Integer> num = (List<Integer>) session.getAttribute("asknum");
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
                    <a rel="nofollow" draw-user>欢迎，<%=member.getName()%><em></em></a>
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
            <header class="brtrl">送餐信息</header>
            <section class="user-info">
                <form novalidate="true" name="orderForm" class="orderdetail-form inline">
                    <div class="form-group mb30 row">
                        <label class="col-2">餐厅名称：</label>
                        <div class="col-6">
                            <input type="text" required name="resname" readonly="readonly" value="<%=restaurant.getName()%>"/>
                        </div>
                    </div>
                    <div class="form-group mb30 row">
                        <label class="col-2">收货人：</label>
                        <div class="col-6">
                            <input type="text" required name="name" readonly="readonly" value="<%=member.getName()%>"/>
                        </div>
                    </div>
                    <div class="form-group mb30 row">
                        <label class="col-2">收货手机号：</label>
                        <div class="col-6">
                            <input type="text" required name="phone" readonly="readonly" value="<%=member.getPhone()%>"/>
                        </div>
                    </div>
                    <div class="form-group mb30 row">
                        <label class="col-2">收货地址：</label>
                        <div class="col-6">
                            <input type="text" required name="address" readonly="readonly" value="<%=member.getAddress()%>"/>
                        </div>
                    </div>
                </form>
            </section>

            <header>订单内容</header>
            <section>

                <div>
                    <div class="orderdetail-thead clearfix">
                        <div class="goods-name">商品</div>
                        <div class="goods-count">份数</div>
                        <div class="goods-price">单价</div>

                        <div class="goods-total">小计</div>
                    </div>
                    <div class="orderdetail-body">



                        <%
                            double total=0;
                            for (int i=0;i<foodList.size();i++){
                                total += num.get(i)*foodList.get(i).getPrice();
                                out.print("<div class='orderdetail-item clearfix'>" +
                                        "<div class='goods-name'>" +
                                        foodList.get(i).getName() +
                                        "</div>" +
                                        "<div class='goods-count'>" +
                                        num.get(i) +
                                        "</div>" +
                                        "<div class='goods-price'>" +
                                        foodList.get(i).getPrice() +
                                        "</div>" +
                                        "<div class='goods-total'>" +
                                        num.get(i)*foodList.get(i).getPrice() +
                                        "</div>");
                            }

                        %>


                        <div class="orderdetail-item orderdetail-item-addendum clearfix">
                            <%
                                MathUtil mathUtil = new MathUtil();
                                double saveMoney = total;
                                if(member.getViplevel()==3){
                                    out.print("<div class='goods-name'>会员3级打8折</div>" +
                                            "<div class='goods-count'>/</div>" +
                                            "<div class='goods-price'>/</div>" +
                                            "<div class='goods-total'>￥-" +
                                            mathUtil.twoDouble(total*0.2) +
                                            "</div>");
                                    total = mathUtil.twoDouble(total*0.8);

                                }
                                else if(member.getViplevel()==2){
                                    out.print("<div class='goods-name'>会员2级打9折</div>"+
                                            "<div class='goods-count'>/</div>" +
                                            "<div class='goods-price'>/</div>" +
                                            "<div class='goods-total'>￥-" +
                                            mathUtil.twoDouble(total*0.1) +
                                            "</div>");
                                    total = mathUtil.twoDouble(total*0.9);
                                }
                                if (total>50){
                                    out.print("<div class='goods-name'>折后满50减3元</div>" +
                                            "<div class='goods-count'>/</div>" +
                                            "<div class='goods-price'>/</div>" +
                                            "<div class=‘goods-total’>￥-3.00</div>");
                                    total=total-3;
                                }
                                saveMoney -= mathUtil.twoDouble(total);
                                session.setAttribute("payMoney",total);
                                session.setAttribute("save",mathUtil.twoDouble(saveMoney));
                            %>

                        </div>

                    </div>
                </div>
            </section>

            <section class="total-sum">
                <div class="container">

                    <%
                        boolean CanPay = (boolean) session.getAttribute("canPay");
                        String message = (String) session.getAttribute("payMessage");
                        if (!CanPay){
                            out.print("<p style='color: red'>" + message+
                                    "</p>");
                        }
                    %>


                </div>
                <p class="tr fs14">订单金额： <span>￥<%=total%></span></p>

                <p class="tr fs17 pink">需要付款： <b>￥<span ng-init="orderTotal=32.00" ng-bind="orderTotal|number:2"><%=total%></span></b></p>
                <p class="tr last">
                    <a class="fs15 link" href="/resFood"> 返回该餐厅菜单</a>
                    <form method="post" action="/memberPay">
                <div class="form-group mb30 row">
                    <label class="col-2">期望送货时间：</label>
                    <div class="col-6">
                        <input type="datetime-local"  name="sendtime"/>
                    </div>
                </div>
                <%

                    if(!CanPay){
                        out.print("<button class='btn btn-success fs20' type='submit' disabled='disabled'>提交订单 </button>");
                    }else
                        out.print("<button class='btn btn-success fs20' type='submit'>提交订单 </button>");
                %>
                    </form>
                </p>
            </section>
        </section>

    </div>
</section>
<script src="../../js/jquery-2.1.1.min.js"></script>
<script src="../../js/countdown.js"></script>

</body>
</html>