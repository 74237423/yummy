<%@ page import="model.Ordercheck" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/24
  Time: 22:05
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
    List<Ordercheck> ordercheckList = (List<Ordercheck>) session.getAttribute("needBalance");
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
                    <li>
                        <a rel="nofollow" href="/adminHome">统计信息查看</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/adminPass">审批餐厅修改记录</a>
                    </li>
                    <li  class="active">
                        <a rel="nofollow" href="/adminBalance">餐厅订单结算</a>
                    </li>

                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>餐厅订单结算</header>

                <section class="user-address-main">
                    <header>
                        <h2>订单结算表</h2>
                    </header>
                    <article class="mb10">
                        <form action="/adminBalance" method="post">
                            <table>
                                <thead>
                                <tr>
                                    <th>订单id</th>
                                    <th>订单生成时间</th>
                                    <th>餐厅id</th>
                                    <th>用户邮箱</th>
                                    <th>总价</th>
                                    <th>获利</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    for (int i=0;i<ordercheckList.size();i++){
                                        out.print("<tr><td>" +ordercheckList.get(i).getOrderid()+
                                                "</td><td>" +ordercheckList.get(i).getDatetime()+
                                                "</td><td>" +ordercheckList.get(i).getRestauranrid()+
                                                "</td><td>" +ordercheckList.get(i).getMemberemail()+
                                                "</td><td>" +ordercheckList.get(i).getTotalprice()+
                                                "</td><td>" +ordercheckList.get(i).getEarn()+
                                                "</td><td><button type='submit'class='btn btn-success normal-btn' name='balanceOrder' value='"
                                                +ordercheckList.get(i).getOrderid()+
                                                "'>结算</button></td></tr>" );
                                    }
                                %>
                            </table></form>
                    </article>

                </section>
            </article>
        </div>
    </section>

</section>


</body>
</html>