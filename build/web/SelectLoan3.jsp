<%-- 
    Document   : TakeLoan
    Created on : 2018-6-6, 8:26:40
    Author     : LeonardZhang
--%>

<%@ page contentType="text/html" language="java"  pageEncoding="UTF-8"  %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>申请贷款</title>
        <script type="text/javascript">
            function checkform() {
                if (form1.quantity.value == "") {
                    alert("请输入贷款额度！");
                    return false;
                }
                if (form1.price.value == "") {
                    alert("请输入质押存款金额！");
                    return false;
                }
                if (form1.loanlength.value == "") {
                    alert("请输入贷款期限！");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
                                <b>
                    <font color="black" size="8" face="华文行楷">申请贷款</font>
                </b>
                <hr>
        <form name="form1" action="TakeLoanSolving3.jsp" method="post" onsubmit="return checkform()">
            <p>贷款期限：(最短1天，最多1年)<br>
                <input type="text" name="loanlength" size="3" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"/>
                <select name="monthday">
                    <option value="month">个月</option>
                    <option value="day">天</option>
                </select>
            </p>
            <p>质押存款金额：<br>
                <input type="text" size="15" name="price" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"> 元(RMB)</p>
            <p>
            <p>贷款数额(最低起贷1000元，不得超过质押存款金额的90%)：<br>
                <input type="text" size="15" name="quantity" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"> 元(RMB)</p>
            <p>
                贷款偿还方式：一次性利随本清
                在贷款到期后一次性付清本金利息。<br>
            </p>
            <p>
                <input type="submit" value="确认" name="submit" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
                <input type="reset" value="清空" name="reset" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
            </p>
        </form>
        <form action="SelectLoanTypetwo.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
    </center>
    </body>
</html>
