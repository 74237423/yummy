<%@ page import="model.Member" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Restaurant" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/25
  Time: 15:58
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
    Member member = (Member) session.getAttribute("member");
    List<Restaurant> restaurants= (List<Restaurant>) session.getAttribute("restaurantlist");
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
                    <li class="active">
                        <a rel="nofollow" href="/memberFindRes">外卖</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memberOrder">订单</a>
                    </li>
                    <li >
                        <a rel="nofollow" href="/memberPersonalData">个人信息</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memSum">历史统计</a>
                    </li>
                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>外卖</header>

                <section class="user-address-main">
                    <header>
                        <h2>餐厅列表</h2>
                    </header>
                    <article class="mb10">
                        <form action="/memberFindRes" method="post">
                            <table>
                                <thead>
                                <tr>

                                    <th>餐厅id</th>
                                    <th>名称</th>
                                    <th>种类</th>
                                    <th>地点</th>
                                    <th>操作</th>

                                </tr>
                                </thead>
                                <%
                                    for (int i=0;i<restaurants.size();i++){
                                        out.print("<tr><td>" +restaurants.get(i).getId()+
                                                "</td><td>" +restaurants.get(i).getName()+
                                                "</td><td>" +restaurants.get(i).getType()+
                                                "</td><td>" +restaurants.get(i).getDescription()+
                                                "</td><td><button type='submit' class='btn btn-success normal-btn' name='getRes' value='"
                                                +restaurants.get(i).getId()+
                                                "'>进入</button>"+
                                                "</td></tr>");
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