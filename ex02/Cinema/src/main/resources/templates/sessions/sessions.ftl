<#import "../layout.ftl" as layout>

<@layout.mainLayout title=springMacroRequestContext.getMessage("sessions.search.title")>

    <h1>${springMacroRequestContext.getMessage("sessions.search.heading")}</h1>

    <div class="search-wrapper">
        <input type="text"
               id="searchInput"
               placeholder="${springMacroRequestContext.getMessage("sessions.search.placeholder")}"
               autocomplete="off"/>
    </div>

    <div id="resultsContainer">
        <p id="message" style="color:var(--text-muted);margin-top:1rem;">
            ${springMacroRequestContext.getMessage("sessions.search.start")}
        </p>
    </div>

    <script>
    const MSG_START = '${springMacroRequestContext.getMessage("sessions.search.start")?js_string}';
    const MSG_SEARCHING = '${springMacroRequestContext.getMessage("sessions.search.searching")?js_string}';
    const MSG_EMPTY = '${springMacroRequestContext.getMessage("sessions.search.empty")?js_string}';
    const MSG_EMPTY_FOR = '${springMacroRequestContext.getMessage("sessions.search.emptyFor")?js_string}';
    const MSG_ERROR = '${springMacroRequestContext.getMessage("sessions.search.error")?js_string}';
    const MSG_NO_POSTER = '${springMacroRequestContext.getMessage("sessions.search.noPoster")?js_string}';

    $(function() {

        function renderSessions(sessions, emptyMessage) {
            var html = '';

            if (sessions.length === 0) {
                html = '<p style="color:var(--text-muted);margin-top:1rem;">' + emptyMessage + '</p>';
            } else {
                html = '<div class="cards">';
                sessions.forEach(function(session) {
                    var poster = session.film?.posterUrl
                        ? '<img src="' + session.film.posterUrl + '"/>'
                        : '<div class="no-poster">' + MSG_NO_POSTER + '</div>';

                    html +=
                        '<a href="/cinema/sessions/' + session.id + '" class="card">' +
                            '<div class="card-poster">' + poster + '</div>' +
                            '<div class="card-body">' +
                                '<h3>' + (session.film?.name || '') + '</h3>' +
                                '<p>' + session.dateTime + '</p>' +
                                '<span class="price">$' + session.ticketPrice + '</span>' +
                            '</div>' +
                        '</a>';
                });
                html += '</div>';
            }

            $('#resultsContainer').html(html);
        }

        $.ajax({
            url: '/cinema/sessions/all',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                renderSessions(response.sessions, MSG_EMPTY);
            },
            error: function() {
                $('#resultsContainer').html('<p style="color:var(--danger);margin-top:1rem;">' + MSG_ERROR + '</p>');
            }
        });

        $('#searchInput').on('input', function() {
            var filmName = $(this).val();

            if (filmName.length < 1) {
                $('#resultsContainer').html('<p id="message" style="color:var(--text-muted);margin-top:1rem;">' + MSG_START + '</p>');
                return;
            }

            $('#resultsContainer').html('<p style="color:var(--text-muted);margin-top:1rem;">' + MSG_SEARCHING + '</p>');

            $.ajax({
                url: '/cinema/sessions/search',
                method: 'GET',
                data: { filmName: filmName },
                dataType: 'json',
                success: function(response) {
                    renderSessions(response.sessions, MSG_EMPTY_FOR + ' "' + filmName + '"');
                },
                error: function() {
                    $('#resultsContainer').html('<p style="color:var(--danger);margin-top:1rem;">' + MSG_ERROR + '</p>');
                }
            });
        });

    });
    </script>

</@layout.mainLayout>