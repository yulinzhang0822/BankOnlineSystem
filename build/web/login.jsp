<%@ page contentType="text/html; charset=gbk"%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>网上银行</title>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
                <font face="隶书" color="dark" size="6">网上银行系统</font>
        <hr>
        <br>
        <form name=loginForm action="handlelogin.jsp" method=post>
        <table align="center">
            <tr>
                <td>一卡通账号：</td><td><input type=text onKeyUp="value=value.replace(/[\W]/g,'')" name=username
                 size="20" maxlength="16"/></td>
            </tr>    
            <tr>
                <td>密码：</td><td><input type=password name=pwd  size="20" maxlength="16"/></td>
            <tr/>            
        </table>
            <br>
                    <tr>
            <td colspan="2" align="center">
                <input type="submit" value="登录" style="background-color: transparent;width: 100px;height: 50px;color: black"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="reset" value="清空" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
            </td>
            </tr> 
        </form>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><font color="white" size="2">Copyright @2018 The Brave Corporation, All Rights Reserved</font>
    </center>
    </body>
</html>