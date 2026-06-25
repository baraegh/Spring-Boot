<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Movie Sessions">

    <div class="header-with-action">
        <h1>Movie Sessions</h1>
        <button class="btn-action" onclick="openModal('sessionModal')">+ Create New Session</button>
    </div>

    <!-- sessions list -->
    <table border="1">
        <tr>
            <th>#</th>
            <th>Film</th>
            <th>Hall</th>
            <th>Time</th>
            <th>Ticket Cost</th>
        </tr>
        <#list sessions as session>
            <tr>
                <td>${session?index + 1}</td>
                <td>${(session.film.title)!''}</td>
                <td>Hall ${(session.hall.serialNumber)!0}</td>
                <td>${session.formattedDateTime!'N/A'}</td>
                <td>$${session.ticketPrice!0}</td>
            </tr>
        <#else>
            <tr>
                <td colspan="5">No sessions yet</td>
            </tr>
        </#list>
    </table>

    <!-- Modal for Creating Session -->
    <div id="sessionModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Create New Session</h2>
                <button class="modal-close" onclick="closeModal('sessionModal')">&times;</button>
            </div>
            <form method="post" action="/cinema/admin/panel/sessions/save" class="modal-form">
                <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">

                <!-- film dropdown -->
                <div>
                    <label>Film:</label>
                    <select name="filmId" required>
                        <#list films as film>
                            <option value="${film.id}">${film.title} (${film.year})</option>
                        <#else>
                            <option disabled>No films available</option>
                        </#list>
                    </select>
                </div>

                <!-- hall dropdown -->
                <div>
                    <label>Hall:</label>
                    <select name="hallId" required>
                        <#list halls as hall>
                            <option value="${hall.id}">Hall ${hall.serialNumber!0} — ${hall.seatsCount!0} seats</option>
                        <#else>
                            <option disabled>No halls available</option>
                        </#list>
                    </select>
                </div>

                <!-- time -->
                <div>
                    <label>Date & Time:</label>
                    <input type="datetime-local" name="dateTime" required/>
                </div>

                <!-- ticket cost -->
                <div>
                    <label>Ticket Cost:</label>
                    <input type="number" name="ticketPrice" step="0.01" min="0" placeholder="0.00" required/>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('sessionModal')">Cancel</button>
                    <button type="submit" class="btn-submit">Create Session</button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>