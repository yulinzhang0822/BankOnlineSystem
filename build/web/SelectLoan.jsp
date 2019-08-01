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
                return true;
            }
        </script>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
                    <center>
        <form name="form1" action="TakeLoanSolving.jsp" method="post" onsubmit="return checkform()">
                <b>
                    <font color="black" size="8" face="华文行楷">申请贷款</font>
                </b>
                <hr>
                <p>贷款期限：(1至8年)<br>
                    <select name="loanlength">
                        <option value="1">1年</option>
                        <option value="2">2年</option>
                        <option value="3">3年</option>
                        <option value="4">4年</option>
                        <option value="5">5年</option>
                        <option value="6">6年</option>
                        <option value="7">7年</option>
                        <option value="8">8年</option>
                    </select>
                </p>
                <p>贷款数额：(不能超过10万元)<br>
                    <input type="text" size="15" name="quantity" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"> 元(RMB)</p>
                <p>
                    贷款偿还方式：一次性利随本清
                    在贷款到期后一次性付清本金利息。<br>
                </p>
                添加审核资料：<input type="file" name="material" value="选择文件" style="background-color: transparent"/>
                <p>
                    <input type="submit" value="确认" name="submit" style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
                    <input type="reset" value="清空" name="reset" style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
                </p>
        </form>
        <br>
        <form action="SelectLoanTypetwo.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
        </form>
    </center>
</body>
</html>
