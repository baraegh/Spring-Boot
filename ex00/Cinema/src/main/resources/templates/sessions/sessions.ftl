<#import "../layout.ftl" as layout>

<@layout.mainLayout title="Search Sessions">

    <h1>Find a Session</h1>

    <div class="search-wrapper">
        <input type="text" id="searchInput" placeholder="Search by film name..." autocomplete="off"/>
    </div>

    <div id="resultsContainer">
        <p id="message" style="color:var(--text-muted);margin-top:1rem;">Start typing to search...</p>
    </div>

    <script>
    $(function() {

        $.ajax({
                url: '/cinema/sessions/all',
                method: 'GET',
                dataType: 'json',
                success: function(response) {
                    var sessions = response.sessions;
                    var html = '';

                    if (sessions.length === 0) {
                        html = '<p style="color:var(--text-muted);margin-top:1rem;">No sessions found</p>';
                    } else {
                        html = '<div class="cards">';
                        sessions.forEach(function(session) {
                            var poster = session.film?.posterUrl
                                ? '<img src="' + session.film?.posterUrl + '"/>'
                                : '<div class="no-poster">No Poster</div>';

                            html +=
                                '<a href="/cinema/sessions/' + session.id + '" class="card">' +
                                    '<div class="card-poster">' + poster + '</div>' +
                                    '<div class="card-body">' +
                                        '<h3>' + session.film?.name + '</h3>' +
                                        '<p>' + session.dateTime + '</p>' +
                                        '<span class="price">$' + session.ticketPrice + '</span>' +
                                    '</div>' +
                                '</a>';
                        });
                        html += '</div>';
                    }

                    $('#resultsContainer').html(html);
                },
                error: function() {
                    $('#resultsContainer').html('<p style="color:var(--danger);margin-top:1rem;">Error loading results. Please try again.</p>');
                }
            });

        $('#searchInput').on('input', function() {
            var filmName = $(this).val();

            if (filmName.length < 1) {
                $('#resultsContainer').html('<p id="message" style="color:var(--text-muted);margin-top:1rem;">Start typing to search...</p>');
                return;
            }

            $('#resultsContainer').html('<p style="color:var(--text-muted);margin-top:1rem;">Searching...</p>');

            $.ajax({
                url: '/cinema/sessions/search',
                method: 'GET',
                data: { filmName: filmName },
                dataType: 'json',
                success: function(response) {
                    var sessions = response.sessions;
                    var html = '';

                    if (sessions.length === 0) {
                        html = '<p style="color:var(--text-muted);margin-top:1rem;">No sessions found for "' + filmName + '"</p>';
                    } else {
                        html = '<div class="cards">';
                        sessions.forEach(function(session) {
                            var poster = session.film.posterUrl
                                ? '<img src="' + session.film.posterUrl + '"/>'
                                : '<div class="no-poster">No Poster</div>';

                            html +=
                                '<a href="/cinema/sessions/' + session.id + '" class="card">' +
                                    '<div class="card-poster">' + poster + '</div>' +
                                    '<div class="card-body">' +
                                        '<h3>' + session.film.name + '</h3>' +
                                        '<p>' + session.dateTime + '</p>' +
                                        '<span class="price">$' + session.ticketPrice + '</span>' +
                                    '</div>' +
                                '</a>';
                        });
                        html += '</div>';
                    }

                    $('#resultsContainer').html(html);
                },
                error: function() {
                    $('#resultsContainer').html('<p style="color:var(--danger);margin-top:1rem;">Error loading results. Please try again.</p>');
                }
            });
        });

    });
    </script>

</@layout.mainLayout>