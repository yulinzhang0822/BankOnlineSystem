<%@ page contentType="text/html; charset=gbk" %>
<%@ page import="com.user" %>

<html>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
         <b>
            <font face="隶书" size="10" color="black">网上银行</font>
        </b>
        <hr>
        <h3>一卡通账号：<%= (String) session.getAttribute("username")%></h3>
        <img src="resources/images/menu.jpg"  usemap="#testmap" alt="test" />
        <map name="testmap" id="testmap">
            <area shape="circle" coords="180,139,14" href ="test1.html" alt="test1" />
            <area shape="circle" coords="129,161,10" href ="test2.html" alt="test2" />
            <area shape="rect" coords="0,0,290,209" href ="yikatonginfo.jsp" alt="test3" />
            <area shape="rect" coords="290,0,581,210" href ="transaction.jsp" alt="test3" />
            <area shape="rect" coords="581,0,863,210" href ="transfer.jsp" alt="test3" />
            <area shape="rect" coords="0,212,290,418" href ="analysis.jsp" alt="test3" />
            <area shape="rect" coords="290,210,581,418" href ="modifypwd.jsp" alt="test3" />
            <area shape="rect" coords="580,210,863,418" href ="reportloss.jsp" alt="test3" />

        </map>
        <br>
        <br>
                <form action="login.jsp">
            <input type="submit" name="home" value="退出登录" style="font-size:24px;background-color: transparent;width: 120px;height: 60px;color:white"/>
        </form>
    </center>
    </body>
</html>