<%@page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.sql.*" %>  
<%@ page import="com.user"%> 
<%@ page import="com.ConnDB" %> 

<%      
        String sourcesubnumber=user.sourcesubnumber;
        //String creditnumber=request.getParameter("creditnumber");
        String amount = request.getParameter("repayamount");


 try
 {  
               ConnDB conn=new ConnDB(); 
               Connection con=conn.getConn(); 
               
               
               //判断是否定期是否已经预支取过了               
               Statement statement = con.createStatement();
               String vetifyadvance="select * from advance where id="+user.user+" and subnumber="+sourcesubnumber;

               ResultSet advancers = statement.executeQuery(vetifyadvance);
               
             
               if(!advancers.next())
             {
               
               //实际转账操作
               PreparedStatement ps1 = null;  
               PreparedStatement ps2 = null;  
               PreparedStatement ps3 = null;    
               
               
               String sql1 = "update account set money=money-"+amount+" where subnumber="+sourcesubnumber+" and id="+user.user+" and money>="+amount;  
               String sql2 = "update xinyongka set keyongyue=keyongyue+"+amount+" where id="+user.user;  
               String sql3 = "update xinyongka set yihuankuan=yihuankuan+"+amount+" where id="+user.user;
               
               
               con.setAutoCommit(false);  
               ps1 = con.prepareStatement(sql1);
               int res1 = ps1.executeUpdate();  
               ps2 = con.prepareStatement(sql2);  
               int res2 = ps2.executeUpdate();  
               ps3 = con.prepareStatement(sql3);  
               int res3 = ps3.executeUpdate();  


                   if (res1 == 1 && res2 == 1&& res3 == 1) 
                     {  
                        con.commit(); 
                        out.print("还款成功"); 
                     }
                    else 
                    {  
                        out.print("转账失败，余额不足！");
                        con.rollback();  
                     }  
      
    
                ps1.close();
                ps2.close();
                ps3.close();
            }
            else
            {
                out.print("该定期账户已经被预支过了！");
            }
            
            
     statement.close();
     con.close();
     
}        
catch (Exception e)
{  
    e.printStackTrace();  
} 
finally
{  
}   
%>
