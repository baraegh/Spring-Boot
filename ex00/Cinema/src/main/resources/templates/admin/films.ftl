<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Movies">

    <div class="header-with-action">
        <h1>Movies</h1>
        <button class="btn-action" onclick="openModal('filmModal')">+ Add New Film</button>
    </div>

    <table border="1">
        <tr>
            <th>Title</th>
            <th>Year</th>
            <th>Age Restriction</th>
            <th>Description</th>
            <th>Poster</th>
            <th>Chat</th>
        </tr>
        <#list films as film>
            <tr>
                <td>${film.title!''}</td>
                <td>${film.year!0}</td>
                <td>+${film.ageRestrictions!0}</td>
                <td>${film.description!''}</td>
                <td>
                    <#if film.posterUrl??>
                        <img src="${film.posterUrl}" width="60"/>
                    <#else>
                        No poster
                    </#if>
                </td>
                <td>
                    <a href="/cinema/films/${film.id}/chat">Chat</a>
                </td>
            </tr>
        <#else>
            <tr>
                <td colspan="5">No films yet</td>
            </tr>
        </#list>
    </table>

    <!-- Modal for Adding Film -->
    <div id="filmModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Film</h2>
                <button class="modal-close" onclick="closeModal('filmModal')">&times;</button>
            </div>
            <form method="post" action="/cinema/admin/panel/films/save" enctype="multipart/form-data" class="modal-form">
                <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">
                
                <div>
                    <label>Title</label>
                    <input type="text" name="title" placeholder="Title" required/>
                </div>
                <div>
                    <label>Year</label>
                    <input type="text" name="year" placeholder="Year" required/>
                </div>
                <div>
                    <label>Age Restriction</label>
                    <input type="number" name="ageRestrictions" placeholder="Age restriction" required/>
                </div>
                <div>
                    <label>Description</label>
                    <textarea name="description" placeholder="Description" required></textarea>
                </div>
                <div>
                    <label>Poster</label>
                    <input type="file" name="poster"/>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('filmModal')">Cancel</button>
                    <button type="submit" class="btn-submit">Add Film</button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>