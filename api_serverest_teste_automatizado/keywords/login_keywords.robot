*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/login da serverest
Resource    ../support/base.robot
Resource   ../support/fixture/dynamics.robot
Resource   ../support/variables/serverest_variables.robot


*** Variables ***

*** Keywords ***
Gerar credenciais
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    email=${payload['email']}    password=${payload['password']}
    Set Suite Variable    ${payload}


Gerar credenciais com email envalido
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    email=naoexiste@teste.com    password=${senha}
    Set Suite Variable    ${payload}

Gerar credenciais com senha invalidas
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    email=${email}  password=senhaincorreta
    Set Suite Variable    ${payload}

Enviar requisição POST para /login
    [Arguments]    ${status_esperado}=200
    ${response}    POST On Session    serverest    /login   json=${payload}    expected_status=${status_esperado}
    Set Suite Variable    ${response}
    RETURN    ${response}  

Acessar um endpoint protegido com o token expirado
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}=   POST On Session    serverest    /produtos    headers=${headers}    expected_status=401
    Set Suite Variable    ${response}   

Verificar presença do token JWT na resposta
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Login realizado com sucesso

    ${token}=    Get From Dictionary    ${response.json()}    authorization
    Should Contain    ${token}    Bearer

Verificar mensagem de erro indicando credenciais inválidas
     ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Email e/ou senha inválidos  

Validar mensagem de erro informando que o token expirou
     ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais