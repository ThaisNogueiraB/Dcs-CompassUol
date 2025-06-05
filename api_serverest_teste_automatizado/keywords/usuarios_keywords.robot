
*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/usuarios da serverest
Resource    ../support/base.robot
Resource   ../support/fixture/dynamics.robot
Resource   ../support/variables/serverest_variables.robot



*** Variables ***

*** Keywords ***
Criar dados validos
    Criar dados dinamicos para usuario
    ${payload}    Create Dictionary    nome=${nome}    email=${email}    password=${senha}    administrador=true
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Enviar requisição POST para /usuarios
    ${response}    POST On Session    serverest    /usuarios   json=${payload}
    Set Suite Variable    ${response}
    
    
Validar retorno
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}



Extrair ID do usuário criado
    ${id}=    Get From Dictionary    ${response.json()}    _id
    Log    id obtido: ${id}
    Set Global Variable    ${id} 
    RETURN    ${id}

Alterar nome valido
    Criar dados dinamicos para usuario 
    ${payload}    Create Dictionary    nome=${nome}    email=${payload['email']}    password=${payload['password']}    administrador=${payload['administrador']} 
    Set Suite Variable    ${payload}
    RETURN    ${payload}
    
Enviar requisição PUT para /usuarios com o ID do usuário
    [Arguments]    ${id}    ${payload}
    ${response}    PUT On Session    serverest    /usuarios/${id}  json=${payload}
    Set Suite Variable    ${response}
 
Enviar requisição GET para /usuarios
    ${response}    GET On Session    serverest    /usuarios  
    Set Suite Variable    ${response}
    
Enviar requisição DELETE para /usuarios com o ID do usuário
    [Arguments]    ${id}    ${payload}
    ${response}    DELETE On Session    serverest    /usuarios/${id}  json=${payload}
    Set Suite Variable    ${response}
    