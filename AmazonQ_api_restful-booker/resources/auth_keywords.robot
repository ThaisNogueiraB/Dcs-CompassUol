*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${USERNAME}    admin
${PASSWORD}    password123
&{HEADERS}     Content-Type=application/json    Accept=application/json

*** Keywords ***
Criar sessao Restful-booker

    [Documentation]    Cria uma nova sessão HTTP para a API Restful-booker
    ...              Configura os headers padrão para todas as requisições

    Create Session    Restful-booker    url=${BASE_URL}    headers=${HEADERS}    verify=False

POST- Criar token com sucesso

    [Documentation]    Realiza a autenticação e obtém um token de acesso
    ...              Retorna o token para ser usado em outras requisições

    ${payload}    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}    POST On Session    Restful-booker    /auth    json=${payload}
    RETURN    ${response.json()}[token]