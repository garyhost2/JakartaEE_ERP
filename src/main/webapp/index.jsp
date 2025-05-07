<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Welcome | TaskFlow</title>

  <!-- 1) Tailwind config with your custom navy colors -->
  <script>
    window.tailwind = window.tailwind || {};
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          colors: {
            navy:         '#001f3f',  // dark background
            'navy-lighter': '#012d63' // cards, panels in dark mode
          }
        }
      }
    };
  </script>

  <!-- 2) Tailwind CDN (only once!) -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- 3) Font Awesome (only once) -->
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    integrity="sha512-pJRfJH0tz…"
    crossorigin="anonymous"
    referrerpolicy="no-referrer"
  />
</head>
<body   class="flex flex-col min-h-screen bg-gray-50 text-gray-800
         dark:bg-gray-900 dark:text-gray-100 transition-colors">
  <%@ include file="/WEB-INF/views/navbar.jsp" %>
<div id="vanta-bg" class="fixed inset-0 -z-10"></div>

  <!-- HERO -->
  <section class="bg-white shadow rounded-lg max-w-3xl mx-auto px-6 py-12 mt-10 text-center">
    <h1 class="text-4xl font-bold text-blue-600 mb-4">Welcome to TaskFlow</h1>
    <p class="text-gray-700 mb-6">
      Smart ticket management for modern teams. Create, assign, and track tickets seamlessly—all in one place.
    </p>
    <a href="tickets.jsp">
      <button class="bg-blue-600 text-white px-6 py-3 rounded-md hover:bg-blue-700 transition">
        Get Started
      </button>
    </a>
  </section>


  <!-- FEATURES -->
  <section class="grid gap-8 mt-12 mb-16 px-4 sm:px-6 md:px-0
                  grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 max-w-5xl mx-auto">
    <div class="bg-white shadow rounded-lg overflow-hidden">
      <img src="images/feature1.jpg" alt="Create Tickets" class="h-40 w-full object-cover"/>
      <div class="p-4">
        <h3 class="font-semibold text-blue-600 mb-2">Create Tickets</h3>
        <p class="text-gray-600">Easily log new issues with a clean interface.</p>
      </div>
    </div>
    <div class="bg-white shadow rounded-lg overflow-hidden">
      <img src="images/feature2.jpg" alt="Track Progress" class="h-40 w-full object-cover"/>
      <div class="p-4">
        <h3 class="font-semibold text-blue-600 mb-2">Track Progress</h3>
        <p class="text-gray-600">Monitor the status of every ticket in real time.</p>
      </div>
    </div>
    <div class="bg-white shadow rounded-lg overflow-hidden">
      <img src="images/feature3.jpg" alt="Assign Agents" class="h-40 w-full object-cover"/>
      <div class="p-4">
        <h3 class="font-semibold text-blue-600 mb-2">Assign Agents</h3>
        <p class="text-gray-600">Quickly delegate tasks to your support team.</p>
      </div>
    </div>
  </section>

  <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r121/three.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vanta@0.5.21/dist/vanta.stars.min.js"></script>

<script>
  (() => {
    const root = document.documentElement;
    const mobileMenuBtn = document.getElementById('mobile-menu-button');
    const mobileMenu    = document.getElementById('mobile-menu');
    const themeBtns     = [ document.getElementById('theme-toggle'),
                            document.getElementById('theme-toggle-mobile') ];
    const themeIcons    = [ document.getElementById('theme-icon'),
                            document.getElementById('theme-icon-mobile') ];
    const darkQuery     = window.matchMedia('(prefers-color-scheme: dark)');

    // Init theme
    const isDark = localStorage.theme === 'dark' || (!('theme' in localStorage) && darkQuery.matches);
    if (isDark) {
      root.classList.add('dark');
      themeIcons.forEach(ic => ic.classList.replace('fa-moon','fa-sun'));
    }

    // Toggle theme
    themeBtns.forEach(btn =>
      btn.addEventListener('click', () => {
        const inDark = root.classList.toggle('dark');
        localStorage.theme = inDark ? 'dark' : 'light';
        themeIcons.forEach(ic =>
          ic.classList.replace(inDark ? 'fa-moon' : 'fa-sun', inDark ? 'fa-sun' : 'fa-moon')
        );
      })
    );

    // Toggle mobile menu
    mobileMenuBtn.addEventListener('click', () => {
      mobileMenu.classList.toggle('hidden');
    });
  })();
</script>

</html>
