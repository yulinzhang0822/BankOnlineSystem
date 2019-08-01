<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="com.ConnDB" %>
<%@ page import="com.user" %>


<html>
    <div align="center"> 
        账户存取款信息
    </div> 
    <br><br> 


    <!-- 选择分析账户的表单 -->
    <body style="background:url(Image/playground.jpg);background-size:cover;">
        


        <!-- 显示账单的表格 -->  

        <table border align='center'>
            <tr><td>用户id</td><td>子账户号</td><td>数额</td><td>币种</td><td>存款类型</td><td>时间</td><td>账单类型</td></tr>                    
            <%
             
                    try {
                        ConnDB conn = new ConnDB();
                        Connection con = conn.getConn();
                        Statement statement = con.createStatement();
                        String sql = "select * from bill where id=" + user.user ;
                        ResultSet rs = statement.executeQuery(sql);
                        
                        while (rs.next()) {
                            out.print("<tr align='id'>");
                            out.print("<td>" + rs.getString("id"));
                            out.print("<td>" + rs.getString("subnumber"));
                            out.print("<td>" + rs.getString("money"));
                            out.print("<td>" + rs.getString("moneytype"));
                            out.print("<td>" + rs.getString("savetype"));
                            out.print("<td>" + rs.getString("time"));
                            out.print("<td>" + rs.getString("type"));
                  
                            out.print("</tr>");
                        }
                        rs.close();
                        con.close();

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                

            %>

        </table>  


        <br><br><br><br><br>

        <div align="center"> 
            <form action="LoanHome.html">
                <input type="submit" name="home" value="贷款业务办理" style="font-size:16px;background-color: transparent;width: 120px;height: 60px;color: black"/>
            </form>
            <form action="mainmenu.jsp">
                <input type="submit" name="home" value="返回" style="font-size:16px;background-color: transparent;width: 120px;height: 60px;color: black"/>
            </form>
        </div>   






