<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("admin.sessions.title")>

    <div class="header-with-action">
        <h1>${springMacroRequestContext.getMessage("admin.sessions.heading")}</h1>
        <button class="btn-action" onclick="openModal('sessionModal')">
            ${springMacroRequestContext.getMessage("admin.sessions.create")}
        </button>
    </div>

    <table border="1">
        <tr>
            <th>${springMacroRequestContext.getMessage("admin.sessions.index")}</th>
            <th>${springMacroRequestContext.getMessage("admin.sessions.film")}</th>
            <th>${springMacroRequestContext.getMessage("admin.sessions.hall")}</th>
            <th>${springMacroRequestContext.getMessage("admin.sessions.time")}</th>
            <th>${springMacroRequestContext.getMessage("admin.sessions.ticketCost")}</th>
        </tr>

        <#list sessions as session>
            <tr>
                <td>${session?index + 1}</td>
                <td>${(session.film.title)!''}</td>
                <td>${springMacroRequestContext.getMessage("admin.sessions.hall")} ${(session.hall.serialNumber)!0}</td>
                <td>${session.formattedDateTime!springMacroRequestContext.getMessage("admin.sessions.na")}</td>
                <td>$${session.ticketPrice!0}</td>
            </tr>
        <#else>
            <tr>
                <td colspan="5">${springMacroRequestContext.getMessage("admin.sessions.empty")}</td>
            </tr>
        </#list>
    </table>

    <div id="sessionModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>${springMacroRequestContext.getMessage("admin.sessions.modal.title")}</h2>
                <button class="modal-close" onclick="closeModal('sessionModal')">&times;</button>
            </div>

            <form method="post" action="/cinema/admin/panel/sessions/save" class="modal-form">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <div>
                    <label>${springMacroRequestContext.getMessage("admin.sessions.form.film")}</label>
                    <select name="filmId" required>
                        <#list films as film>
                            <option value="${film.id}">${film.title} (${film.year})</option>
                        <#else>
                            <option disabled>
                                ${springMacroRequestContext.getMessage("admin.sessions.form.noFilms")}
                            </option>
                        </#list>
                    </select>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("admin.sessions.form.hall")}</label>
                    <select name="hallId" required>
                        <#list halls as hall>
                            <option value="${hall.id}">
                                ${springMacroRequestContext.getMessage("admin.sessions.hall")}
                                ${hall.serialNumber!0}
                                —
                                ${hall.seatsCount!0}
                                ${springMacroRequestContext.getMessage("admin.sessions.form.seats")}
                            </option>
                        <#else>
                            <option disabled>
                                ${springMacroRequestContext.getMessage("admin.sessions.form.noHalls")}
                            </option>
                        </#list>
                    </select>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("admin.sessions.form.datetime")}</label>
                    <input type="datetime-local" name="dateTime" required/>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("admin.sessions.form.ticketCost")}</label>
                    <input type="number" name="ticketPrice" step="0.01" min="0" placeholder="0.00" required/>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('sessionModal')">
                        ${springMacroRequestContext.getMessage("admin.sessions.form.cancel")}
                    </button>
                    <button type="submit" class="btn-submit">
                        ${springMacroRequestContext.getMessage("admin.sessions.form.submit")}
                    </button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>