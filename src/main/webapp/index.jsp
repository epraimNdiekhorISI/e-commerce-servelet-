<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ecommerce</title>
</head>
<body>
    <%-- Redirige automatiquement vers la page de login --%>
    <% response.sendRedirect(request.getContextPath() + "/auth"); %>
</body>
</html>