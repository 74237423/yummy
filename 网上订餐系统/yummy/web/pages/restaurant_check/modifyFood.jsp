<%@ page import="model.Restaurant" %>
<%@ page import="model.Food" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/27
  Time: 19:27
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
    Food food = (Food) session.getAttribute("modifyfood");
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
                    <li class="active">
                        <a rel="nofollow" href="/resMenu">菜单</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/resOrder">订单</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/resSum">历史统计</a>
                    </li>
                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>修改菜品</header>

                <section class="user-address-main">

                    <article class="mb10">
                        <section class="add-address-box">
                            <form action="/modifyFood" method="post">
                                <br>
                                <div class="form-group mb10 row">
                                    <label class="col-2">餐厅ID & 名称：</label>
                                    <div class="col-6">
                                        <input type="text"  maxlength="10" name="resid"  readonly="readonly" value="<%=restaurant.getId()%> & <%=restaurant.getName()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb10 row">
                                    <label class="col-2">菜品名称：</label>
                                    <div class="col-6">
                                        <input type="text"  name="foodname" value="<%=food.getName()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">单价(元)：</label>
                                    <div class="col-6">
                                        <input type="text"  name="foodprice" value="<%=food.getPrice()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">种类：</label>
                                    <div class="col-6">
                                        <input type="text"  name="foodtype" value="<%=food.getType()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">描述：</label>
                                    <div class="col-6">
                                        <input type="text"  name="description" value="<%=food.getDescription()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">库存：</label>
                                    <div class="col-6">
                                        <input type="text" oninput="this.value=this.value.replace(/[^\d.]/g,'')"  name="left" value="<%=food.getQuantity()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2"></label>
                                    <div class="col-8">
                                        <button class="btn btn-success normal-btn" type="submit">
                                            确认
                                        </button>
                                        <button class="btn normal-btn" >
                                            <a href="/resMenu">取消</a>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </section>
                    </article>

                </section>
            </article>
        </div>
    </section>

</section>

</body>
</html>