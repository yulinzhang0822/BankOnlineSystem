<%@page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.sql.*" %>
<%@ page import="com.user" %>
<%@ page import="com.ConnDB" %>

<!-- 内嵌java代码，主要控制逻辑跳转 -->
<% 
    String prepwd = request.getParameter("prepwd");
    String lastpwd = request.getParameter("lastpwd");

    
    try
    {
            ConnDB conn=new ConnDB(); 
            Connection con=conn.getConn(); 
            Statement statement = con.createStatement();
            String sql1 = "select * from card where id="+user.user;
            String sql2="update card set password="+lastpwd+" where id="+user.user;
            ResultSet rs= statement.executeQuery(sql1); 
            rs.next();
            String dbpwd=rs.getString("password");
            
            if(dbpwd.equals(prepwd))
            {
                statement.executeUpdate(sql2);
                out.print("密码修改成功！");
            }

            else
            {
                out.print("初始密码输入错误");
            }
             
             
             
             rs.close();
             con.close();
    }
        
     catch(Exception e)
    {
            e.printStackTrace();
    }
        
    
%>