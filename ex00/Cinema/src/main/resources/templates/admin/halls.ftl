<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Movie Halls">
    <div class="header-with-action">
        <h1>Movie Halls</h1>
        <button class="btn-action" onclick="openModal('hallModal')">+ Create New Hall</button>
    </div>

    <table border="1">
        <tr>
            <th>Number</th>
            <th>Seats</th>
        </tr>
        <#list halls as hall>
            <tr>
                <td>${hall.serialNumber!0}</td>
                <td>${hall.seatsCount!0}</td>
            </tr>
        <#else>
            <tr>
                <td colspan="2">No halls yet</td>
            </tr>
        </#list>
    </table>

    <!-- Modal for Creating Hall -->
    <div id="hallModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Create New Hall</h2>
                <button class="modal-close" onclick="closeModal('hallModal')">&times;</button>
            </div>
            <form method="post" action="/cinema/admin/panel/halls/save" class="modal-form">
                <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">

                <div>
                    <label>Hall number</label>
                    <input type="number" name="serialNumber" placeholder="Hall number" required/>
                </div>
                <div>
                    <label>Seats</label>
                    <input type="number" name="seatsCount" placeholder="Seats" required/>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('hallModal')">Cancel</button>
                    <button type="submit" class="btn-submit">Create</button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>