<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="com.ConnDB" %>
<%@ page import="com.user" %>


<html>
    <head>
        <!--绘制饼图的脚本 -->
        <script>
            function drawCircle(canvasId, data_arr, color_arr, text_arr)
            {
                var c = document.getElementById(canvasId);
                var ctx = c.getContext("2d");

                var radius = c.height / 2 - 20; //半径
                var ox = radius + 20, oy = radius + 20; //圆心

                var width = 30, height = 10; //图例宽和高
                var posX = ox * 2 + 20, posY = 30;   //
                var textX = posX + width + 5, textY = posY + 10;

                var startAngle = 0; //起始弧度
                var endAngle = 0;   //结束弧度
                for (var i = 0; i < data_arr.length; i++)
                {
                    //绘制饼图
                    endAngle = endAngle + data_arr[i] * Math.PI * 2; //结束弧度
                    ctx.fillStyle = color_arr[i];
                    ctx.beginPath();
                    ctx.moveTo(ox, oy); //移动到到圆心
                    ctx.arc(ox, oy, radius, startAngle, endAngle, false);
                    ctx.closePath();
                    ctx.fill();
                    startAngle = endAngle; //设置起始弧度

                    //绘制比例图及文字
                    ctx.fillStyle = color_arr[i];
                    ctx.fillRect(posX, posY + 20 * i, width, height);
                    ctx.moveTo(posX, posY + 20 * i);
                    ctx.font = 'bold 12px 微软雅黑';    //斜体 30像素 微软雅黑字体
                    ctx.fillStyle = color_arr[i]; //"#000000";
                    var percent = text_arr[i] + "：" + 100 * data_arr[i] + "%";
                    ctx.fillText(percent, textX, textY + 20 * i);

                }
            }

            function disaccount(per1, per2)
            {
                var data_arr = [per1, per2];
                var color_arr = ["#00FF21", "#FFAA00", "#00AABB", "#FF4400"];
                var text_arr = ["支出", "收入"];
                drawCircle("canvas_circle1", data_arr, color_arr, text_arr);
            }



            function discredit(per3, per4)
            {
                var data_arr = [per3, per4];
                var color_arr = ["#00FF21", "#FFAA00", "#00AABB", "#FF4400"];
                var text_arr = ["已使用额度", "已还款"];
                drawCircle("canvas_circle2", data_arr, color_arr, text_arr);
            }
        </script>
    </head>






    <div align="left"> 
        一卡通收支信息
    </div> 
    <br>



    <!-- 选择分析账户的表单 -->
    <body style="background:url(Image/playground.jpg);background-size:cover;">
   
        <br>
        <!-- 显示一卡通账单的表格 -->  
        <center>
        <table border align='left'>
            <tr><td>账单类型</td><td>数额</td></tr>                    
            <%
              
                    try {
                        ConnDB conn = new ConnDB();
                        Connection con = conn.getConn();
                        Statement statement = con.createStatement();
                        String sql = "select * from bill where id=" + user.user ;
                        ResultSet rs = statement.executeQuery(sql);
                        String type = null;
                        String money = null;

                        while (rs.next()) {
                            out.print("<tr align='left'>");
                            out.print("<td>" + rs.getString("type"));
                            out.print("<td>" + rs.getString("money"));
                            out.print("</tr>");
                        }
                        rs.close();
                        con.close();

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                

            %>

        </table>  
        </center>
        <!-- 计算一卡通消费比例的java-->
        <%      double per1 = 0.5;
                   double per2 = 0.5;
                try {
                    ConnDB conn = new ConnDB();
                    Connection con = conn.getConn();
                    Statement statement = con.createStatement();
                    String zhichu = "select sum(money) as sumzhichu from bill where id=" + user.user +" and type=0";
                    ResultSet rs1 = statement.executeQuery(zhichu);
                    double sumzhichu;
                    rs1.next();
                    sumzhichu = Double.parseDouble(rs1.getString("sumzhichu"));

                    String shouru = "select sum(money) as sumshouru from bill where id=" + user.user + "  and type=1";
                    ResultSet rs2 = statement.executeQuery(shouru);
                    double sumshouru;
                    rs2.next();
                    sumshouru = Double.parseDouble(rs2.getString("sumshouru"));

                    per1 = sumzhichu / (sumzhichu + sumshouru);
                    per2 = sumshouru / (sumzhichu + sumshouru);

                    rs1.close();
                    rs2.close();
                    con.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            

        %>
        <center>
        <!-- 显示饼图的button -->
        <div > 
            <input type="button" id="button" value="显示饼状图"  onclick="disaccount(<%=per1%>,<%=per2%>)" />
        </div>   

        <div align="right">
            <canvas id="canvas_circle1"  width="500" height="300" >
            </canvas>
        </div>
        <!--style="border:2px solid #0026ff;"-->
        <br> <br>
        
        
        
        
        
        
        
        
        <html>
            <div align="left"> 
                信用卡收支信息
            </div> 
            <br> 
        </center>
            <!-- 这里是信用卡账单 --> 
            <!-- 显示账单的表格 -->  
            <center>
            <table border align='left'>
                <tr><td>已使用额度</td><td>已还款</td></tr>                    
                <%
                    try {
                        ConnDB conn = new ConnDB();
                        Connection con = conn.getConn();
                        Statement statement = con.createStatement();
                        String sql = "select * from xinyongka where id=" + user.user;
                        ResultSet rs = statement.executeQuery(sql);
                        String yishiyongedu = null;
                        String yihuankaun = null;

                        while (rs.next()) {
                            out.print("<tr align='left'>");
                            out.print("<td>" + rs.getString("yishiyongedu"));
                            out.print("<td>" + rs.getString("yihuankuan"));
                            out.print("</tr>");
                        }
                        rs.close();
                        con.close();

                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                    }
                %>

            </table>  
            </center>
            <!-- 计算一卡通消费比例的java-->
            <%
                double per3 = 0.5;
                double per4 = 0.5;

                try {
                    ConnDB conn = new ConnDB();
                    Connection con = conn.getConn();
                    Statement statement = con.createStatement();
                    String zhichu = "select * from xinyongka where id=" + user.user;
                    ResultSet rs1 = statement.executeQuery(zhichu);

                    rs1.next();

                    double sumzhichu;
                    double sumshouru;
                    sumzhichu = Double.parseDouble(rs1.getString("yishiyongedu"));
                    sumshouru = Double.parseDouble(rs1.getString("yihuankuan"));

                    per3 = sumzhichu / (sumzhichu + sumshouru);
                    per4 = sumshouru / (sumzhichu + sumshouru);

                    rs1.close();
                    con.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <center>
            <!-- 显示饼图的button -->
            <div align="left"> 
                <input type="button" id="button" value="显示饼状图"  onclick="discredit(<%=per3%>,<%=per4%>)" />
            </div>   

            <div align="right">
                <canvas id="canvas_circle2"  width="500" height="300" >
                </canvas>
            </div>
            </center>
            <center>
            <!--style="border:2px solid #0026ff;"-->
            <form action="mainmenu.jsp">
                <input type="submit" name="home" value="返回" style="font-size:16px;background-color: transparent;width: 120px;height: 60px;color: black"/>
            </form>
    </center>
</body>
</html>