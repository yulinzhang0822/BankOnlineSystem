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
        <title>申请助学贷款</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
        <%
            String  username = (String)session.getAttribute("username");//获取一卡通账号
            Boolean flag = true;
            float quantity = Float.parseFloat(request.getParameter("quantity"));
            if (quantity > 100000) {
                flag = false;
        %>
    <alert>个人助学贷款额度不得超过10万元！申请失败！自动跳转回上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=SelectLoan.jsp");
            }
            if (flag) {
                int loanlength = Integer.parseInt(request.getParameter("loanlength"));
                float rate = 0;
                int rateID=0;
                int typeone = 0;
                if (loanlength >= 1 && loanlength <= 3) {
                    typeone = 3;
                } else if (loanlength > 3 && loanlength <= 5) {
                    typeone = 4;
                } else if (loanlength > 5) {
                    typeone = 5;
                }
                Connection con;
                Statement sql,sql2;
                ResultSet rs,rs2;
                int rvalue = 0;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    con = DriverManager.getConnection(uri, "root", "19960822");
                    sql = con.createStatement();
                    rs=sql.executeQuery("SELECT MAX(rateID) FROM rate");
                    while(rs.next()){
                        rateID=rs.getInt(1);
                    }
                    rs=sql.executeQuery("SELECT * FROM rate WHERE rateID="+rateID);
                    while(rs.next()){
                        rate = rs.getFloat(typeone+2);
                    }
                    sql2=con.createStatement();
                    rvalue = sql2.executeUpdate("INSERT INTO loaninfo VALUES(" + username + "," + "now()" + "," + typeone + "," + 1 + "," + loanlength + "," + 0 + "," + 0 + "," + quantity + "," + rate + "," + 1 + "," + 1 + "," + null + ")"); 
                    con.close();
                } catch (SQLException e1) {
                    out.print(e1);
                }
                if (rvalue > 0) {
                    out.print("申请成功！请等待处理合同！");
                    response.setHeader("Refresh", "3;URL=LoanHome.html");
                }
            }
        %>
</body>
</html>
