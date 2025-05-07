<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script>
        // Same theme toggle script as register.jsp
        function toggleTheme() {
            const html = document.documentElement;
            const theme = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
        }
    </script>
</head>
<body>
<div class="container">
    <div class="theme-toggle" onclick="toggleTheme()">🌓</div>
    <div class="form-container">
        <h1>Oops! Something went wrong 😞</h1>
        <c:if test="${not empty errorMessage}">
            <div class="error-messages">
                <p>${errorMessage}</p>
            </div>
        </c:if>
        <a href="${pageContext.request.contextPath}/register">Back to Registration</a>
    </div>
</div>
</body>
</html>