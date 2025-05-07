<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Dashboard | TicketFlow</title>

  <!-- Tailwind + custom dark/navy if you set that up -->
  <script>
    tailwind.config = { darkMode: 'class' };
  </script>
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Font Awesome for icons -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

  <!-- Chart.js for graphs -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

  <style>
    /* optional full-page radial gradient */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      z-index: -1;
      background: radial-gradient(circle at 20% 20%,
                                  rgba(59,130,246,0.3) 0%,
                                  rgba(15,23,42,0.8) 70%);
    }
  </style>
</head>
<body class="flex flex-col min-h-screen bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-100">

  <%@ include file="/WEB-INF/views/navbar.jsp" %>

  <main class="flex-grow container mx-auto px-4 py-8">

    <h1 class="text-3xl font-bold mb-6">Dashboard</h1>

    <!-- KPI Cards -->
    <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-4 mb-12">
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow text-center">
        <i class="fa fa-list fa-2x text-blue-500"></i>
        <h2 class="mt-2 text-sm uppercase text-gray-500">Total Tickets</h2>
        <p class="mt-1 text-3xl font-semibold">50</p>
      </div>
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow text-center">
        <i class="fa fa-inbox fa-2x text-yellow-500"></i>
        <h2 class="mt-2 text-sm uppercase text-gray-500">Open</h2>
        <p class="mt-1 text-3xl font-semibold">20</p>
      </div>
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow text-center">
        <i class="fa fa-spinner fa-2x text-indigo-500"></i>
        <h2 class="mt-2 text-sm uppercase text-gray-500">In Progress</h2>
        <p class="mt-1 text-3xl font-semibold">15</p>
      </div>
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow text-center">
        <i class="fa fa-check-circle fa-2x text-green-500"></i>
        <h2 class="mt-2 text-sm uppercase text-gray-500">Closed</h2>
        <p class="mt-1 text-3xl font-semibold">15</p>
      </div>
    </div>

    <!-- Charts -->
    <div class="grid gap-8 lg:grid-cols-2">

      <!-- Doughnut Chart -->
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow">
        <h3 class="text-xl font-medium mb-4">Status Breakdown</h3>
        <canvas id="doughnutChart"></canvas>
      </div>

      <!-- Bar Chart -->
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow">
        <h3 class="text-xl font-medium mb-4">Tickets by Month</h3>
        <canvas id="barChart"></canvas>
      </div>

    </div>
  </main>

  <%@ include file="/WEB-INF/views/footer.jsp" %>

  <script>
    // static data matching the KPIs above
    const dataCounts = { open:20, progress:15, closed:15 };

    // Doughnut
    new Chart(document.getElementById('doughnutChart'), {
      type: 'doughnut',
      data: {
        labels: ['Open','In Progress','Closed'],
        datasets: [{
          data: [dataCounts.open, dataCounts.progress, dataCounts.closed],
          backgroundColor: ['#FBBF24','#6366F1','#10B981']
        }]
      },
      options: {
        plugins: { legend:{ position:'bottom' } }
      }
    });

    // Bar
    new Chart(document.getElementById('barChart'), {
      type: 'bar',
      data: {
        labels: ['Jan','Feb','Mar','Apr','May','Jun'],
        datasets: [{
          label: 'Tickets',
          data: [5,8,12,7,10,8], // fake trend
          backgroundColor: '#3B82F6'
        }]
      },
      options: {
        scales: { y:{ beginAtZero:true } },
        plugins:{ legend:{ display:false } }
      }
    });
  </script>
</body>
</html>
