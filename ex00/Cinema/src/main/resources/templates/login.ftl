<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Cinema</title>
    <link rel="stylesheet" href="/cinema/css/style.css"/>
</head>
<body class="login-page">

    <div class="login-wrapper">
        
        <div class="login-header">
            <h1>Cinema Login</h1>
        </div>

        <#-- Comprehensive query parameter check -->
        <#if RequestParameters?? && RequestParameters['error']??>
            <div class="alert-error">
                Invalid credentials.
            </div>
        </#if>

        <form action="/cinema/login" method="POST" class="login-card-form">
            <input type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}">
            
            <#-- email Field -->
            <div>
                <label for="username">username</label>
                <input 
                    type="text" 
                    id="username" 
                    name="username" 
                    placeholder="Username" 
                    required 
                    autocomplete="username"
                    autofocus
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
                    autocomplete="current-password"
                >
            </div>

            <div class="remember-me-container">
                <input type="checkbox" id="rememberMe" name="remember-me">
                <label for="rememberMe">Remember me</label>
            </div>

            <#-- Sign In Trigger Button -->
            <button type="submit">Sign in</button>

            <div class="form-footer-links">
                <a href="/cinema/signUp">Don't have an account? Sign up here.</a>
            </div>
        </form>
    </div>

</body>
</html>