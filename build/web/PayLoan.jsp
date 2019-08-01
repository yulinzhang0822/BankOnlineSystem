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
        <title>贷款偿还</title>
        <script type="text/javascript">
            function checkform() {
                if (form1.extention.value === "") {
                    alert("请选择贷款编号！");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
        <%
            String  username = (String)session.getAttribute("username");//获取一卡通账号
            Connection con;
            Statement sql, sql2, sql3, sql4;
            ResultSet rs, rs2, rs3, rs4;
            Boolean flag = true;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String uri = "jdbc:mysql://localhost:3306/banksystem";
                con = DriverManager.getConnection(uri, "root", "19960822");
                sql = con.createStatement();
                rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and cardID="+username);
                if (!rs.next()) {
                    out.print("当前没有可偿还的贷款！");
                    flag = false;
                }
            } catch (SQLException e) {
                out.print(e);
            }
            if (flag) {
        %>
        <center>
            <h3>需偿还的贷款</h3>
        </center>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String uri = "jdbc:mysql://localhost:3306/banksystem";
                con = DriverManager.getConnection(uri, "root", "19960822");
                sql = con.createStatement();
                sql2 = con.createStatement();
                sql3 = con.createStatement();
                sql4 = con.createStatement();
                out.print("<table border=1>");
                out.print("<tr>");
                out.print("<th width=100>" + "贷款编号");
                out.print("<th width=100>" + "贷款类型");
                out.print("<th width=120>" + "偿还方式");
                out.print("<th width=135>" + "当前贷款利率(%)");
                out.print("<th width=120>" + "下次还款日期");
                out.print("<th width=180>" + "下次偿还本金(元RMB)");
                out.print("<th width=180>" + "下次偿还利息(元RMB)");
                out.print("<th width=180>" + "下次偿还总额(元RMB)");
                out.print("</tr>");
                rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and cardID="+username); 
                while (rs.next()) {
                    int typetwo = 0;
                    float rate = 0;
                    out.print("<tr>");
                    int loanID = rs.getInt(2);
                    out.print("<td>" + loanID + "</td>");//贷款编号
                    rs2 = sql2.executeQuery("SELECT * FROM loaninfo WHERE loanID=" + loanID);
                    while (rs2.next()) {
                        int tempint = rs2.getInt(4);
                        int tempint2 = rs2.getInt(10); 
                        if (tempint == 1) {
                            out.print("<td>" + "个人助学贷款" + "</td>");//贷款类型
                        }
                        if (tempint == 2) {
                            out.print("<td>" + "个人住房贷款" + "</td>");
                        }
                        if (tempint == 3) {
                            out.print("<td>" + "个人自助贷款" + "</td>");
                        }
                        if (tempint2 == 1) {
                            out.print("<td>" + "一次性利随本清" + "</td>");//偿还方式
                        }
                        if (tempint2 == 2) {
                            out.print("<td>" + "分期付息一次还本" + "</td>");
                        }
                        if (tempint2 == 3) {
                            out.print("<td>" + "等额本息" + "</td>");
                        }
                        if (tempint2 == 4) {
                            out.print("<td>" + "等额本金" + "</td>");
                        }
                        typetwo = rs2.getInt(4);
                        rate = rs2.getFloat(9);
                    }
                    out.print("<td>" + rate + "</td>");//贷款利率
                    out.print("<td>" + rs.getString(3).toString() + "</td>");//下次还款日期
                    out.print("<td>" + rs.getFloat(4) + "</td>");//下次偿还本金
                    out.print("<td>" + rs.getFloat(5) + "</td>");//下次偿还利息
                    float nexttotal = rs.getFloat(4)+rs.getFloat(5); 
                    out.print("<td>" + nexttotal + "</td>");//下次偿还总额
                    out.print("</tr>");
                }
                out.print("</table>");
                con.close();
            } catch (SQLException e1) {
                out.print(e1);
            }
        %>
        <br>
        <form name="form1" action="PayLoanNext.jsp" method="post" onsubmit="return checkform()">
            <strong>请选择要偿还的贷款编号:</strong>&nbsp;  
            <%
                Connection connection;
                Statement stmt;
                ResultSet result;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    connection = DriverManager.getConnection(uri, "root", "19960822");
                    stmt = connection.createStatement();
                    result = stmt.executeQuery("SELECT loanID FROM payloan WHERE ispaying=1 and cardID="+username); 
            %>
            <select name="loanID">
                <%
                    while (result.next()) {
                %>
                <option value="<%out.print(result.getInt("loanID"));%>"><%out.print(result.getInt("loanID"));%></option>
                <%
                    }
                %>
            </select>
            <%
                } catch (SQLException e2) {
                    out.print(e2);
                }
            %>
            <br>
            <br>
            <input type="submit" value="确定" name="confirm" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
        <%
            }
        %>
        <br>
        <form action="LoanHome.html">
            <input type="submit" name="home" value="返回贷款业务主界面" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
    </center>
</body>
</html>
