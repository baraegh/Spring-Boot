<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("session.details.title")>
    <h1>${springMacroRequestContext.getMessage("session.details.title")}</h1>
    
    <#if session??>
        <div class="session-details profile-card">
            <div class="profile-poster">
                <#if session.film?? && session.film.posterUrl??>
                    <img src="${session.film.posterUrl}" alt="${springMacroRequestContext.getMessage("session.details.posterAlt")}" />
                <#else>
                    <div class="no-poster">${springMacroRequestContext.getMessage("session.details.noPoster")}</div>
                </#if>
            </div>

            <div class="profile-info">
                <h2>${(session.film.title)!''}</h2>

                <p><strong>${springMacroRequestContext.getMessage("session.details.price")}:</strong> $${session.ticketPrice!0}</p>
                <p><strong>${springMacroRequestContext.getMessage("session.details.datetime")}:</strong> ${session.formattedDateTime!''}</p>
                <p><strong>${springMacroRequestContext.getMessage("session.details.hall")}:</strong> ${(session.hall.serialNumber)!''}</p>
                <p><strong>${springMacroRequestContext.getMessage("session.details.description")}:</strong> ${(session.film.description)!''}</p>
                <p>
                    <strong>${springMacroRequestContext.getMessage("session.details.chat")}:</strong>
                    <a href="/cinema/films/${(session.film.id)!''}/chat">
                        ${springMacroRequestContext.getMessage("session.details.joinChat")}
                    </a>
                </p>
            </div>
        </div>
    <#else>
        <p>${springMacroRequestContext.getMessage("session.details.notFound")}</p>
    </#if>
    
    <a href="/cinema/sessions">${springMacroRequestContext.getMessage("session.details.back")}</a>
</@layout.mainLayout>