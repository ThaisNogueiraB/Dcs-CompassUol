*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/carrinho da serverest
Resource    ../support/base.robot
Resource   ../support/fixture/dynamics.robot
Resource   ../support/variables/serverest_variables.robot


*** Variables ***

*** Keywords ***

Criar carrinho
    Criar dados dinamicos para produto
    ${produto}    Create Dictionary    idProduto=${idproduto}    quantidade=${quantidade_carrinho}
    ${lista}=      Create List    ${produto}
    ${payload}=    Create Dictionary    produtos=${lista}
    Set Suite Variable    ${payload}   
    
Enviar requisição POST para /carrinhos
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    POST On Session    serverest    /carrinhos   headers=${headers}    json=${payload}    expected_status=201  
    Set Suite Variable    ${response}

Extrair ID do carrinho
    [Arguments]    ${response}
    ${json}=     Set Variable  ${response.json()}
    Log          Retorno do produto:\n${json}
    Should Contain    ${json}    _id
    ${idcarrinho}=  Get From Dictionary  ${json}  _id
    Log          ID do produto: ${idcarrinho}
    Set Suite Variable    ${idcarrinho}
        
    
Verificar ID do carrinho na resposta
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Cadastro realizado com sucesso
    
    ${idcarrinho}=         Get From Dictionary    ${response.json()}    _id
    Should Not Be Empty    ${idcarrinho}
    Log    ID gerado: ${idcarrinho}