<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("films.title")>

    <div class="header-with-action">
        <h1>${springMacroRequestContext.getMessage("films.heading")}</h1>
        <button class="btn-action" onclick="openModal('filmModal')">
            ${springMacroRequestContext.getMessage("films.add")}
        </button>
    </div>

    <table border="1">
        <tr>
            <th>${springMacroRequestContext.getMessage("films.table.title")}</th>
            <th>${springMacroRequestContext.getMessage("films.table.year")}</th>
            <th>${springMacroRequestContext.getMessage("films.table.ageRestriction")}</th>
            <th>${springMacroRequestContext.getMessage("films.table.description")}</th>
            <th>${springMacroRequestContext.getMessage("films.table.poster")}</th>
            <th>${springMacroRequestContext.getMessage("films.table.chat")}</th>
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
                        ${springMacroRequestContext.getMessage("films.noPoster")}
                    </#if>
                </td>
                <td>
                    <a href="/cinema/films/${film.id}/chat">
                        ${springMacroRequestContext.getMessage("films.table.chat")}
                    </a>
                </td>
            </tr>
        <#else>
            <tr>
                <td colspan="6">${springMacroRequestContext.getMessage("films.noFilms")}</td>
            </tr>
        </#list>
    </table>

    <div id="filmModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>${springMacroRequestContext.getMessage("films.modal.title")}</h2>
                <button class="modal-close" onclick="closeModal('filmModal')">&times;</button>
            </div>

            <form method="post"
                  action="/cinema/admin/panel/films/save"
                  enctype="multipart/form-data"
                  class="modal-form">

                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">
                
                <div>
                    <label>${springMacroRequestContext.getMessage("films.form.title")}</label>
                    <input type="text"
                           name="title"
                           placeholder="${springMacroRequestContext.getMessage("films.form.title.placeholder")}"
                           required/>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("films.form.year")}</label>
                    <input type="text"
                           name="year"
                           placeholder="${springMacroRequestContext.getMessage("films.form.year.placeholder")}"
                           required/>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("films.form.ageRestriction")}</label>
                    <input type="number"
                           name="ageRestrictions"
                           placeholder="${springMacroRequestContext.getMessage("films.form.ageRestriction.placeholder")}"
                           required/>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("films.form.description")}</label>
                    <textarea name="description"
                              placeholder="${springMacroRequestContext.getMessage("films.form.description.placeholder")}"
                              required></textarea>
                </div>

                <div>
                    <label>${springMacroRequestContext.getMessage("films.form.poster")}</label>
                    <input type="file" name="poster"/>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('filmModal')">
                        ${springMacroRequestContext.getMessage("films.form.cancel")}
                    </button>
                    <button type="submit" class="btn-submit">
                        ${springMacroRequestContext.getMessage("films.form.submit")}
                    </button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>