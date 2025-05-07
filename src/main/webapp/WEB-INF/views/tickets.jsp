<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Tickets | TicketFlow</title>

  <!-- Tailwind -->
  <script> tailwind.config = { darkMode: 'class' } </script>
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
  <!-- Sortable.js -->
  <script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>

  <style>
    #ticket-board {
      background: linear-gradient(135deg, #6b46c1, #3182ce);
      color: #f0fdf4;
      border-radius: .75rem;
      padding: 1.5rem;
      margin-top: 2rem;
    }
    #ticket-board > .board-content { position: relative; z-index: 1; }
    .status-column {
      min-height: 300px;
      background: rgba(255,255,255,0.1);
      border-radius: .5rem;
      padding: .75rem;
    }
    .ticket-card {
      background: white;
      color: #111827;
    }
    .dark .ticket-card {
      background: #1f2937;
      color: #f3f4f6;
    }
  </style>
</head>
<body class="flex flex-col min-h-screen bg-gray-50 dark:bg-gray-900">

  <%@ include file="/WEB-INF/views/navbar.jsp" %>

  <main class="flex-grow container mx-auto px-4">
    <!-- New Ticket -->
    <div class="flex justify-end mt-8">
      <button id="btn-create"
              class="bg-white dark:bg-gray-700 dark:text-gray-100 text-gray-800 hover:bg-gray-100
                     px-4 py-2 rounded shadow">
        <i class="fa fa-plus mr-1"></i> New Ticket
      </button>
    </div>

    <!-- Ticket Board -->
    <div id="ticket-board" class="board-content">
      <h1 class="text-2xl font-bold mb-6">Your Tickets</h1>
      <div class="grid gap-6 md:grid-cols-3">
      <c:set var="statuses" value="${fn:split('open,in_progress,closed', ',')}"/>
		<c:forEach var="statusKey" items="${statuses}">
          <div class="status-column" id="${statusKey}">
            <h2 class="font-semibold mb-3">
              <i class="fa
                <c:choose>
                  <c:when test="${statusKey=='open'}">fa-inbox</c:when>
                  <c:when test="${statusKey=='in_progress'}">fa-spinner</c:when>
                  <c:otherwise>fa-check-circle</c:otherwise>
                </c:choose>
              mr-1"></i>
              <c:choose>
                <c:when test="${statusKey=='open'}">Open</c:when>
                <c:when test="${statusKey=='in_progress'}">In Progress</c:when>
                <c:otherwise>Closed</c:otherwise>
              </c:choose>
            </h2>
            <c:forEach var="t" items="${ticketsByStatus[statusKey]}">
              <div class="ticket-card p-4 mb-4 rounded-lg shadow flex justify-between items-start cursor-move"
                   data-id="${t.id}" data-priority="${t.priority}">
                <div>
                  <h3 class="subject font-medium">${t.subject}</h3>
                  <p class="description text-sm mt-1">${t.description}</p>
                  <span class="inline-block mt-2 px-2 py-0.5 text-xs rounded
                               ${t.priority=='urgent'
                                 ? 'bg-red-200 text-red-800'
                                 : 'bg-green-200 text-green-800'}">
                    ${t.priority}
                  </span>
                </div>
                <div class="space-x-2 text-gray-500">
                  <i class="fa fa-edit edit-btn hover:text-blue-500 cursor-pointer"></i>
                  <i class="fa fa-trash delete-btn hover:text-red-500 cursor-pointer"></i>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:forEach>
      </div>
    </div>
  </main>

  

  <!-- Modal for Create/Edit -->
  <div id="modal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg w-full max-w-md relative">
      <button id="modal-close" class="absolute top-2 right-3 text-gray-500 hover:text-gray-700">&times;</button>
      <h2 id="modal-title" class="text-xl font-semibold mb-4"></h2>
      <!-- For Create we use AJAX, for Edit we submit normally -->
      <form id="ticket-form" class="space-y-4" method="post">
        <input type="hidden" name="id"/>
        <div>
          <label class="block text-sm">Subject</label>
          <input name="subject" type="text" required
                 class="w-full mt-1 p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:text-gray-100"/>
        </div>
        <div>
          <label class="block text-sm">Description</label>
          <textarea name="description" rows="3"
                    class="w-full mt-1 p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:text-gray-100"></textarea>
        </div>
        <div class="flex gap-4">
          <div>
            <label class="block text-sm">Priority</label>
            <select name="priority"
                    class="mt-1 p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:text-gray-100">
              <option value="normal">Normal</option>
              <option value="urgent">Urgent</option>
            </select>
          </div>
          <div id="status-field" class="hidden">
            <label class="block text-sm">Status</label>
            <select name="status"
                    class="mt-1 p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:text-gray-100">
              <option value="open">Open</option>
              <option value="in_progress">In Progress</option>
              <option value="closed">Closed</option>
            </select>
          </div>
        </div>
        <div class="flex justify-end gap-2">
          <button type="button" id="btn-cancel"
                  class="px-4 py-2 bg-gray-300 dark:bg-gray-600 rounded">Cancel</button>
          <button type="submit" id="btn-save"
                  class="px-4 py-2 bg-blue-600 text-white rounded">Save</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    const ctx = '${pageContext.request.contextPath}';
    const urls = {
      create: ctx + '/tickets/create',
      update: ctx + '/tickets/update',
      del:    ctx + '/tickets/delete',
      status: ctx + '/tickets/updateStatus'
    };

    function post(url, data) {
      return fetch(url, {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:new URLSearchParams(data)
      }).then(res => {
        if (!res.ok) throw new Error(res.statusText);
        return res;
      });
    }

    // Elements
    const modal   = document.getElementById('modal');
    const form    = document.getElementById('ticket-form');
    const statusF = document.getElementById('status-field');
    let isEdit    = false;

    // Open Create
    document.getElementById('btn-create').onclick = () => {
      isEdit = false;
      form.reset();
      statusF.classList.add('hidden');
      document.getElementById('modal-title').textContent = 'New Ticket';
      form.removeAttribute('action');
      modal.classList.remove('hidden');
    };

    // Open Edit
    document.querySelectorAll('.edit-btn').forEach(btn => {
      btn.onclick = e => {
        isEdit = true;
        const card = e.currentTarget.closest('.ticket-card');
        const id   = card.dataset.id;
        const subj = card.querySelector('.subject').textContent;
        const desc = card.querySelector('.description').textContent;
        form.reset();
        statusF.classList.remove('hidden');
        document.getElementById('modal-title').textContent = 'Edit Ticket';
        form.id.value          = id;
        form.subject.value     = subj;
        form.description.value = desc;
        form.priority.value    = card.dataset.priority;
        form.status.value      = card.closest('.status-column').id;
        form.setAttribute('action', urls.update);
        modal.classList.remove('hidden');
      };
    });

    // Close modal
    ['modal-close','btn-cancel'].forEach(id =>
      document.getElementById(id).onclick = () => modal.classList.add('hidden')
    );

    // Submit Form
    form.onsubmit = e => {
      e.preventDefault();
      if (isEdit) {
        // normal form post to update servlet → redirect
        form.submit();
      } else {
        // AJAX create then reload
        const data = new FormData(form);
        post(urls.create, data)
          .then(_=> location.reload())
          .catch(err=> alert('Create failed: '+err));
      }
    };

    // Delete
    document.querySelectorAll('.delete-btn').forEach(btn =>
      btn.onclick = e => {
        if (!confirm('Delete this ticket?')) return;
        const id = e.currentTarget.closest('.ticket-card').dataset.id;
        post(urls.del, {id})
          .then(_=> location.reload())
          .catch(err=> alert('Delete failed: '+err));
      }
    );

    // Drag & Drop + reload on drop
    ['open','in_progress','closed'].forEach(status => {
      Sortable.create(document.getElementById(status), {
        group: 'tickets', animation: 150,
        onEnd: evt => {
          const id   = evt.item.dataset.id;
          const dest = evt.to.id;
          post(urls.status, {id, status: dest})
            .then(_=> location.reload())
            .catch(err=> alert('Status update failed: '+err));
        }
      });
    });
  </script>
</body>
</html>
