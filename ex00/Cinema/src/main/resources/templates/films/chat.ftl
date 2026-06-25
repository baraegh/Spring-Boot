<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Film Chat - Cinema">

<div class="chat-container">
    <!-- Main Chat Area -->
    <div class="chat-main">
        <div class="chat-header">
            <h2>💬 Film Discussion - ${(film.title)!"Unknown film"}</h2>
        </div>

        <div class="messages-area" id="messagesContainer">
            <#list initialMessages?reverse as msg>
                <div class="message">
                    <div class="message-header">
                    <span class="message-user">${msg.userId!"Anonymous"}</span>
                    <span class="message-time">${msg.formattedDateTime!" - "}</span>
                    </div>
                    <div class="message-text">${msg.msg!""}</div>
                </div>
            <#else>
                <div class="no-messages">No messages yet</div>
            </#list>
        </div>

        <div class="input-area">
            <div class="input-group">
                <input 
                    type="text" 
                    id="messageInput" 
                    placeholder="Type your message here..."
                    autocomplete="off"
                />
                <button id="sendBtn">Send</button>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div id="connectionStatus" class="connection-status disconnected">
            ⚫ Disconnected
        </div>

        <div class="sidebar-panel" id="authPanel">
            <div class="sidebar-title">Your Authentication History</div>
            <div class="scrollable" id="authScroll">
                <#list userAuthentication as us >
                    <div class="user-info ">
                        <div class="info-label">User ID</div>
                        <div class="info-value" id="userIdDisplay">${us.userId!"-"}</div>
                        <div class="info-label">IP Address</div>
                        <div class="info-value" id="ipAddressDisplay">${us.ipAdress!"-"}</div>
                        <div class="info-label">Date & Time</div>
                        <div class="info-value" id="dateTime">${us.formattedDateTime!"-"}</div>
                    </div>
                <#else>
                    <div class="user-info">
                        <div class="info-value">No record yet</div>
                    </div>
                </#list>
            </div>
        </div>
    </div>


    <div class="sidebar-panel merged-avatar-panel" id="mergedAvatarPanel">
        <div class="merged-avatar-header">
            <div class="sidebar-title">Avatars & Upload</div>

            <form id="uploadForm" class="upload-form"
                method="POST"
                enctype="multipart/form-data"
            >
                <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">

                <div class="file-input-wrapper">
                    <input type="file" id="imageInput" name="image" accept="image/*" required/>
                    <label for="imageInput" class="file-input-label">Choose Image</label>
                </div>
                <button type="submit" id="uploadBtn">Upload</button>
            </form>
        </div>

        <div class="merged-avatar-body">
            <div class="merged-avatar-preview">
                <div class="sidebar-title merged-subtitle">Preview</div>
                <div id="imagePreview" class="image-preview-box">
                    <div id="previewPlaceholder" class="preview-placeholder">No image selected</div>
                </div>
            </div>
        </div>

        <div style="margin-top:1rem;">
            <div class="sidebar-title" style="font-size:0.95rem; margin-bottom:0.5rem;">Uploaded Avatars</div>
            <div class="scrollable img-items">
                <#list avatars as a >
                    <div class="image-item">
                        <a href="${a.url}" target="_blank">${a.fileName}</a>
                    </div>
                <#else>
                    <div class="images-list" id="imagesList">
                        <div style="color: var(--text-muted); font-size: 0.85rem;">No images uploaded</div>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div>


<!-- SockJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

<!-- STOMP over SockJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
    var filmId = ${filmId!0};

    function setCookie(name, value, days) {
        var expires = '';
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = '; expires=' + date.toUTCString();
        }
        document.cookie = name + '=' + value + expires + '; path=/';
    }

    function getCookie(name) {
        var nameEQ = name + '=';
        var cookies = document.cookie.split(';');

        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i].trim();
            if (cookie.indexOf(nameEQ) === 0) {
                return cookie.substring(nameEQ.length);
            }
        }
        return null;
    }

    function getOrCreateUUID() {
        var existing = getCookie('userId');
        if (existing) {
            return existing;
        }
        var uuid = crypto.randomUUID();
        setCookie('userId', uuid, 30);
        return uuid;
    }

    document.addEventListener('DOMContentLoaded', function() {
        var stompClient = null;
        var isConnected = false;
        var userId = getOrCreateUUID();
        var messagesContainer = document.getElementById('messagesContainer');
        var messageInput = document.getElementById('messageInput');
        var sendBtn = document.getElementById('sendBtn');
        var renderedMessages = new Set();
        
        function buildMessageKey(message) {
            if (message.id) {
                return 'id:' + message.id;
            }
            return 'fallback:' + (message.userId || '') + '|' + (message.msg || '') + '|' + (message.dateTime || '');
        }

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
            statusEl.textContent = connected ? '⚫ Connected' : '⚫ Disconnected';
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
                    '<span class="message-user">' + (message.userId || 'Anonymous') + '</span>' +
                    '<span class="message-time">' + formattedTime + '</span>' +
                '</div>' +
                '<div class="message-text">' + (message.msg || '') + '</div>';

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
                console.log('Connected');

                stompClient.subscribe('/topic/films/' + filmId + '/chat', function(message) {
                    displayMessage(JSON.parse(message.body));
                });
            }, function() {
                isConnected = false;
                updateConnectionStatus(false);
                console.log('Connection lost - reconnecting in 5s...');
                setTimeout(connect, 5000);
            });
        }

        function sendMessage(text) {
            stompClient.send(
                '/app/films/' + filmId + '/chat',
                {},
                JSON.stringify({
                    userId: userId,
                    msg: text,
                    filmId: filmId
                })
            );
        }

        sendBtn.addEventListener('click', function() {
            var text = messageInput.value.trim();
            if (text) {
                if (stompClient && isConnected) {
                    sendMessage(text);
                }
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

        // --- Avatar preview ---
        var imageInput = document.getElementById('imageInput');
        var imagePreview = document.getElementById('imagePreview');
        var previewPlaceholder = document.getElementById('previewPlaceholder');
        var imagesList = document.getElementById('imagesList');
        var uploadForm = document.getElementById('uploadForm');

        function clearPreview() {
            if (!imagePreview) return;
            var img = imagePreview.querySelector('img');
            if (img) img.remove();
            var other = imagePreview.querySelector('div');
            if (other) other.remove();
            if (previewPlaceholder) previewPlaceholder.textContent = 'No image selected';
        }

        if (uploadForm) {
            uploadForm.action = '/cinema/avatar/' + userId + "/" + filmId;
        }

        if (imageInput) {
            imageInput.addEventListener('change', function() {
                var file = this.files && this.files[0];
                clearPreview();
                if (!file) return;
                if (file.type && file.type.indexOf('image') === 0) {
                    var img = document.createElement('img');
                    img.src = URL.createObjectURL(file);
                    img.onload = function() { URL.revokeObjectURL(this.src); };
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

        function matchAuthPanelHeight() {
            var chatMain = document.querySelector('.chat-main');
            var authPanel = document.getElementById('authPanel');
            if (chatMain && authPanel) {
                authPanel.style.maxHeight = chatMain.offsetHeight + 'px';
                authPanel.style.overflow = '';
            }
        }

        updateConnectionStatus(false);
        scrollMessagesToBottom();
        connect();
    });
</script>

</@layout.mainLayout>
