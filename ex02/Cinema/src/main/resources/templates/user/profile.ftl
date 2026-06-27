<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("profile.title")>
<div class="profile-view-wrapper">

    <#if errors??>
        <div class="alert-error">
            <#list errors as err>
                <p>${err.defaultMessage}</p>
            </#list>
        </div>
    </#if>

    <div class="profile-card">
        <div class="profile-poster">
            <#if currentUser.avatarUrl??>
                <img src="${currentUser.avatarUrl}"
                     alt="${springMacroRequestContext.getMessage('profile.avatar.alt')}">
            <#else>
                <div class="no-poster">👤</div>
            </#if>
        </div>

        <div class="profile-info">
            <h2>
                ${currentUser.firstName()!""}
                ${currentUser.lastName()!""}
            </h2>

            <div class="profile-meta-grid">

                <div class="user-info">
                    <span class="info-label">
                        ${springMacroRequestContext.getMessage("profile.username")}
                    </span>
                    <span class="info-value">
                        @${currentUser.username()!
                        springMacroRequestContext.getMessage("profile.anonymous")}
                    </span>
                </div>

                <div class="user-info">
                    <span class="info-label">
                        ${springMacroRequestContext.getMessage("profile.email")}
                    </span>
                    <span class="info-value">
                        ${currentUser.email()!
                        springMacroRequestContext.getMessage("profile.unassigned")}
                    </span>
                </div>

                <div class="user-info">
                    <span class="info-label">
                        ${springMacroRequestContext.getMessage("profile.phone")}
                    </span>
                    <span class="info-value">
                        ${currentUser.phoneNumber()!
                        springMacroRequestContext.getMessage("profile.unassigned")}
                    </span>
                </div>

                <div class="user-info">
                    <span class="info-label">
                        ${springMacroRequestContext.getMessage("profile.createdAt")}
                    </span>
                    <span class="info-value">
                        ${currentUser.createdAt()!
                        springMacroRequestContext.getMessage("profile.notDefined")}
                    </span>
                </div>

            </div>
        </div>
    </div>
</div>
</@layout.mainLayout>