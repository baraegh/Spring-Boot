<#macro mainLayout title>
<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <link rel="stylesheet" href="/cinema/css/style.css"/>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<body>

    <!-- navbar — shared across all pages -->
    <nav>
        <a href="/cinema/sessions">Search</a>
        <#if isAdmin>
            <a href="/cinema/admin/panel/halls">Halls</a>
            <a href="/cinema/admin/panel/films">Films</a>
            <a href="/cinema/admin/panel/sessions">Sessions</a>
        </#if>

        <div class="nav-right">
            <a href="/cinema/profile" class="profile-link">
                👤
            </a>

            <form action="/cinema/logout" method="POST" class="nav-logout-form">
                <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">
                <button type="submit" class="btn-action">
                    ↩️
                </button>
            </form>
        </div>
    </nav>

    <!-- page specific content goes here -->
    <div class="content">
        <#nested>
    </div>

    <!-- footer — shared across all pages -->
    <footer>
        <p>Cinema App</p>
    </footer>

    <!-- Modal Script -->
    <script>
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.add('show');
            }
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.remove('show');
            }
        }

        // Close modal when clicking outside the modal content
        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
            }
        });

        // Close modal when pressing Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                const modals = document.querySelectorAll('.modal.show');
                modals.forEach(modal => {
                    modal.classList.remove('show');
                });
            }
        });
    </script>

</body>
</html>
</#macro>