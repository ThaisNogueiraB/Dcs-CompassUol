*** Settings ***
Resource    ../support/fixture/dynamics.robot
Documentation    Keywords e variaveis para  testes do endpoint/produtos da serverest
Resource    ../support/base.robot
Resource   ../support/fixture/dynamics.robot
Resource   ../support/variables/serverest_variables.robot


*** Variables ***

*** Keywords ***

Cadastrar produto    
    Criar dados dinamicos para produto
    ${payload}    Create Dictionary    nome=${nomeproduto}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}  
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Enviar requisição POST para /produtos com token
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    POST On Session    serverest    /produtos   headers=${headers}    json=${payload}    expected_status=201
    Set Suite Variable    ${response}


Alterar nome produto
    Criar dados dinamicos para produto 
    ${payload}    Create Dictionary    nome=${nome}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade} 
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Enviar requisição PUT para /produtos/id com token
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    PUT On Session    serverest    /produtos   headers=${headers}    json=${payload}    expected_status=201
    Set Suite Variable    ${response}    
        

Verificar mensagem de sucesso e presença do ID do produto
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Cadastro realizado com sucesso
    
    ${id}=         Get From Dictionary    ${response.json()}    _id
    Should Not Be Empty    ${id}
    Log    ID gerado: ${id}


Verificar mensagem de sucesso e alterações aplicadas
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Registro alterado com sucesso
    