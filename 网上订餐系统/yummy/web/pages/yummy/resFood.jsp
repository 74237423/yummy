<%@ page import="model.Member" %>
<%@ page import="model.Restaurant" %>
<%@ page import="model.Food" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lx
  Date: 2019/2/25
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <link rel="stylesheet" href="../../css/common.css?v=2015-5-20"/>
    <link rel="stylesheet" href="../../css/menuPage.css?v=2015-5-20"/>
</head>
<style type="text/css">
    table {
        table-layout:fixed;
    }
    td {
        white-space: nowrap; /*文本不会换行，文本会在在同一行上继续，直到遇到 <br> 标签为止。*/
        overflow: hidden; /*隐藏多余的内容*/
        text-overflow: ellipsis;
    }
    table td:hover { /* 鼠标滑过  显示隐藏的内容  伴有横向的滚动条 */
        overflow:auto;
        text-overflow:clip;
    }
    table.gridtable {
        font-family: verdana,arial,sans-serif;
        font-size:11px;
        color:#333333;
        border-width: 1px;
        border-color: #666666;
        border-collapse: collapse;
    }
    table.gridtable th {
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #666666;
        background-color: #dedede;
    }
    table.gridtable td {
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #666666;
        background-color: #ffffff;

    }
    table.gridtable td:hover{
        overflow:auto;
        text-overflow:clip;
    }

</style>

<body  class="day " ng-controller="bodyCtrl"  day-or-night>
<%
    Member member = (Member) session.getAttribute("member");
    Restaurant restaurant = (Restaurant) session.getAttribute("enterRes");
    List<Food> foodList = (List<Food>) session.getAttribute("foodlist");
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
                <li><a class="orderdetail-center"  rel="nofollow">等级：<%=member.getViplevel()%></a></li>
                <li><a class="orderdetail-center"  rel="nofollow">余额：<%=member.getMoney()%></a></li>
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




        <section class="menupage-main common-width" ng-init="city_name='上海'">

            <header class="nav clearfix">
                <div class="fl clearfix nav-des">
                    <div class="fl nav-des-text">
                        <h2 class="ellipsis" style="font-size: 15px"><%=restaurant.getName()%></h2>

                    </div>
                </div>
                <div class="fr clearfix nav-right">

                    <div class="fl nav-right-blast line-right">
                        <p><span style="font-size:12px;color:#999;"><%=restaurant.getDescription()%></span></p>
                    </div>


                </div>
            </header>
            <ul class="clearfix menu-nav-list" scroll-position-static="160">
                <li class="active"><a>菜单</a></li>
            </ul>

            <section class="main-box clearfix" lazy-img-load>
                <div class="main fl">
                    <div class="inner-main">


                        <div id="menu-main" class="menu-main">
                            <table  class="gridtable" >
                                <tr>
                                    <!--文本th-->
                                    <th>菜品id</th>
                                    <th>名称</th>
                                    <th>种类</th>
                                    <th>单价(元)</th>
                                    <th>描述</th>
                                    <th>剩余</th>
                                    <th>操作</th>
                                </tr>

                                <%
                                    if(foodList.size()<1){
                                        out.print("<tr><td colspan='7'>该餐厅暂无菜品</td></tr>");
                                    }
                                    for (int i=0;i<foodList.size();i++){
                                        out.print("<tr><td>" +foodList.get(i).getId()+
                                                "</td><td>" +foodList.get(i).getName()+
                                                "</td><td>" +foodList.get(i).getType()+
                                                "</td><td>" +foodList.get(i).getPrice()+
                                                "</td><td>" +foodList.get(i).getDescription()+
                                                "</td><td>" +foodList.get(i).getQuantity()+
                                                "</td><td align='center'><input type='button' value='加入购物车' onclick='add_shoppingcar(this)'/>"+
                                                "</td></tr>"
                                        );
                                    }
                                %>
                            </table>

                        </div>
                    </div>
                </div>
                <aside class="fl">
                    <article class="cart" scroll-position-static="160" top="42">
                        <div class="menu-cart">
                            <header>
                                <!-- <h4 class="ellipsis w100p" title="[半价菜][送可乐]樱花日本料理">[半价菜][送可乐]樱花日本料理</h4> -->
                                <h5>
                                    购物车
                                </h5>

                            </header>
                            <section>
                                <form action="/memberPay" method="get">
                                    <table  class="gridtable">
                                        <colgroup>
                                            <col width="30px">
                                            <col width="25px">
                                            <col width="75px">
                                            <col width="23px">
                                            <col width="23px">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th >单价</th>
                                            <th>数量</th>
                                            <th>金额</th>
                                            <th>删除</th>
                                        </tr>
                                        </thead>
                                        <tbody id="goods">

                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <td colspan="3" align="center" >总计</td>
                                            <td id="total">0</td>
                                            <td>元</td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                    <br>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="submit">结算</button>
                                </form>
                            </section>
                        </div>

                        <article class="restaurant-notice">
                            <header>
                                Yummy活动
                            </header>
                            <section>
                                <ul>

                                    <li><span>餐厅仅支持在线支付</span></li>

                                    <li><span>等级3的会员打8折</span></li>

                                    <li><span>等级2的会员打9折</span></li>

                                    <li><span>折后满50减5元</span></li>


                                </ul>
                            </section>
                        </article>

                    </article>
                </aside>
            </section>
            <span id="element" style="position:absolute;display:none" class="badge">1</span>

        </section>

    </div>
</section>


</body>
<script type="text/javascript">
    //this js中指当前对象
    function add_shoppingcar(btn){
        var tr=btn.parentNode.parentNode;
        var tds=tr.getElementsByTagName("td");
        var id = tds[0].innerHTML;
        var name=tds[1].innerHTML;
        var price=tds[3].innerHTML;
        var tbody=document.getElementById("goods");
        var row=tbody.insertRow();//insertRow表格开头插入新行
        row.innerHTML=
            "<td><input type='hidden' name='foodid' value='"+id+"'>"+name+"</td>"+
            "<td>"+price+"</td>"+
            "<td align='center'>"+
            "<input type='button' value='-' id='jian'  onclick='change(this,-1)'  />"+
            "<input id='text' type='text' size='1' value='1' name='number' readonly='readonly'/>"+
            "<input type='button' value='+' id='add'  onclick='change(this,1)'  />"+
            "</td>"+
            "<td>"+price+"</td>"+
            "<td align='center'>"+
            "<input type='button' value='X' onclick='del(this)'/>"+
            "</td>"+
            "</tr>";
        total();
    }
    //增加减少数量，用n正负1来表示点击了加减按钮
    function change(btn,n){
        //获取数量的三个input对象
        var inputs = btn.parentNode.getElementsByTagName("input");
        //获取原来的数量
        var amount = parseInt(inputs[1].value);
        //当amount=1时不能再点击"-"符号
        //用n<0来表示点击了减button
        if(amount<=1 && n<0){
            return;
        }
        //根据加减来改变数量
        inputs[1].value = amount + n;
        //将改变后的数量值赋值给amount
        amount = inputs[1].value;
        //获取表格中的行
        var tr = btn.parentNode.parentNode;
        //获取所有的列
        var tds = tr.getElementsByTagName("td");
        //获取单价
        var price = parseFloat(tds[1].innerHTML);
        //总价=单价*数量
        var m = price * amount;
        //将总价赋值给相应的位置
        tds[3].innerHTML = m;
        //调用total方法，求总计
        total();
    }


    function total(){
        var tbody=document.getElementById("goods");
        var trs=tbody.getElementsByTagName("tr");
        var sum=0;
        for(var i=0;i<trs.length;i++){
            var tds=trs[i].getElementsByTagName("td");
            var m=tds[3].innerHTML;
            sum += parseFloat(m);
        }
        var total=document.getElementById("total");
        total.innerHTML = sum;
    }
    function del(i){
        var tr=i.parentNode.parentNode;
        tr.parentNode.removeChild(tr);
        //tr.remove(tr);
        total();
    }
</script>
</html>