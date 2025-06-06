*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/carrinho da serverest
Resource    ../support/base.robot


*** Variables ***

*** Keywords ***

Criar carrinho
    Criar dados dinamicos para produto
    ${produto}    Create Dictionary    idProduto=${idproduto}    quantidade=${quantidade_carrinho}
    ${lista}=      Create List    ${produto}
    ${payload}=    Create Dictionary    produtos=${lista}
    Set Suite Variable    ${payload}   
    

Criar carrinho com id inexistente
    Criar dados dinamicos para produto
    ${produto}    Create Dictionary    idProduto=produtoInvalido    quantidade=${quantidade_carrinho}
    ${lista}=      Create List    ${produto}
    ${payload}=    Create Dictionary    produtos=${lista}
    Set Suite Variable    ${payload} 

Enviar requisição POST para /carrinhos
    [Arguments]    ${expected_status}=201
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    POST On Session    serverest    /carrinhos   headers=${headers}    json=${payload}    expected_status=${expected_status}     
    Set Suite Variable    ${response}


Enviar requisição GET para /carrinhos
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    GET On Session    serverest    /carrinhos   headers=${headers}    
    Set Suite Variable    ${response}  


Enviar requisição DELETE para /carrinhos/concluir-compra
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    DELETE On Session    serverest    /carrinhos/concluir-compra   headers=${headers}     expected_status=ANY   
    Set Suite Variable    ${response}


Enviar GET para /carrinhos/id
    [Arguments]    ${expected_status}=400
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    GET On Session    serverest    /carrinhos/${idcarrinho}   headers=${headers}    expected_status=ANY        
    Set Suite Variable    ${response}


Enviar requisição DELETE para /carrinhos/cancelar-compra
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}    DELETE On Session    serverest    /carrinhos/cancelar-compra  headers=${headers}        
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

Verificar mensagem de erro de Produto não encontrado
     ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Produto não encontrado

Verificar se produtos estão presentes na resposta
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}

Verificar mensagem de sucesso,registro excluido
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Registro excluído com sucesso

Validar que carrinho não existe mais
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json    
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Carrinho não encontrado

Verificar mensagem de cancelamento e estoque reabastecido
    ${json}=    Evaluate    json.dumps(${response.json()}, indent=2)    json    
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response.json()}    message
    Should Be Equal As Strings    ${message}    Registro excluído com sucesso. Estoque dos produtos reabastecido
