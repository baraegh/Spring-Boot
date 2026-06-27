<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("chat.title")>

<div class="chat-container">
    <div class="chat-main">
        <div class="chat-header">
            <h2>
                💬 ${springMacroRequestContext.getMessage("chat.header")}
                - ${(film.title)!springMacroRequestContext.getMessage("chat.unknownFilm")}
            </h2>
        </div>

        <div class="messages-area" id="messagesContainer">
            <#list initialMessages?reverse as msg>
                <div class="message">
                    <div class="message-header">
                        <span class="message-user">
                            ${msg.userId!springMacroRequestContext.getMessage("chat.user.anonymous")}
                        </span>
                        <span class="message-time">${msg.formattedDateTime!" - "}</span>
                    </div>
                    <div class="message-text">${msg.msg!""}</div>
                </div>
            <#else>
                <div class="no-messages">
                    ${springMacroRequestContext.getMessage("chat.noMessages")}
                </div>
            </#list>
        </div>

        <div class="input-area">
            <div class="input-group">
                <input 
                    type="text" 
                    id="messageInput" 
                    placeholder="${springMacroRequestContext.getMessage("chat.input.placeholder")}"
                    autocomplete="off"
                />
                <button id="sendBtn">
                    ${springMacroRequestContext.getMessage("chat.send")}
                </button>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div id="connectionStatus" class="connection-status disconnected">
            ${springMacroRequestContext.getMessage("chat.disconnected")}
        </div>
    </div>

    <div class="sidebar-panel merged-avatar-panel" id="mergedAvatarPanel">
        <div class="merged-avatar-header">
            <div class="sidebar-title">
                ${springMacroRequestContext.getMessage("chat.avatar.title")}
            </div>

            <form id="uploadForm" class="upload-form" method="POST" enctype="multipart/form-data">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <div class="file-input-wrapper">
                    <input type="file" id="imageInput" name="image" accept="image/*" required/>
                    <label for="imageInput" class="file-input-label">
                        ${springMacroRequestContext.getMessage("chat.avatar.choose")}
                    </label>
                </div>

                <button type="submit" id="uploadBtn">
                    ${springMacroRequestContext.getMessage("chat.avatar.upload")}
                </button>
            </form>
        </div>

        <div class="merged-avatar-body">
            <div class="merged-avatar-preview">
                <div class="sidebar-title merged-subtitle">
                    ${springMacroRequestContext.getMessage("chat.avatar.preview")}
                </div>
                <div id="imagePreview" class="image-preview-box">
                    <div id="previewPlaceholder" class="preview-placeholder">
                        ${springMacroRequestContext.getMessage("chat.avatar.noSelection")}
                    </div>
                </div>
            </div>
        </div>

        <div style="margin-top:1rem;">
            <div class="sidebar-title" style="font-size:0.95rem; margin-bottom:0.5rem;">
                ${springMacroRequestContext.getMessage("chat.avatar.uploaded")}
            </div>

            <div class="scrollable img-items">
                <#list avatars as a>
                    <div class="image-item">
                        <a href="${a.url}" target="_blank">${a.fileName}</a>
                    </div>
                <#else>
                    <div class="images-list" id="imagesList">
                        <div style="color: var(--text-muted); font-size: 0.85rem;">
                            ${springMacroRequestContext.getMessage("chat.avatar.empty")}
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
    var filmId = ${filmId!0};
    var userId = '${chatUserId?js_string}';

    const MSG_CONNECTED = '${springMacroRequestContext.getMessage("chat.connected")?js_string}';
    const MSG_DISCONNECTED = '${springMacroRequestContext.getMessage("chat.disconnected")?js_string}';
    const MSG_ANONYMOUS = '${springMacroRequestContext.getMessage("chat.user.anonymous")?js_string}';
    const MSG_NO_SELECTION = '${springMacroRequestContext.getMessage("chat.avatar.noSelection")?js_string}';

    document.addEventListener('DOMContentLoaded', function() {
        var stompClient = null;
        var isConnected = false;

        var messagesContainer = document.getElementById('messagesContainer');
        var messageInput = document.getElementById('messageInput');
        var sendBtn = document.getElementById('sendBtn');

        function removeEmptyState() {
            var emptyState = messagesContainer.querySelector('.no-messages');
            if (emptyState) {
                emptyState.remove();
            }
        }

        function scrollMessagesToBottom() {
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function updateConnectionStatus(connected) {
            var statusEl = document.getElementById('connectionStatus');
            if (!statusEl) {
                return;
            }

            statusEl.classList.remove('connected', 'disconnected');
            statusEl.classList.add(connected ? 'connected' : 'disconnected');
            statusEl.textContent = connected ? MSG_CONNECTED : MSG_DISCONNECTED;
        }

        function escapeHtml(value) {
            return String(value || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#039;');
        }

        function displayMessage(message) {
            removeEmptyState();

            var messageElement = document.createElement('div');
            messageElement.className = 'message';

            var formattedTime = message.formattedDateTime || '';
            if (!formattedTime && message.dateTime) {
                var timeValue = new Date(message.dateTime);
                formattedTime = timeValue && !Number.isNaN(timeValue.getTime())
                    ? timeValue.toLocaleString()
                    : '';
            }

            messageElement.innerHTML =
                '<div class="message-header">' +
                    '<span class="message-user">' + escapeHtml(message.userId || MSG_ANONYMOUS) + '</span>' +
                    '<span class="message-time">' + escapeHtml(formattedTime) + '</span>' +
                '</div>' +
                '<div class="message-text">' + escapeHtml(message.msg || '') + '</div>';

            messagesContainer.appendChild(messageElement);
            scrollMessagesToBottom();
        }

        function connect() {
            var socket = new SockJS('/cinema/ws');
            stompClient = Stomp.over(socket);
            stompClient.debug = null;

            stompClient.connect({}, function() {
                isConnected = true;
                updateConnectionStatus(true);

                stompClient.subscribe('/topic/films/' + filmId + '/chat', function(message) {
                    displayMessage(JSON.parse(message.body));
                });
            }, function() {
                isConnected = false;
                updateConnectionStatus(false);
                setTimeout(connect, 5000);
            });
        }

        function sendMessage(text) {
            stompClient.send(
                '/app/films/' + filmId + '/chat',
                {},
                JSON.stringify({
                    msg: text,
                    filmId: filmId
                })
            );
        }

        sendBtn.addEventListener('click', function() {
            var text = messageInput.value.trim();

            if (text && stompClient && isConnected) {
                sendMessage(text);
                messageInput.value = '';
            }
        });

        messageInput.addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                sendBtn.click();
            }
        });

        window.addEventListener('beforeunload', function() {
            if (stompClient) {
                stompClient.disconnect();
            }
        });

        var imageInput = document.getElementById('imageInput');
        var imagePreview = document.getElementById('imagePreview');
        var previewPlaceholder = document.getElementById('previewPlaceholder');
        var uploadForm = document.getElementById('uploadForm');

        function clearPreview() {
            if (!imagePreview) {
                return;
            }

            var img = imagePreview.querySelector('img');
            if (img) {
                img.remove();
            }

            var other = imagePreview.querySelector('div');
            if (other) {
                other.remove();
            }

            if (previewPlaceholder) {
                previewPlaceholder.textContent = MSG_NO_SELECTION;
            }
        }

        if (uploadForm) {
            uploadForm.action =
                '/cinema/avatar/' +
                encodeURIComponent(userId) +
                '/' +
                filmId;
        }

        if (imageInput) {
            imageInput.addEventListener('change', function() {
                var file = this.files && this.files[0];
                clearPreview();

                if (!file) {
                    return;
                }

                if (file.type && file.type.indexOf('image') === 0) {
                    var img = document.createElement('img');
                    img.src = URL.createObjectURL(file);
                    img.onload = function() {
                        URL.revokeObjectURL(this.src);
                    };
                    img.style.maxWidth = '100%';
                    img.style.maxHeight = '140px';
                    img.style.borderRadius = '6px';
                    imagePreview.appendChild(img);
                } else {
                    var nod = document.createElement('div');
                    nod.textContent = file.name;
                    nod.style.color = 'var(--text)';
                    nod.style.wordBreak = 'break-all';
                    imagePreview.appendChild(nod);
                }
            });
        }

        updateConnectionStatus(false);
        scrollMessagesToBottom();
        connect();
    });
</script>

</@layout.mainLayout>
