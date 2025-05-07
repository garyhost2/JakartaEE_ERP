<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Tailwind (config first, then CDN script) -->
<script>
  window.tailwind = window.tailwind || {};
  tailwind.config = { darkMode: 'class' };
</script>
<script src="https://cdn.tailwindcss.com"></script>

<%@ include file="/WEB-INF/views/navbar.jsp" %>

<!-- Page wrapper -->
<div class="flex flex-col min-h-screen bg-gray-50 dark:bg-gray-900 pt-20">

  <!-- Contact card -->
  <div class="w-full max-w-2xl mx-auto bg-white dark:bg-gray-800 rounded-lg shadow px-8 py-10">
    <h1 class="text-3xl font-bold mb-2 text-gray-800 dark:text-gray-100">Contact&nbsp;Us</h1>
    <p class="text-gray-600 dark:text-gray-400 mb-8">
      Have a question or feedback? Fill out the form and we’ll get back to you!
    </p>

    <!-- Success banner -->
    <c:if test="${param.ok == '1'}">
      <div class="mb-6 rounded px-4 py-3 bg-green-100 text-green-800">
        Thank you — your message was sent.
      </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/contact" method="post" class="space-y-6">
      <div>
        <label class="block mb-1 text-sm text-gray-700 dark:text-gray-300">Name</label>
        <input type="text" name="name" required
               class="w-full p-3 border rounded bg-gray-50 dark:bg-gray-700
                      dark:text-gray-100 focus:outline-none focus:ring-2
                      focus:ring-blue-500"/>
      </div>

      <div>
        <label class="block mb-1 text-sm text-gray-700 dark:text-gray-300">Email</label>
        <input type="email" name="email" required
               class="w-full p-3 border rounded bg-gray-50 dark:bg-gray-700
                      dark:text-gray-100 focus:outline-none focus:ring-2
                      focus:ring-blue-500"/>
      </div>

      <div>
        <label class="block mb-1 text-sm text-gray-700 dark:text-gray-300">Subject</label>
        <input type="text" name="subject" required
               class="w-full p-3 border rounded bg-gray-50 dark:bg-gray-700
                      dark:text-gray-100 focus:outline-none focus:ring-2
                      focus:ring-blue-500"/>
      </div>

      <div>
        <label class="block mb-1 text-sm text-gray-700 dark:text-gray-300">Message</label>
        <textarea name="message" rows="5" required
                  class="w-full p-3 border rounded bg-gray-50 dark:bg-gray-700
                         dark:text-gray-100 focus:outline-none focus:ring-2
                         focus:ring-blue-500"></textarea>
      </div>

      <div class="flex justify-end">
        <button class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          Send
        </button>
      </div>
    </form>
  </div>

  <div class="flex-grow"></div> <!-- keeps footer at bottom -->

</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
