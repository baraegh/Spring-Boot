<!DOCTYPE html>
<html lang="${springMacroRequestContext.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${springMacroRequestContext.getMessage("signup.title")}</title>
    <link rel="stylesheet" href="/cinema/css/style.css"/>
</head>
<body class="login-page">

    <div class="login-wrapper">
        
        <div class="login-header">
            <h1>${springMacroRequestContext.getMessage("signup.heading")}</h1>

            <div class="language-switcher">
                <a href="?lang=en">🇺🇸 EN</a>
                <a href="?lang=fr">🇫🇷 FR</a>
                <a href="?lang=ar">🇲🇦 AR</a>
            </div>
        </div>

        <#if error?? || RequestParameters.error??>
            <div class="alert-error">
                ${springMacroRequestContext.getMessage("signup.error.rejected")} ${error!""}
            </div>
        </#if>

        <#if errors??>
            <div class="alert-error">
                <#list errors as err>
                    <p>${err.defaultMessage}</p>
                </#list>
            </div>
        </#if>

        <form action="/cinema/signUp" method="POST" class="login-card-form">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div>
                <label for="firstName">${springMacroRequestContext.getMessage("signup.firstname.label")}</label>
                <input type="text" id="firstName" name="firstName"
                       placeholder="${springMacroRequestContext.getMessage("signup.firstname.placeholder")}"
                       required autofocus>
            </div>

            <div>
                <label for="lastName">${springMacroRequestContext.getMessage("signup.lastname.label")}</label>
                <input type="text" id="lastName" name="lastName"
                       placeholder="${springMacroRequestContext.getMessage("signup.lastname.placeholder")}"
                       required>
            </div>

            <div>
                <label for="username">${springMacroRequestContext.getMessage("signup.username.label")}</label>
                <input type="text" id="username" name="username"
                       placeholder="${springMacroRequestContext.getMessage("signup.username.placeholder")}"
                       required autocomplete="username">
            </div>

            <div>
                <label for="email">${springMacroRequestContext.getMessage("signup.email.label")}</label>
                <input type="email" id="email" name="email"
                       placeholder="${springMacroRequestContext.getMessage("signup.email.placeholder")}"
                       required autocomplete="email">
            </div>

            <div>
                <label for="phoneNumber">${springMacroRequestContext.getMessage("signup.phone.label")}</label>
                <input type="text" id="phoneNumber" name="phoneNumber"
                       placeholder="${springMacroRequestContext.getMessage("signup.phone.placeholder")}"
                       required autocomplete="tel">
            </div>

            <div>
                <label for="password">${springMacroRequestContext.getMessage("signup.password.label")}</label>
                <input type="password" id="password" name="password"
                       placeholder="••••••••"
                       required autocomplete="new-password">
            </div>

            <div class="remember-me-container">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">${springMacroRequestContext.getMessage("signup.terms")}</label>
            </div>

            <button type="submit">${springMacroRequestContext.getMessage("signup.submit")}</button>

            <div class="form-footer-links">
                <a href="/cinema/login">${springMacroRequestContext.getMessage("signup.login.link")}</a>
            </div>
        </form>
    </div>

</body>
</html>