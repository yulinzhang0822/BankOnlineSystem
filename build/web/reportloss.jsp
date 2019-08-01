<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.user" %>
<%@ page import="com.ConnDB" %>

<html>
    <head>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
        <form name=loginForm action="reportloss.jsp" method=post>
            <table align="center">
                <tr>
                    <td>初始密码：</td><td><input type=text name=pwd
                                             /></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="确认挂失" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
                    </td>
                </tr>        
            </table>

        </form>
        <form action="mainmenu.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
        </form>
    </center>
    </body>
</html>

<%
    String pwd = request.getParameter("pwd");
    if (pwd == null) {
    } else {

        try {
            ConnDB conn = new ConnDB();
            Connection con = conn.getConn();
            Statement statement = con.createStatement();
            String sql1 = "select * from card where id=" + user.user;
            String sql2 = "update card set loss=1 where id=" + user.user;
            ResultSet rs = statement.executeQuery(sql1);
            rs.next();
            String dbpwd = rs.getString("password");

            if (dbpwd.equals(pwd)) {
                statement.executeUpdate(sql2);
                out.print("挂失成功！");
            } else {
                out.print("初始密码输入错误");
            }

            rs.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>

