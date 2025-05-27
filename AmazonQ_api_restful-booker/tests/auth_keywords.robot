*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://restful-booker.herokuapp.com
${USERNAME}         admin
${PASSWORD}         password123
&{HEADERS}         Content-Type=application/json    Accept=application/json

*** Keywords ***
Criar sessao Restful-booker
    Create Session    Restful-booker    url=${BASE_URL}    headers=${HEADERS}

POST- Criar token com sucesso
    ${payload}    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}    POST On Session    Restful-booker    /auth    json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${token}    Set Variable    ${response.json()}[token]
    Set Test Variable    ${TOKEN}    ${token}
    [Return]    ${TOKEN}