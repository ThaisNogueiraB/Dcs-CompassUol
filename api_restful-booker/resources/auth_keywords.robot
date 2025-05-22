
*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
&{HEADERS}    Content-Type=application/json
${USERNAME}    admin
${PASSWORD}    password123


*** Keywords ***
Criar sessao Restful
    Create Session    alias=Restful    url=${BASE_URL}    headers=${HEADERS}

POST- Criar token com sucesso
    ${payload}     Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}    POST On Session    alias=Restful   url=/auth    json=${payload}
    Should Be True    ${response.status_code} == 200
    ${json}=    Set Variable    ${response.json()}    json
    Set Suite Variable    ${auth_token}    ${json[0]['token']}
    Log    ${response.json()}

