<%@ page import="model.Member" %>
<%@ page import="util.MathUtil" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/25
  Time: 15:28
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
    String email = (String) session.getAttribute("email");
    Member member = (Member) session.getAttribute("member");
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
                    <li>
                        <a rel="nofollow" href="/memberOrder">我的订单</a>
                    </li>
                    <li class="active">
                        <a rel="nofollow" href="/memberPersonalData">个人信息</a>
                    </li>
                    <li>
                        <a rel="nofollow" href="/memSum">历史统计</a>
                    </li>
                </ul>
            </aside>
            <article class="fl user-center-main">
                <header>个人信息</header>

                <section class="user-address-main">

                    <article>
                        <section class="add-address-box">
                            <form method="post" action="/memberModifyData">
                                <br>
                                <div class="form-group mb10 row">
                                    <label class="col-2">姓名：</label>
                                    <div class="col-6">
                                        <input type="text" required maxlength="10" name="name" value="<%=member.getName()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb10 row">
                                    <label class="col-2">密码：</label>
                                    <div class="col-6">
                                        <input type="text" required maxlength="10" name="password" value="<%=member.getPassword()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb10 row">
                                    <label class="col-2">收货地址：</label>
                                    <div class="col-6">
                                        <input type="text"  name="address" value="<%=member.getAddress()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb10 row">
                                    <label class="col-2">手机号码：</label>
                                    <div class="col-6">
                                        <input type="text" maxlength="11"  mobile name="phone" value="<%=member.getPhone()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">邮箱：</label>
                                    <div class="col-6">
                                        <input type="text" required name="email" value="<%=member.getEmail()%>" disabled="disabled"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">余额(元)：</label>
                                    <div class="col-6">
                                        <input type="text" required name="money" disabled="disabled" value="<%=mathUtil.twoDouble(member.getMoney())%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">消费(元)：</label>
                                    <div class="col-6">
                                        <input type="text" required name="cost" disabled="disabled" value="<%=mathUtil.twoDouble(member.getTotal())%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2">等级：</label>
                                    <div class="col-6">
                                        <input type="text" required name="level"  disabled="disabled" value="<%=member.getViplevel()%>"/>
                                    </div>
                                </div>
                                <div class="form-group mb30 row">
                                    <label class="col-2"></label>
                                    <div class="col-8">
                                        <button  class="btn btn-success normal-btn" type="submit">确认修改</button>
                                        <button class="btn normal-btn" type="submit" formaction='/logoff'>
                                            注销账号
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