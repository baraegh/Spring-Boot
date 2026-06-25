<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("halls.title")>
    <div class="header-with-action">
        <h1>${springMacroRequestContext.getMessage("halls.heading")}</h1>
        <button class="btn-action" onclick="openModal('hallModal')">
            ${springMacroRequestContext.getMessage("halls.create")}
        </button>
    </div>

    <table border="1">
        <tr>
            <th>${springMacroRequestContext.getMessage("halls.number")}</th>
            <th>${springMacroRequestContext.getMessage("halls.seats")}</th>
        </tr>
        <#list halls as hall>
            <tr>
                <td>${hall.serialNumber!0}</td>
                <td>${hall.seatsCount!0}</td>
            </tr>
        <#else>
            <tr>
                <td colspan="2">${springMacroRequestContext.getMessage("halls.empty")}</td>
            </tr>
        </#list>
    </table>

    <div id="hallModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>${springMacroRequestContext.getMessage("halls.modal.title")}</h2>
                <button class="modal-close" onclick="closeModal('hallModal')">&times;</button>
            </div>

            <form method="post" action="/cinema/admin/panel/halls/save" class="modal-form">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <div>
                    <label>${springMacroRequestContext.getMessage("halls.form.number")}</label>
                    <input type="number"
                           name="serialNumber"
                           placeholder="${springMacroRequestContext.getMessage("halls.form.number.placeholder")}"
                           required/>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("halls.form.seats")}</label>
                    <input type="number"
                           name="seatsCount"
                           placeholder="${springMacroRequestContext.getMessage("halls.form.seats.placeholder")}"
                           required/>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('hallModal')">
                        ${springMacroRequestContext.getMessage("halls.form.cancel")}
                    </button>
                    <button type="submit" class="btn-submit">
                        ${springMacroRequestContext.getMessage("halls.form.submit")}
                    </button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>