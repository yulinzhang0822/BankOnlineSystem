<%-- 
    Document   : TakeLoan
    Created on : 2018-6-6, 8:26:40
    Author     : LeonardZhang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date;"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>申请展期</title>
        <script type="text/javascript">
            function checkform() {
                if (form1.extention.value === "") {
                    alert("请输入展期时间！");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
                        <b>
            <font color="black" size="8" face="华文行楷">可申请展期的贷款</font>
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
                rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and isExtend=0 and isOverdue=0 and cardID="+username); 
                if (!rs.next()) {
                    out.print("当前没有可申请展期的贷款！");
                    flag = false;
                }
            } catch (SQLException e) {
                out.print(e);
            }
            if (flag) {
        %>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String uri = "jdbc:mysql://localhost:3306/banksystem";
                con = DriverManager.getConnection(uri, "root", "19960822");
                sql = con.createStatement();
                sql2 = con.createStatement();
                sql3 = con.createStatement();
                out.print("<table border=1>");
                out.print("<tr>");
                out.print("<th width=100>" + "贷款编号");
                out.print("<th width=100>" + "贷款类型");
                out.print("<th width=100>" + "贷款数额(元)");
                out.print("<th width=120>" + "偿还方式");
                out.print("<th width=120>" + "贷款到期日期");
                out.print("<th width=120>" + "下次还款日期");
                out.print("</tr>");
                rs = sql.executeQuery("SELECT * FROM payloan WHERE ispaying=1 and isExtend=0 and isOverdue=0 and cardID="+username); 
                while (rs.next()) {
                    out.print("<tr>");
                    int loanID = rs.getInt(2);
                    out.print("<td>" + loanID + "</td>");
                    rs2 = sql2.executeQuery("SELECT * FROM loaninfo WHERE loanID=" + loanID + " and (verified=" + 2 + " or verified=" + 3 + ")");
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
                        int loanyear = rs2.getInt(5);
                        int loanmonth = rs2.getInt(6);
                        int loanday = rs2.getInt(7);
                        rs3 = sql3.executeQuery("SELECT * FROM loaning WHERE loanID=" + loanID);
                        while (rs3.next()) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            String str = rs3.getString(3);
                            Calendar rightNow = Calendar.getInstance();
                            try {
                                Date dt = sdf.parse(str);
                                rightNow.setTime(dt);
                            } catch (Exception e) {
                                System.out.print(e);
                            }
                            rightNow.add(Calendar.YEAR, loanyear);
                            rightNow.add(Calendar.MONTH, loanmonth);
                            rightNow.add(Calendar.DAY_OF_YEAR, loanday);
                            Date dt1 = rightNow.getTime();
                            String reStr = sdf.format(dt1);
                            out.print("<td>" + reStr + "</td>");
                        }
                    }
                    out.print("<td>" + rs.getString(3).toString() + "</td>");
                    out.print("</tr>");
                }
                out.print("</table>");
                con.close();
            } catch (SQLException e1) {
                out.print(e1);
            }
        %>
        <br>
        <form name="form1" action="ExtentionNext.jsp" method="post" onsubmit="return checkform()">
            <strong>请选择需要申请展期的贷款编号:</strong>&nbsp;  
            <%
                Connection connection;
                Statement stmt;
                ResultSet result;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    connection = DriverManager.getConnection(uri, "root", "19960822");
                    stmt = connection.createStatement();
                    result = stmt.executeQuery("SELECT loanID FROM payloan WHERE ispaying=1 and isExtend=0 and isOverdue=0 and cardID="+username);
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
            <strong>请输入展期时间:</strong>&nbsp;  
            <input type="text" name="extendlength" size="1" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"/>
            <select name="extention">
                <option value="1">年</option>
                <option value="2">月</option>
            </select>
            <br>
            <input type="submit" value="确定" name="confirm" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
            <input type="reset" value="清空" name="reset" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
            <br>
        <form action="CheckLoaning.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;font-size:20px;height:60px;width:200px" />
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
