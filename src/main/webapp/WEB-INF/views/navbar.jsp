<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="bg-white shadow">
  <div class="container mx-auto px-4 py-3 flex items-center justify-between">

    <!-- Brand -->
    <a href="${pageContext.request.contextPath}/index.jsp"
       class="flex items-center gap-2">
      <img src="https://i.postimg.cc/tJrYKwzQ/Chat-GPT-Image-Apr-9-2025-09-53-02-PM.png"
           alt="TicketFlow Logo" class="h-10 w-auto"/>
    </a>

    <!-- Desktop links -->
    <ul class="hidden md:flex items-center space-x-6 text-gray-600">
      <li><a href="${pageContext.request.contextPath}/index.jsp"
             class="hover:text-blue-600">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/contact"
             class="hover:text-blue-600">ContactUs</a></li>

      <c:choose>
        <c:when test="${empty sessionScope.currentUser}">
          <li><a href="${pageContext.request.contextPath}/login"
                 class="hover:text-blue-600">Login</a></li>
          <li><a href="${pageContext.request.contextPath}/register"
                 class="text-blue-600 hover:underline">Register</a></li>
        </c:when>
        <c:otherwise>
          <li><a href="${pageContext.request.contextPath}/profile"
                 class="hover:text-blue-600">Modify&nbsp;Profile</a></li>
          <li><a href="${pageContext.request.contextPath}/logout"
                 class="text-blue-600 hover:underline">Logout</a></li>
        </c:otherwise>
      </c:choose>

      <li>
        <button id="theme-toggle"
                class="p-2 rounded hover:bg-gray-100 transition"
                aria-label="Toggle dark mode">
          <i id="theme-icon" class="fas fa-moon text-gray-600"></i>
        </button>
      </li>
    </ul>

    <!-- Mobile buttons -->
    <div class="md:hidden flex items-center space-x-2">
      <button id="theme-toggle-mobile"
              class="p-2 rounded hover:bg-gray-100 transition">
        <i id="theme-icon-mobile" class="fas fa-moon text-gray-600"></i>
      </button>
      <button id="mobile-menu-button" class="text-gray-600">
        <i class="fas fa-bars fa-lg"></i>
      </button>
    </div>
  </div>

  <!-- Mobile menu -->
  <div id="mobile-menu" class="hidden md:hidden bg-white border-t border-gray-200">
    <a href="${pageContext.request.contextPath}/index.jsp"
       class="block px-4 py-2">Home</a>
    <a href="${pageContext.request.contextPath}/contact"
       class="block px-4 py-2">ContactUs</a>

    <c:choose>
      <c:when test="${empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/login"
           class="block px-4 py-2">Login</a>
        <a href="${pageContext.request.contextPath}/register"
           class="block px-4 py-2 text-blue-600">Register</a>
      </c:when>
      <c:otherwise>
        <a href="${pageContext.request.contextPath}/profile"
           class="block px-4 py-2">Modify&nbsp;Profile</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="block px-4 py-2 text-blue-600">Logout</a>
      </c:otherwise>
    </c:choose>
  </div>
</nav>
