<%-- 
    Document   : login
    Created on : 13-feb-2014, 16.08.53
    Author     : Piero
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/public_webapp/style/style.css">
        <title>Login Page</title>
    </head>
        <body>
            <%@ include file="/navigation_bar.jspf" %>
            <div class ="login_form">
                <form action="LoginServlet" method="post">
                USERNAME 
                <br>
                <input type="text" name="user">
                <br>
                PASSWORD 
                <br>
                <input type="password" name="pwd">
                <br>
                <input class="button" type="submit" value="LOGIN">
            </form>
                <br>
                non hai un account? <a href="/public_webapp/register.jsp">REGISTRATI</a>
            </div>
        </body>
</html>