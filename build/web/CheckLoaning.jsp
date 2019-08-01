<%-- 
    Document   : TakeLoan
    Created on : 2018-6-6, 8:26:40
    Author     : LeonardZhang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>当前贷款进度</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
                <b>
            <font color="black" size="8" face="华文行楷">暂未还清贷款</font>
        </b>
        <hr>
        <%
            String  username = (String)session.getAttribute("username");//获取一卡通账号
            Connection con;
            Statement sql, sql2, sql3;
            ResultSet rs, rs2, rs3;
            Boolean flag = true;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String uri = "jdbc:mysql://localhost:3306/banksystem";
                con = DriverManager.getConnection(uri, "root", "19960822");
                sql = con.createStatement();
                sql2 = con.createStatement();
                sql3 = con.createStatement();
                rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and cardID="+username);
                if (!rs.next()) {
                    out.print("当前无贷款！");
                    flag = false;
                }
                if (flag) {
                    out.print("<table border=1>");
                    out.print("<tr>");
                    out.print("<th width=100>" + "贷款编号");
                    out.print("<th width=100>" + "贷款类型");
                    out.print("<th width=100>" + "贷款数额(元)");
                    out.print("<th width=120>" + "偿还方式");
                    out.print("<th width=120>" + "首次放款日期");
                    out.print("<th width=120>" + "下次还款日期");
                    out.print("<th width=120>" + "是否已展期");
                    out.print("<th width=120>" + "是否已逾期");
                    out.print("</tr>");
                    rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and cardID="+username);
                    while (rs.next()) {
                        out.print("<tr>");
                        int loanID = rs.getInt(2);
                        out.print("<td>" + loanID + "</td>");
                        rs2 = sql2.executeQuery("SELECT * FROM loaninfo WHERE loanID=" + loanID);
                        while (rs2.next()) {
                            int tempint = rs2.getInt(4);
                            if (tempint == 1) {
                                out.print("<td>" + "个人助学贷款" + "</td>");
                            }
                            if (tempint == 2) {
                                out.print("<td>" + "个人住房贷款" + "</td>");
                            }
                            if (tempint == 3) {
                                out.print("<td>" + "个人自助贷款" + "</td>");
                            }
                            out.print("<td>" + rs2.getFloat(8) + "</td>");
                            tempint = rs2.getInt(10);
                            if (tempint == 1) {
                                out.print("<td>" + "一次性利随本清" + "</td>");
                            }
                            if (tempint == 2) {
                                out.print("<td>" + "分期付息一次还本" + "</td>");
                            }
                            if (tempint == 3) {
                                out.print("<td>" + "等额本息" + "</td>");
                            }
                            if (tempint == 4) {
                                out.print("<td>" + "等额本金" + "</td>");
                            }
                            rs3 = sql3.executeQuery("SELECT * FROM loaning WHERE loanID=" + loanID);
                            while (rs3.next()) {
                                out.print("<td>" + rs3.getString(3).toString() + "</td>");
                            }
                        }
                        out.print("<td>" + rs.getString(3).toString() + "</td>");
                        int isExtend = rs.getInt(9);
                        if (isExtend == 0) {
                            out.print("<td>" + "否" + "</td>");
                        } else {
                            out.print("<td>" + "是" + "</td>");
                        }
                        int isOverdue = rs.getInt(10);
                        if (isOverdue == 0) {
                            out.print("<td>" + "否" + "</td>");
                        } else {
                            out.print("<td>" + "是" + "</td>");
                        }
                        out.print("</tr>");
                    }
                }
                out.print("</table>");
                con.close();
            } catch (SQLException e1) {
                out.print(e1);
            }
        %>
        <br>
        <form action="Extention.jsp">
            <input type="submit" name="home" value="申请展期" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
        <br>
        <form action="PayLoan.jsp">
            <input type="submit" name="home" value="贷款偿还" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
        <br>
        <form action="LoanHome.html">
            <input type="submit" name="home" value="返回贷款业务主界面" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
    </center>
</body>
</html>
