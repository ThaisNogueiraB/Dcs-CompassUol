*** Settings ***
Library    RequestsLibrary
Resource    ../resources/auth_keywords.robot

*** Test Cases ***
Cenario 01- Criar um novo token com sucesso 200  
    [Tags]    POSTTOKEN
        Criar sessao Restful
        POST- Criar token com sucesso

    