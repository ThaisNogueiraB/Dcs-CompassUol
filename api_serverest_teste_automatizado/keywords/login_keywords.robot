*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/login da serverest
Resource    ../support/base.robot
Resource   ../support/fixture/dynamics.robot
Resource   ../support/variables/serverest_variables.robot

Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Gerar credenciais
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    email=${payload['email']}    password=${payload['password']}
    Set Suite Variable    ${payload}

Enviar requisição POST para /login

    [Arguments]    ${status_esperado}=200
    ${response}    POST On Session    serverest    /login   json=${payload}    expected_status=${status_esperado}
    Set Suite Variable    ${response}
    RETURN    ${response}

Verificar presença do token JWT na resposta
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Login realizado com sucesso

    ${token}=    Get From Dictionary    ${response.json()}    authorization
    Should Contain    ${token}    Bearer

Gerar credenciais invalidas
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    email=naoexiste@teste.com    password=${senha}
    Set Suite Variable    ${payload}

Verificar mensagem de erro indicando credenciais inválidas
     ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Email e/ou senha inválidos  
     