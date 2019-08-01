<%@page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.sql.*" %>  
<%@ page import="com.ConnDB" %>
<%@ page import="com.user" %>

<head>
    <script>
        onload=function()
        {
            var sel=document.getElementById("sel");
            sel.children[1].selected=true;
            document.transfer.style.display="none";
            document.repay.style.display="block";
             
            sel.onchange=function()
            {
                var op=this[this.selectedIndex].innerHTML.replace(/^\s+|\s+$/g,"");
                if(op=="转账")
                {
                    document.transfer.style.display="block";
                    document.repay.style.display="none";
                }else if(op=="信用卡还款"){
                    document.transfer.style.display="none";
                    document.repay.style.display="block";
                }
            }
        }
    </script>
  </head> 
  <body style="background:url(Image/playground.jpg);background-size:cover;"><center>
 <form name=subnumber action="transfer.jsp" method=post>
        <table align="center">
            <tr>
                <td>付款账户：<input type=text  name=subnumber id=subnumber size=4 value="<%=request.getParameter("subnumber")==null?"":request.getParameter("subnumber")%>"></td>
                <td><input type="submit" value="查看详情" style="background-color: transparent;width: 100px;height: 50px;color: black"/></td>
            </tr>
            
  
  <%
 String subnumber= request.getParameter("subnumber");
 if(subnumber==null)
 {
 }
 else
 {
  user.sourcesubnumber=subnumber;
  try
    {
            ConnDB conn=new ConnDB(); 
            Connection con=conn.getConn(); 
            Statement statement = con.createStatement();
            String sql = "select * from account where subnumber="+subnumber;
            ResultSet rs = statement.executeQuery(sql); 
            String savetype=null;
            String moneytype=null;
            rs.next();
             
            out.print("<tr align=center'>");
            out.print("<td>账户详情："+rs.getString("savetype"));
            out.print("<td>"+rs.getString("moneytype"));
            out.print("</tr>");
           
            rs.close();
            con.close();
            
           
           
    }   
     catch(Exception e)
    {
            e.printStackTrace();
    }
 }

%>
        </table>      
</form>

<br>


<div align="center">
请选择转账类型： <select id="sel" align="center">
        <option>转账</option>
        <option>信用卡还款</option>
 </select>
 
 </div>
 <br>

<form name=transfer action="transferhandle.jsp" method=post>
        <table align="center">       
            <tr>
                <td>收款人id：<input type="number" name=object size=4  min=0 /></td>
            <tr/>  
            
            <tr>
                <td>收款账户：<input type="number" name=objectsubnumber size=3  min=0 /></td>
            <tr/> 
                      
            <tr>
                <td>转账金额：<input type="number" name=amount size=4  min=0 /></td>
            <tr/> 
               
            <tr>
            <td>
                <input type="submit" value="确认转账" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
                <input type="reset" value="重置转账" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
            </td>
            </tr>        
        </table>    
 </form>
 
 <form name=repay action="repayhandle.jsp" method=post>
        <table align="center"> 
            <tr>
                <td>还款金额：<input type="number" name=repayamount min=0 /></td>
            <tr/> 
               
            <tr>
            <td>       
                 <input type="submit" value="确认还款" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
                <input type="reset" value="重置还款" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
            </td>
            </tr>        
        </table>    
 </form>
 
 
 

<br><br>

 <div align="center"> 
     转账历史信息
</div> 
    <br>

<table border align="center">
     <tr><td>对方id</td><td>子账户号</td></tr>
<% 
   try
    {
        ConnDB conn=new ConnDB(); 
        Connection con=conn.getConn(); 
        Statement statement = con.createStatement();
        String sql = "select * from history where id="+user.user;
        ResultSet rs = statement.executeQuery(sql); 
        
        
        while(rs.next())
        {
            out.print("<tr align='center'>");
            out.print("<td>"+rs.getString("object"));
            out.print("<td>"+rs.getString("objectsubnumber"));
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



</table><br><br>
            <form action="mainmenu.jsp">
                <input type="submit" name="home" value="返回" style="font-size:16px;background-color: transparent;width: 120px;height: 60px;color: white"/>
            </form>
    </center>
</body>
</html>