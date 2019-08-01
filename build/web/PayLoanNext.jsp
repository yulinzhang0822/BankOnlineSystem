<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>偿还贷款结果</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
        <%
            String  username = (String)session.getAttribute("username");//获取一卡通账号
            int rvalue = 0, rvalue2 = 0;
            int loanID = Integer.parseInt(request.getParameter("loanID"));
            Boolean flag = true;
            Connection newcon;
            Statement st;
            ResultSet rs;
            float leftmoney=0;
            //需与储蓄卡关联，判断一卡通账号余额是否足够
            if (flag) {
                Connection con;
                Statement stmt;
                ResultSet result;
                int typeone = 0;//贷款种类（长期/短期）
                int typetwo = 0;//贷款类型
                float quantity = 0;//贷款数额
                int loanyear = 0;//贷款的期限（年）
                int loanmonth = 0;//贷款的期限（月）
                float startrate = 0;//贷款开始时的利率
                int returntype = 0;//贷款偿还的方式
                String paydate = null;//还款期限
                float principal = 0;//下次偿还的本金
                float interest = 0;//下次偿还的利息
                float inttotal = 0;//已结偿还的总利息
                String intchange = null;//更新下次利率的日期
                int isExtend = 0;//是否申请过展期
                int isOverdue = 0;//是否逾期
                String overduedate = null;//逾期日期
                String startdate = null;//贷款发放的日期
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String uri = "jdbc:mysql://localhost:3306/banksystem";
                    con = DriverManager.getConnection(uri, "root", "19960822");
                    stmt = con.createStatement();
                    result = stmt.executeQuery("SELECT * FROM loaninfo WHERE loanID=" + loanID + " and (verified=" + 2 + " or verified=" + 3 + ")");
                    while (result.next()) {
                        typeone = result.getInt(3);
                        typetwo = result.getInt(4);
                        loanyear = result.getInt(5);
                        loanmonth = result.getInt(6);
                        quantity = result.getFloat(8);
                        startrate = result.getFloat(9);
                        returntype = result.getInt(10);
                    }
                    result = stmt.executeQuery("SELECT * FROM loaning WHERE loanID=" + loanID);
                    while (result.next()) {
                        startdate = result.getString(3);
                    }
                    result = stmt.executeQuery("SELECT * FROM payloan WHERE loanID=" + loanID + " and ispaying=" + 1);
                    while (result.next()) {
                        paydate = result.getString(3);
                        principal = result.getFloat(4);
                        interest = result.getFloat(5);
                        inttotal = result.getFloat(6);
                        intchange = result.getString(7);
                        isExtend = result.getInt(9);
                        isOverdue = result.getInt(10);
                        overduedate = result.getString(11);
                    }
                    switch (typetwo) {
                        case 1:
                            rvalue = stmt.executeUpdate("UPDATE loanfinish SET finishdate=now() WHERE loanID=" + loanID);
                            rvalue2 = stmt.executeUpdate("UPDATE payloan SET principal=0,interest=0,inttotal=" + interest + ",ispaying=0 WHERE loanID=" + loanID);
                            break;
                        case 2:
                            int totalmonth = loanyear * 12 + loanmonth; //总共需要偿还的月份数
                            inttotal = inttotal + interest;
                            int paytimes = 0;
                            float temptotal = inttotal;
                            while (temptotal - interest >= 0) {
                                paytimes++;
                                temptotal = temptotal - interest;
                            }
                            if (principal * paytimes + 1 >= quantity) {
                                principal = 0;
                            }
                            if (paytimes < totalmonth) {
                                rvalue = stmt.executeUpdate("UPDATE payloan SET paydate=date_add(paydate,interval 1 month),principal=" + principal + ",inttotal=" + inttotal + " WHERE loanID=" + loanID);
                            } else {
                                rvalue = stmt.executeUpdate("UPDATE loanfinish SET finishdate=now() WHERE loanID=" + loanID);
                                rvalue2 = stmt.executeUpdate("UPDATE payloan SET paydate=date_add(paydate,interval 1 month),principal=0,interest=0,inttotal=" + inttotal + ",ispaying =0 WHERE loanID=" + loanID);
                            }
                            break;
                        case 3:
                            rvalue = stmt.executeUpdate("UPDATE loanfinish SET finishdate=now() WHERE loanID=" + loanID);
                            rvalue2 = stmt.executeUpdate("UPDATE payloan SET principal=0,interest=0,inttotal=" + interest + ",ispaying=0 WHERE loanID=" + loanID);
                            break;
                    }
                } catch (Exception e) {
                    out.print(e);
                }
            }
        %>
        <b>
            <font color="#0000ff" size="10" face="华文行楷">贷款偿还结果</font>
        </b>
        <hr><%
            out.print("贷款偿还成功！");
        %>
        <br>
        <form action="PayLoan.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;font-size:20px;height:60px;width:200px"/>
        </form>
    </center>
</body>
</html>
