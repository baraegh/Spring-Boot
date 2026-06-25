<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Clearances — Cinema</title>
    <link rel="stylesheet" href="/cinema/css/style.css"/>
</head>
<body class="login-page">

    <div class="login-wrapper">
        
        <div class="login-header">
            <h1>Cinema Registration</h1>
        </div>

        <#-- Dynamic System Error/Success Feedback Alerts -->
        <#if error?? || RequestParameters.error??>
            <div class="alert-error">
                Registration rejected. ${error}.
            </div>
        </#if>

        <form action="/cinema/signUp" method="POST" class="login-card-form">
            
            <#-- Security Token (CSRF) -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <#-- Full Name Field -->
            <div>
                <label for="firstName">First Name</label>
                <input 
                    type="text" 
                    id="firstName" 
                    name="firstName" 
                    placeholder="First Name" 
                    required 
                    autofocus
                >
            </div>

            <div>
                <label for="lastName">Last Name</label>
                <input 
                    type="text" 
                    id="lastName" 
                    name="lastName" 
                    placeholder="Last Name" 
                    required 
                    autofocus
                >
            </div>

            <#-- Username Field -->
            <div>
                <label for="username">Username</label>
                <input 
                    type="text" 
                    id="username" 
                    name="username" 
                    placeholder="Username" 
                    required 
                    autocomplete="username"
                >
            </div>

            <#-- Email Field -->
            <div>
                <label for="email">Email</label>
                <input 
                    type="email" 
                    id="email" 
                    name="email" 
                    placeholder="name@cinema.com" 
                    required 
                    autocomplete="email"
                >
            </div>

            <#-- Password Field -->
            <div>
                <label for="password">Password</label>
                <input 
                    type="password" 
                    id="password" 
                    name="password" 
                    placeholder="••••••••" 
                    required
                    autocomplete="new-password"
                >
            </div>

            <#-- Protocols Checkbox -->
            <div class="remember-me-container">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">I acknowledge on terms</label>
            </div>

            <#-- Submit Trigger Button -->
            <button type="submit">Sign up</button>

            <div class="form-footer-links">
                <a href="/cinema/login">Existing account? Sign in here.</a>
            </div>
        </form>
    </div>

</body>
</html>