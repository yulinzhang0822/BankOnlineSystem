<%@page contentType="text/html; charset=gbk"%> 
<%@ page import="java.sql.*" %>
<%@ page import="com.user" %>
<%@ page import="com.ConnDB" %>

<!-- ��Ƕjava���룬��Ҫ�����߼���ת -->
<%
    String username = request.getParameter("username");
    String pwd = request.getParameter("pwd");
    user.user = username;
    session.setAttribute("username",username);//zyl��ӣ����ڽ�username���͵����ҳ�� 
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