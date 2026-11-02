() =>
let
    url = "https://prod.api/api/v1/auth/login",
    authKey = "{""email"": ""<EMAIL>"", ""password"": ""<PASSWORD>""}",
    headers = [#"Content-Type" = "application/json"],
    webContent = 
        Web.Contents(
            url, 
            [Headers = headers,
            Content = Text.ToBinary(authKey)]
        ),
    getJSON = Json.Document(webContent),
    getApiToken = getJSON[token]
in
    getApiToken