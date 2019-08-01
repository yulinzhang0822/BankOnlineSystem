<%@page contentType="text/html; charset=gbk"%> 
<%@ page import="java.sql.*" %>
<%@ page import="com.user" %>
<%@ page import="com.ConnDB" %>

<!-- 内嵌java代码，主要控制逻辑跳转 -->
<%
    String username = request.getParameter("username");
    String pwd = request.getParameter("pwd");
    user.user = username;
    session.setAttribute("username",username);//zyl添加，用于将username传送到多个页面 
    try {
        ConnDB conn = new ConnDB();
        Connection con = conn.getConn();
        Statement statement = con.createStatement();
        String sql = "select * from card";
        ResultSet rs = statement.executeQuery(sql);
        String id = null;
        String password = null;
        int flag = 0;
        while (rs.next()) {
            id = rs.getString("id");
            password = rs.getString("password");
            if (username.equals(id) && pwd.equals(password)) {
                flag = 1;
                break;
            }
        }

        if (flag == 1) {
            pageContext.forward("mainmenu.jsp");
        } else {
            pageContext.forward("login.jsp");
        }

        rs.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }


%>