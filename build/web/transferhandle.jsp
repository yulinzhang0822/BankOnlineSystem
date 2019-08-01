<%@page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.sql.*" %>  
<%@ page import="com.user"%> 
<%@ page import="com.ConnDB" %> 

<%      
        String sourcesubnumber=user.sourcesubnumber;
        String object= request.getParameter("object");
        String amount = request.getParameter("amount");
        String objectsubnumber= request.getParameter("objectsubnumber");


 try
 {  
               ConnDB conn=new ConnDB(); 
               Connection con=conn.getConn(); 
               
               
               //判断是否定期是否已经预支取过了               
               Statement statement = con.createStatement();
               String vetifyadvance="select * from advance where id="+user.user+" and subnumber="+sourcesubnumber;
               //out.print(vetifyadvance);
               ResultSet advancers = statement.executeQuery(vetifyadvance);
               
              
               
               //out.print("23333");
             
               if(!advancers.next())
             {

               //判断是否为相同币种
               
               String vetify1="select * from account where id="+user.user+" and subnumber="+sourcesubnumber;
               String vetify2="select * from account where id="+object+" and subnumber="+objectsubnumber;
               ResultSet rs1 = statement.executeQuery(vetify1);
               rs1.next();
               String moneytype1=rs1.getString("moneytype");
               
               ResultSet rs2 = statement.executeQuery(vetify2);
               rs2.next();
               String moneytype2=rs2.getString("moneytype");
               

               //实际转账操作
               PreparedStatement ps1 = null;  
               PreparedStatement ps2 = null;  
             
               String sql1 = "update account set money=money-"+amount+" where subnumber="+sourcesubnumber+" and id="+user.user+" and money>="+amount;  
               String sql2 = "update account set money=money+"+amount+" where subnumber="+objectsubnumber+" and id="+object;  
              
               con.setAutoCommit(false);  
               ps1 = con.prepareStatement(sql1);
               int res1 = ps1.executeUpdate();  
               ps2 = con.prepareStatement(sql2);  
               int res2 = ps2.executeUpdate();  
    



               if(moneytype1.equals(moneytype2))       
               {        
                 //out.print("2333333");
                   if (res1 == 1 && res2 == 1) 
                     {  
                        con.commit(); 
                        out.print("转账成功"); 
                     }
                    else 
                    {  
                        out.print("转账失败，余额不足！");
                        con.rollback();  
                    }  
               
           
              } 
     
              else
              {
                  out.print("不同币种之间不能互相转账！");
    
              }    
    
    
                ps1.close();
                ps2.close();
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

 
 
 

 <%
 
  //记录转账历史
  
 if((object==null)||(objectsubnumber==null))
 {
 
 }

 else
 {
 
  try
    {
            ConnDB conn=new ConnDB(); 
            Connection con=conn.getConn(); 
                  
            Statement statement = con.createStatement();
            
            //判断是不是已经存在历史中了
            String vertifyhistory="select * from history where id="+user.user+" and object="+object+" and objectsubnumber="+objectsubnumber;
            //out.print(vertifyhistory);
            ResultSet historyrs = statement.executeQuery(vertifyhistory);  
           
      
            if(!historyrs.next())
          {
            //记录转账对象历史
            String sql = "insert into history(id,object,objectsubnumber) values("+user.user+","+object+","+objectsubnumber+")";
            //out.print(sql);
            statement.executeUpdate(sql); 
          }
          else
          {
          }
           
          con.close();
            
            
           
    }   
     catch(Exception e)
    {
            e.printStackTrace();
    }
 }

%>
 

 