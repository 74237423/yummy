<%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/20
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%

    int resid = (int) session.getAttribute("resid");
%>
<center>
    <h2>餐厅注册成功</h2>
    <h3>您餐厅唯一7位识别码为：<span><%=resid%></span></h3>
    <a href="/resLogin">返回登录</a>
</center>

</body>
</html>
