<%@ page import="model.Member" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Restaurant" %>
<%@ page import="model.Ordercheck" %>
<%@ page import="util.MathUtil" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/12
  Time: 1:07
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

    List<Member> members = (List<Member>) session.getAttribute("memberlist");
    List<Restaurant> restaurants = (List<Restaurant>) session.getAttribute("reslist");
    List<Ordercheck> orderchecks = (List<Ordercheck>) session.getAttribute("balabcedlist");
    List<Ordercheck> orderchecks1 = (List<Ordercheck>) session.getAttribute("returnlist");
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
                    <a rel="nofollow" draw-user>管理员<em></em></a>
                </li>
                <li class=""><a rel="nofollow"><form method='GET' action="/adminLogin">
                    <input type='submit' name='logout' value='logout'>
                </form></a></li>
            </ul>

        </div>
    </header>


    <section>
        <div class="user-center-main-box common-width clearfix">
            <aside class="fl">
                <ul>
                    <li class="active">
                        <a rel="nofollow" href="/adminHome">统计信息查看</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/adminPass">审批餐厅修改记录</a>
                    </li>
                    <li >
                        <a rel="nofollow" href="/adminBalance">餐厅订单结算</a>
                    </li>

                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>统计信息查看</header>

                <section class="user-address-main">


                    <article class="mb10">
                        <center>
                        <header>
                            <h2>所有注册餐厅</h2>
                        </header>
                    </center>
                        <table>
                            <thead>
                            <tr>
                                <th>餐厅id</th>
                                <th>名称</th>
                                <th>密码</th>
                                <th>种类</th>
                                <th>地址</th>
                                <th>收入(元)</th>
                            </tr>
                            </thead>
                            <%
                                if(restaurants.size()<1){
                                    out.print("<tr><td colspan='6'>系统暂无餐厅注册</td></tr>");
                                }
                                for (int i=0;i<restaurants.size();i++){
                                    out.print("<tr><td>" + restaurants.get(i).getId()+
                                            "</td><td>" + restaurants.get(i).getName()+
                                            "</td><td>" + restaurants.get(i).getPassword()+
                                            "</td><td>" + restaurants.get(i).getType()+
                                            "</td><td>" + restaurants.get(i).getDescription()+
                                            "</td><td>" +restaurants.get(i).getIncome()+
                                            "</td></tr>");
                                }
                            %>
                        </table>
                    </article>
                    <article>
                        <center>
                            <header class="mb10">
                                <h2>会员注册信息</h2>
                            </header>
                        </center>

                        <table>
                            <thead>
                            <tr>
                                <th>会员邮箱</th>
                                <th>用户名</th>
                                <th>密码</th>
                                <th>手机号</th>
                                <th>消费总额(元)</th>
                                <th>等级</th>
                                <th>是否注销</th>
                                <th>注册后是否激活</th>
                            </tr>
                            </thead>
                            <%
                                if(members.size()<1){
                                    out.print("<tr><td colspan='8'>系统暂无会员注册</td></tr>");
                                }
                                for (int i=0;i<members.size();i++){
                                    out.print("<tr><td>" + members.get(i).getEmail()+
                                            "</td><td>" + members.get(i).getName()+
                                            "</td><td>" + members.get(i).getPassword()+
                                            "</td><td>" + members.get(i).getPhone()+
                                            "</td><td>" + members.get(i).getTotal()+
                                            "</td><td>" + members.get(i).getViplevel()+
                                            "</td><td>" + members.get(i).getLogoff()+
                                            "</td><td>" + members.get(i).getActived()+
                                            "</td></tr>");
                                }
                            %>
                        </table>
                    </article>
                    <article>
                        <center>
                            <header class="mb10">
                                <h2>Yummy获利订单表</h2>
                            </header>
                        </center>

                        <table>
                            <thead>
                            <tr>
                                <th>订单id</th>
                                <th>订单生成时间</th>
                                <th>餐厅id</th>
                                <th>会员邮箱</th>
                                <th>是否退货</th>
                                <th>系统抽成(元)</th>

                            </tr>
                            </thead>
                            <%
                                double sum = 0;
                                if((orderchecks.size()+orderchecks1.size())<1){
                                    out.print("<tr><td colspan='6'>系统暂无获利</td></tr>");
                                }
                                for (int i=0;i<orderchecks.size();i++){
                                    sum += orderchecks.get(i).getEarn();
                                    out.print("<tr><td>" + orderchecks.get(i).getOrderid()+
                                            "</td><td>" + orderchecks.get(i).getDatetime()+
                                            "</td><td>" + orderchecks.get(i).getRestauranrid()+
                                            "</td><td>" + orderchecks.get(i).getMemberemail()+
                                            "</td><td>" + orderchecks.get(i).getReturned()+
                                            "</td><td>" + orderchecks.get(i).getEarn()+
                                            "</td></tr>");
                                }
                                for (int i=0;i<orderchecks1.size();i++){
                                    sum += orderchecks1.get(i).getEarn();
                                    out.print("<tr><td>" + orderchecks1.get(i).getOrderid()+
                                            "</td><td>" + orderchecks1.get(i).getDatetime()+
                                            "</td><td>" + orderchecks1.get(i).getRestauranrid()+
                                            "</td><td>" + orderchecks1.get(i).getMemberemail()+
                                            "</td><td>" + orderchecks1.get(i).getReturned()+
                                            "</td><td>" + orderchecks1.get(i).getEarn()+
                                            "</td></tr>");
                                }
                                MathUtil mathUtil = new MathUtil();
                                sum = mathUtil.twoDouble(sum);
                            %>

                        </table>
                        <header>
                            <h2>总盈利：<%=sum%>元</h2>
                        </header>
                    </article>
                </section>
            </article>
        </div>
    </section>

</section>


</body>
</html>
