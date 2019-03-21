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
    <script src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/swiper-3.4.0.jquery.min.js" ></script>
    <link rel="stylesheet" href="../../css/swiper-3.2.7.min.css" />
    <link rel="stylesheet" href="../../css/user_center.css"/>
    <title>Title</title>
    <style>
        body {

            margin: 0 auto;
            color: #333;
            padding: 0;
            font-family: "Microsoft Yahei";
            text-align: center;
        }

        .swiper1 {
            width: 100%;
        }
        .swiper1 .selected {
            color: #ec5566;
            border-bottom: 2px solid #ec5566;
        }
        .swiper1 .swiper-slide {
            text-align: center;
            font-size: 16px;
            height: 50px;
            /* Center slide text vertically */
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
            cursor: pointer;
        }
        .swiper2 {
            width: 100%;
        }
        .swiper2 .swiper-slide {
            height: calc(100vh - 50px);
            background-color: #fff;
            color: #000;
            text-align: center;
            box-sizing: border-box !important;
            overflow-x: hidden !important;
        }
    </style>
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
                <header>订单分类表</header>

                <section class="user-address-main">

                    <article class="mb10">
                        <div class="container">
                            <div class="swiper-container swiper1">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide selected">未配送</div>
                                    <div class="swiper-slide">配送中</div>
                                    <div class="swiper-slide">配送完成</div>
                                    <div class="swiper-slide">请求退款</div>
                                    <div class="swiper-slide">已退款</div>

                                </div>
                            </div>
                            <!-- swiper2 -->
                            <div class="swiper-container swiper2">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide swiper-no-swiping">
                                        <form method="post" action="/sendOrder">
                                            <table>
                                                <thead>
                                                <tr>

                                                    <th>订单id</th>
                                                    <th>生成时间</th>
                                                    <th>顾客姓名</th>
                                                    <th>配送地址</th>
                                                    <th>收货电话</th>
                                                    <th>操作</th>

                                                </tr>
                                                </thead>


                                                <%
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
                                                                "</td><td>" +
                                                                "<button type='submit' class='btn btn-success normal-btn' name='needSendOrderId' value='"+
                                                                orderNeedSend.get(i).getOrderid()
                                                                +"' >开始配送</button>"+
                                                                "</td></tr>" +
                                                                "<tr><td>订单详情</td><td colspan='5' align='center' ><table>" +
                                                                "<tr><th>菜品</th><th>数量</th></tr>");
                                                        for (int j = 0; j< orderdetails.size(); j++){
                                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid())+
                                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                                    "</td></tr>");
                                                        }
                                                        out.print("</table></td></tr>");
                                                    }
                                                %>

                                            </table>
                                        </form>
                                    </div>
                                    <div class="swiper-slide swiper-no-swiping">
                                        <form>
                                            <table>
                                                <thead>
                                                <tr>

                                                    <th>订单id</th>
                                                    <th>生成时间</th>
                                                    <th>餐厅名称</th>
                                                    <th>配送地址</th>
                                                    <th>收货电话</th>

                                                </tr>
                                                </thead>
                                                <%
                                                    for (int i=0;i<orderSending.size();i++){
                                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderSending.get(i));
                                                        Member member = memberService.getMemberByEmail(orderSending.get(i).getMemberemail());
                                                        out.print("<tr><td>" + orderSending.get(i).getOrderid()+
                                                                "</td><td>" + orderSending.get(i).getDatetime()+
                                                                "</td><td>" +member.getName()+
                                                                "</td><td>" +member.getAddress()+
                                                                "</td><td>" +member.getPhone()+
                                                                "</td></tr>" +
                                                                "<tr><td>订单详情</td><td colspan='4' align='center' ><table>" +
                                                                "<tr><th>菜品</th><th>数量</th></tr>");
                                                        for (int j = 0; j< orderdetails.size(); j++){
                                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid())+
                                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                                    "</td></tr>");
                                                        }
                                                        out.print("</table></td></tr>");
                                                    }
                                                %>

                                            </table>
                                        </form>
                                    </div>
                                    <div class="swiper-slide swiper-no-swiping">
                                        <form>
                                            <table>
                                                <thead>
                                                <tr>

                                                    <th>订单id</th>
                                                    <th>生成时间</th>
                                                    <th>餐厅名称</th>
                                                    <th>配送地址</th>
                                                    <th>收货电话</th>

                                                </tr>
                                                </thead>
                                                <%
                                                    for (int i=0;i<orderArrived.size();i++){
                                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderArrived.get(i));
                                                        Member member = memberService.getMemberByEmail(orderArrived.get(i).getMemberemail());
                                                        out.print("<tr><td>" + orderArrived.get(i).getOrderid()+
                                                                "</td><td>" + orderArrived.get(i).getDatetime()+
                                                                "</td><td>" +member.getName()+
                                                                "</td><td>" +member.getAddress()+
                                                                "</td><td>" +member.getPhone()+
                                                                "</td></tr>" +
                                                                "<tr><td>订单详情</td><td colspan='4' align='center' ><table>" +
                                                                "<tr><th>菜品</th><th>数量</th></tr>");
                                                        for (int j = 0; j< orderdetails.size(); j++){
                                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid())+
                                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                                    "</td></tr>");
                                                        }
                                                        out.print("</table></td></tr>");
                                                    }
                                                %>
                                            </table>
                                        </form>
                                    </div>
                                    <div class="swiper-slide swiper-no-swiping">
                                        <form method="post" action="/aggreeReturn">
                                            <table>
                                                <thead>
                                                <tr>

                                                    <th>订单id</th>
                                                    <th>生成时间</th>
                                                    <th>餐厅名称</th>
                                                    <th>配送地址</th>
                                                    <th>收货电话</th>
                                                    <th>操作</th>

                                                </tr>
                                                </thead>
                                                <%
                                                    for (int i=0;i<orderAskReturn.size();i++){
                                                        List<Orderdetail> orderdetails = restaurantService.getOrderContext(orderAskReturn.get(i));
                                                        Member member = memberService.getMemberByEmail(orderAskReturn.get(i).getMemberemail());
                                                        out.print("<tr><td>" + orderAskReturn.get(i).getOrderid()+
                                                                "</td><td>" + orderAskReturn.get(i).getDatetime()+
                                                                "</td><td>" +member.getName()+
                                                                "</td><td>" +member.getAddress()+
                                                                "</td><td>" +member.getPhone()+
                                                                "</td><td>" +
                                                                "<button type='submit' class='btn btn-success normal-btn' name='aggreeReturnOrderId' value='"+
                                                                orderAskReturn.get(i).getOrderid()
                                                                +"' >同意退款</button><br><br>"+
                                                                "<button type='submit' formaction='/disaggreReturn' class='btn normal-btn' name='disaggreeReturnOrderId' value='"+
                                                                orderAskReturn.get(i).getOrderid()
                                                                +"' >拒绝退款</button>"+
                                                                "</td></tr>" +
                                                                "<tr><td>订单详情</td><td colspan='5' align='center' ><table>" +
                                                                "<tr><th>菜品</th><th>数量</th></tr>");
                                                        for (int j = 0; j< orderdetails.size(); j++){
                                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid())+
                                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                                    "</td></tr>");
                                                        }
                                                        out.print("</table></td></tr>");
                                                    }
                                                %>

                                            </table>
                                        </form>
                                    </div>
                                    <div class="swiper-slide swiper-no-swiping">
                                        <form>
                                            <table>
                                                <thead>
                                                <tr>

                                                    <th>订单id</th>
                                                    <th>生成时间</th>
                                                    <th>餐厅名称</th>
                                                    <th>配送地址</th>
                                                    <th>收货电话</th>

                                                </tr>
                                                </thead>
                                                <%
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
                                                                "<tr><th>菜品</th><th>数量</th></tr>");
                                                        for (int j = 0; j< orderdetails.size(); j++){
                                                            out.print("<tr><td>" +restaurantService.getFoodById(orderdetails.get(j).getFoodid())+
                                                                    "</td><td>" + orderdetails.get(j).getNum()+
                                                                    "</td></tr>");
                                                        }
                                                        out.print("</table></td></tr>");
                                                    }
                                                %>


                                            </table>
                                        </form>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </article>

                </section>
            </article>
        </div>
    </section>

</section>
<script>
    $(function() {
        function setCurrentSlide(ele, index) {
            $(".swiper1 .swiper-slide").removeClass("selected");
            ele.addClass("selected");
            //swiper1.initialSlide=index;
        }

        var swiper1 = new Swiper('.swiper1', {
//					设置slider容器能够同时显示的slides数量(carousel模式)。
//					可以设置为number或者 'auto'则自动根据slides的宽度来设定数量。
//					loop模式下如果设置为'auto'还需要设置另外一个参数loopedSlides。
            slidesPerView: 5.5,
            paginationClickable: true,//此参数设置为true时，点击分页器的指示点分页器会控制Swiper切换。
            spaceBetween: 10,//slide之间的距离（单位px）。
            freeMode: true,//默认为false，普通模式：slide滑动时只滑动一格，并自动贴合wrapper，设置为true则变为free模式，slide会根据惯性滑动且不会贴合。
            loop: false,//是否可循环
            onTab: function(swiper) {
                var n = swiper1.clickedIndex;
            }
        });
        swiper1.slides.each(function(index, val) {
            var ele = $(this);
            ele.on("click", function() {
                setCurrentSlide(ele, index);
                swiper2.slideTo(index, 500, false);
                //mySwiper.initialSlide=index;
            });
        });

        var swiper2 = new Swiper('.swiper2', {
            //freeModeSticky  设置为true 滑动会自动贴合
            direction: 'horizontal',//Slides的滑动方向，可设置水平(horizontal)或垂直(vertical)。
            loop: false,
//					effect : 'fade',//淡入
            //effect : 'cube',//方块
            //effect : 'coverflow',//3D流
//					effect : 'flip',//3D翻转
            autoHeight: true,//自动高度。设置为true时，wrapper和container会随着当前slide的高度而发生变化。
            onSlideChangeEnd: function(swiper) {  //回调函数，swiper从一个slide过渡到另一个slide结束时执行。
                var n = swiper.activeIndex;
                setCurrentSlide($(".swiper1 .swiper-slide").eq(n), n);
                swiper1.slideTo(n, 500, false);
            }
        });
    });
</script>
</body>
</html>