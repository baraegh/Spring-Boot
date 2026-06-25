<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Session Details">
    <h1>Session Details</h1>
    
    <#if session??>
        <div class="session-details profile-card">
            <div class="profile-poster">
                <#if session.film.posterUrl??>
                    <img src="${session.film.posterUrl}" alt="Film Poster" />
                <#else>
                    <div class="no-poster">No Poster</div>
                </#if>
            </div>
            <div class="profile-info">
                <h2>${session.film.title!''}</h2>
                <p><strong>Price:</strong> $${session.ticketPrice!0}</p>
                <p><strong>Date & time:</strong> ${session.formattedDateTime!''}</p>
                <p><strong>Hall:</strong> ${session.hall.serialNumber!''}</p>
                <p><strong>Description:</strong> $${session.film.description!''}</p>
                <p><strong>Chat:</strong> <a href="/cinema/films/${session.film.id}/chat">Join Chat</a></p>
            </div>
        </div>
    <#else>
        <p>No session found.</p>
    </#if>
    
    <a href="/cinema/sessions">Back to Sessions</a>
</@layout.mainLayout>