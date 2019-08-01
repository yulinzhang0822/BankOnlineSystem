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
         <link rel="stylesheet" type="text/css" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>申请贷款</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
                <b>
            <font color="black" size="8" face="华文行楷">选择贷款类型</font>
        </b>
        <hr>
        <table>
        <form name="form1" method="post" action="SelectLoan.jsp">
            <p>
                <input type="submit" value="个人助学贷款" name="submit"  style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
            </p>
        </form>
        <form name="form2" method="post" action="SelectLoan2.jsp">
            <p>
                <input type="submit" value="个人住房贷款" name="submit"  style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
            </p>
        </form>
        <form name="form3" method="post" action="SelectLoan3.jsp">
            <p>
                <input type="submit" value="个人自助贷款" name="submit"  style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red"/>
            </p>
        </form>
        <form action="LoanHome.html">
            <input type="submit" name="home" value="返回贷款主界面"  style="background-color: transparent;font-size:20px;height:60px;width:200px;color:red" />
        </form>
        </table>
    </center>
    </body>
</html>
