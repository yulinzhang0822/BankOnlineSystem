<%@ page contentType="text/html; charset=utf-8"%>

<html>
    <head>
    </head>
    <body style="background:url(Image/playground.jpg);background-size:cover;">
    <center>
        <form name=loginForm action="modifyhandle.jsp" method=post>
            <table align="center">
                <tr>
                    <td>初始密码：</td><td><input type=text name=prepwd
                                             /></td>
                </tr>
                <tr>
                    <td>新密码：</td><td><input type=text name=lastpwd
                                             /></td>
                </tr>     
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="确认修改" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
                                    <input type="reset" value="清空" name="reset" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
                    </td>
                    
                </tr>        
            </table>
        </form>
        <form action="mainmenu.jsp">
            <input type="submit" name="home" value="返回" style="background-color: transparent;width: 100px;height: 50px;color: black"/>
        </form>
    </center>
    </body>
</html>