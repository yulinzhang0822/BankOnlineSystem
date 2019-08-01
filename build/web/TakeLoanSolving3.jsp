<%-- 
    Document   : TakeLoanSolved
    Created on : 2018-6-6, 19:01:42
    Author     : LeonardZhang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>申请自助贷款</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
        <%
            String  username = (String)session.getAttribute("username");//获取一卡通账号
            Boolean flag = true;
            float quantity = Float.parseFloat(request.getParameter("quantity"));
            float price = Float.parseFloat(request.getParameter("price"));
            String monthday = request.getParameter("monthday");
            int loanlength = Integer.parseInt(request.getParameter("loanlength"));
            if (quantity > price * 0.9) {
                flag = false;
        %>
    <alert>个人住房贷款额度不得超过质押存款金额的90%！申请失败！自动跳转回上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=SelectLoan3.jsp");
            }
            if (monthday.equals("month") && (loanlength > 12 || loanlength == 0)) {
                flag = false;
        %>
    <alert>个人自助贷款期限填入的月份数不合理！申请失败！自动跳转回上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=SelectLoan3.jsp");
            }
            if (monthday.equals("day") && (loanlength > 365 || loanlength == 0)) {
                flag = false;
        %>
    <alert>个人自助贷款期限填入的天数不合理！申请失败！自动跳转回上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=SelectLoan3.jsp");
            }
            if (flag) {
                float rate = 0;
                int typeone = 0;
                int days = 0, months = 0;
                if (monthday.equals("month") && loanlength <= 6) {
                    typeone = 1;
                    months = loanlength;
                    days = 0;
                }
                if (monthday.equals("month") && loanlength <= 12) {
                    typeone = 2;
                    months = loanlength;
                    days = 0;
                }
                if (monthday.equals("day")) {
                    months = loanlength / 30;
                    days = loanlength % 30;
                    if (months <= 6) {
                        if (days == 0) {
                            typeone = 1;
                        }
                        if (days > 0) {
                            typeone = 2;
                        }
                    }
                    if (months > 6) {
                        typeone = 2;
                    }
                }
                Connection con;
                Statement sql;
                ResultSet rs;
                int rvalue = 0;
                int rateID = 0;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    con = DriverManager.getConnection(uri, "root", "19960822");
                    sql = con.createStatement();
                    rs = sql.executeQuery("SELECT MAX(rateID) FROM rate");
                    while (rs.next()) {
                        rateID = rs.getInt(1);
                    }
                    rs = sql.executeQuery("SELECT * FROM rate WHERE rateID=" + rateID);
                    while (rs.next()) {
                        rate = rs.getFloat(typeone + 2);
                    }
                    rvalue = sql.executeUpdate("INSERT INTO loaninfo VALUES(" + username + "," + "now()" + "," + typeone + "," + 3 + "," + 0 + "," + months + "," + days + "," + quantity + "," + rate + "," + 1 + "," + 4 + "," + null + ")");
                    con.close();
                } catch (SQLException e1) {
                    out.print(e1);
                }
                if (rvalue > 0) {
                    out.print("申请成功！请等待发放贷款！");
                    response.setHeader("Refresh", "3;URL=LoanHome.html");
                }
            }
        %>
</body>
</html>
