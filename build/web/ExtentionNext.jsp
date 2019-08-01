<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>展期申请结果</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
        <%
            int loanID = Integer.parseInt(request.getParameter("loanID"));
            int extention = Integer.parseInt(request.getParameter("extention"));
            int extendlength = Integer.parseInt(request.getParameter("extendlength"));
            Boolean flag = true;
            int rvalue = 0, rvalue2 = 0;
            if (extention == 1 && extendlength > 3) {
                flag = false;
        %>
    <alert>长期贷款申请展期不得超过3年！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (extention == 1 && extendlength == 0) {
                flag = false;
        %>
    <alert>展期申请填入的年数不合理！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (extention == 2 && (extendlength > 12 || extendlength == 0)) {
                flag = false;
        %>
    <alert>展期申请填入的月份数不合理！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (flag) {
                Connection connection;
                Statement stmt, stmt2;
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    connection = DriverManager.getConnection(uri, "root", "19960822");
                    stmt = connection.createStatement();
                    stmt2 = connection.createStatement();
                    ResultSet rs;
                    int typeone = 0;
                    int typetwo = 0;
                    int loanyear = 0;
                    int loanmonth = 0;
                    int loanday = 0;
                    rs = stmt.executeQuery("SELECT * FROM loaninfo WHERE loanID=" + loanID + " and (verified=" + 2 + " or verified=" + 3+")");
                    while (rs.next()) {
                        typetwo = rs.getInt(3);
                        typetwo = rs.getInt(4);
                        loanyear = rs.getInt(5);
                        loanmonth = rs.getInt(6);
                        loanday = rs.getInt(7);
                    }
                    if (typeone == 1 && extention == 1) {
                        flag = false;
        %>
    <alert>短期贷款展期不得超过原贷款期限！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (typeone == 2 && extention == 1) {
                flag = false;
        %>
    <alert>短期贷款展期不得超过原贷款期限！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (typeone == 1 && extention == 2 && loanmonth < extendlength) {
                flag = false;
        %>
    <alert>短期贷款展期不得超过原贷款期限！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            if (typetwo == 1) {//贷款类型为助学贷款
                //展期单位为年
                if (extention == 1) {
                    if (loanyear + extendlength > 8) {//合计超过8年
                        flag = false;
        %>
    <alert>个人助学贷款的贷款期限和展期合计超过8年！申请失败！自动跳转到上一页面中...</alert>
        <%
                    response.setHeader("Refresh", "3;URL=Extention.jsp");
                } else {//合计少于8年
                    rvalue = stmt2.executeUpdate("UPDATE payloan SET isExtend=1 WHERE loanID=" + loanID);
                    stmt2.executeUpdate("UPDATE loaninfo SET loanyear=loanyear+"+extendlength + " WHERE loanID=" + loanID);
                    rvalue2 = stmt2.executeUpdate("UPDATE payloan SET overduedate= " + "date_add(overduedate, interval " + extendlength + " year)" + "WHERE loanID=" + loanID);
                }
            }
            //展期单位为月
            if (extention == 2) {
                if (loanyear >= 8 || (loanyear == 7 && extendlength == 12)) {
                    flag = false;
        %>
    <alert>个人助学贷款的贷款期限和展期合计超过8年！申请失败！自动跳转到上一页面中...</alert>
        <%
                        response.setHeader("Refresh", "3;URL=Extention.jsp");
                    } else {
                        rvalue = stmt2.executeUpdate("UPDATE payloan SET isExtend=1 WHERE loanID=" + loanID);
                        stmt2.executeUpdate("UPDATE loaninfo SET loanmonth=loanmonth+"+extendlength + " WHERE loanID=" + loanID);
                        rvalue2 = stmt2.executeUpdate("UPDATE payloan SET overduedate= " + "date_add(overduedate, interval " + extendlength + " month)" + "WHERE loanID=" + loanID);
                    }
                }
            }

            if (typetwo == 2) {//贷款类型为住房贷款
                //展期单位为年
                if (extention == 1) {
                    if (loanyear + extendlength > 20) {//合计超过20年
                        flag = false;
        %>
    <alert>个人住房贷款的贷款期限和展期合计超过20年！申请失败！自动跳转到上一页面中...</alert>
        <%
                    response.setHeader("Refresh", "3;URL=Extention.jsp");
                } else {//合计少于20年
                    stmt2.executeUpdate("UPDATE loaninfo SET loanyear=loanyear+"+extendlength + " WHERE loanID=" + loanID);
                    rvalue = stmt2.executeUpdate("UPDATE payloan SET isExtend=1,overduedate= " + "date_add(overduedate, interval " + extendlength + " year)" + "WHERE loanID=" + loanID);
                }
            }
            //展期单位为月
            if (extention == 2) {
                if ((loanyear == 19 && (loanmonth + extendlength) > 12) || loanyear == 20) {
                    flag = false;
        %>
    <alert>个人住房贷款的贷款期限和展期合计超过20年！申请失败！自动跳转到上一页面中...</alert>
        <%
                        response.setHeader("Refresh", "3;URL=Extention.jsp");
                    } else {
                        int extendyear = 0;
                        if (loanmonth + extendlength > 12) {
                            extendyear = 1;
                            extendlength = loanmonth + extendlength - 12;
                        }
                        stmt2.executeUpdate("UPDATE loaninfo SET loanmonth=loanmonth+"+extendlength+",loanyear=loanyear+"+extendyear + " WHERE loanID=" + loanID);
                        rvalue = stmt2.executeUpdate("UPDATE payloan SET isExtend=1,overduedate= " + "date_add(overduedate, interval " + extendlength + " month)" + "WHERE loanID=" + loanID);
                        rvalue2 = stmt2.executeUpdate("UPDATE payloan SET overduedate= " + "date_add(overduedate, interval " + extendyear + " year)" + "WHERE loanID=" + loanID);
                    }
                }
            }

            if (typetwo == 3) {//贷款类型为自助贷款
                //展期单位为年
                if (extention == 1) {
                    flag = false;
        %>
    <alert>个人自助贷款的贷款期限和展期合计超过1年！申请失败！自动跳转到上一页面中...</alert>
        <%
                response.setHeader("Refresh", "3;URL=Extention.jsp");
            }
            //展期单位为月
            if (extention == 2) {
                if (loanmonth + extendlength > 12) {
                    flag = false;
        %>
    <alert>个人自助贷款的贷款期限和展期合计超过1年！申请失败！自动跳转到上一页面中...</alert>
        <%
                                response.setHeader("Refresh", "3;URL=Extention.jsp");
                            } else {
                                stmt2.executeUpdate("UPDATE loaninfo SET loanmonth=loanmonth+"+extendlength+ " WHERE loanID=" + loanID);
                                rvalue = stmt2.executeUpdate("UPDATE payloan SET isExtend=1 WHERE loanID=" + loanID);
                                rvalue2 = stmt2.executeUpdate("UPDATE payloan SET overduedate= " + "date_add(overduedate, interval " + extendlength + " month)" + "WHERE loanID=" + loanID);
                            }
                        }
                    }
                    connection.close();
                    stmt.close();
                } catch (SQLException e2) {
                    out.print(e2);
                }
            }
            if (rvalue > 0) {
        %>
    <alert>申请展期成功！</alert>
    <form action="Extention.jsp">
        <input type="submit" name="home" value="返回" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
    </form>
    <%
        }
    %>
</body>
</html>
