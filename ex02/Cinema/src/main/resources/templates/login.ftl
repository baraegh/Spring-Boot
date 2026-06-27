<!DOCTYPE html>
<html lang="${springMacroRequestContext.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${springMacroRequestContext.getMessage("login.title")}</title>
    <link rel="stylesheet" href="/cinema/css/style.css"/>
</head>
<body class="login-page">

    <div class="login-wrapper">
        
        <div class="login-header">
            <h1>${springMacroRequestContext.getMessage("login.heading")}</h1>
            <div class="language-switcher">
                <a href="?lang=en">🇺🇸 EN</a>
                <a href="?lang=fr">🇫🇷 FR</a>
                <a href="?lang=ar">🇲🇦 AR</a>
            </div>
        </div>

        <#if RequestParameters?? && RequestParameters['confirmed']??>
            <div class="alert-success">
                ${springMacroRequestContext.getMessage("login.success.confirmed")}
            </div>
        </#if>

        <#if RequestParameters?? && RequestParameters['disabled']??>
            <div class="alert-error">
                ${springMacroRequestContext.getMessage("login.error.disabled")}
            </div>
        <#elseif RequestParameters?? && RequestParameters['error']??>
            <div class="alert-error">
                ${springMacroRequestContext.getMessage("login.error.invalid")}
            </div>
        <#elseif RequestParameters?? && RequestParameters['invalid_token']??>
            <div class="alert-error">
                ${springMacroRequestContext.getMessage("verification.invalid")}
            </div>
        </#if>



        <form action="/cinema/login" method="POST" class="login-card-form">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">
            
            <div>
                <label for="username">${springMacroRequestContext.getMessage("login.username.label")}</label>
                <input 
                    type="text" 
                    id="username" 
                    name="username" 
                    placeholder="${springMacroRequestContext.getMessage("login.username.placeholder")}" 
                    required 
                    autocomplete="username"
                    autofocus>
            </div>

            <div>
                <label for="password">${springMacroRequestContext.getMessage("login.password.label")}</label>
                <input 
                    type="password" 
                    id="password" 
                    name="password" 
                    placeholder="••••••••" 
                    required
                    autocomplete="current-password">
            </div>

            <div class="remember-me-container">
                <input type="checkbox" id="rememberMe" name="remember-me">
                <label for="rememberMe">${springMacroRequestContext.getMessage("login.remember")}</label>
            </div>

            <button type="submit">${springMacroRequestContext.getMessage("login.submit")}</button>

            <div class="form-footer-links">
                <a href="/cinema/signUp">${springMacroRequestContext.getMessage("login.signup.link")}</a>
            </div>
        </form>
    </div>

</body>
</html>