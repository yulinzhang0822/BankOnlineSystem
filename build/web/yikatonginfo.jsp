<%@page contentType="text/html; charset=gbk"%> 
<%@ page import="java.sql.*" %>  
<%@ page import="com.ConnDB" %>
<%@ page import="com.user" %>


<html>
  <div align="center"> 
     一卡通账户信息
</div> 
    <br><br> 

    <body style="background:url(Image/playground.jpg);background-size:cover;"><center>
<table border align='center'>
     <tr><td>子账户名称</td><td>币种</td><td>余额</td><td>存期</td><td>起息日</td></tr>
<% 
   try
    {
        ConnDB conn=new ConnDB(); 
        Connection con=conn.getConn(); 
        Statement statement = con.createStatement();
        String sql = "select * from account where id="+user.user;
        ResultSet rs = statement.executeQuery(sql); 
        
        
        while(rs.next())
        {
            out.print("<tr align='center'>");
            out.print("<td>"+rs.getString("subnumber"));
            out.print("<td>"+rs.getString("moneytype"));
            out.print("<td>"+rs.getString("money"));
            out.print("<td>"+rs.getString("deadline"));
            out.print("<td>"+rs.getString("startdate"));
            out.print("</tr>");
        }
     
        rs.close();
        statement.close();
        con.close();
    }
        
     catch(Exception e)
    {
        e.printStackTrace();
    }  
%>

</table>
<br><br>
                <form action="mainmenu.jsp">
            <input type="submit" name="home" value="返回" style="font-size:16px;background-color: transparent;width: 100px;height: 40px;color:black"/>
        </form>
    </center>
    </body>