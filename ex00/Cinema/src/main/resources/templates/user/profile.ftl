<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Profile">
<div class="profile-view-wrapper">

    <div class="header-with-action">
        <h1>Profile</h1>
        <button class="btn-action" onclick="openModal('editProfileModal')">Edit</button>
    </div>

    <div class="profile-card">
        <div class="profile-poster">
            <#if currentUser.avatarUrl??>
                <img src="${currentUser.avatarUrl}" alt="Avatar">
            <#else>
                <div class="no-poster">👤</div>
            </#if>
        </div>

        <div class="profile-info">
            <h2>${currentUser.firstName()!""} ${currentUser.lastName()!"-"}</h2>

            <div class="profile-meta-grid">
                <div class="user-info">
                    <span class="info-label">Username</span>
                    <span class="info-value">@${currentUser.username()!"anonymous"}</span>
                </div>

                <div class="user-info">
                    <span class="info-label">Email</span>
                    <span class="info-value">${currentUser.email()!"unassigned"}</span>
                </div>

                <div class="user-info">
                    <span class="info-label">Account Created at</span>
                    <span class="info-value">${currentUser.createdAt()!"not defined"}</span>
                </div>
            </div>
        </div>
    </div>

    <div id="editProfileModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Profile</h2>
                <button class="modal-close" onclick="closeModal('editProfileModal')">&times;</button>
            </div>

            <form action="/cinema/profile/save" method="POST" class="modal-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <input type="hidden" name="id" value="${currentUser.id()}"/>

                <div>
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" value="${currentUser.firstName()!''}" required>
                </div>

                <div>
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" value="${currentUser.lastName()!''}" required>
                </div>

                <div>
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${currentUser.email()!''}" required>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeModal('editProfileModal')">Cancel</button>
                    <button type="submit" class="btn-submit">Update</button>
                </div>
            </form>
        </div>
    </div>

</div>
</@layout.mainLayout>