*** Settings ***
Documentation    Keywords e variaveis para  testes do endpoint/produtos da serverest
Resource    ../support/base.robot



*** Variables ***

*** Keywords ***

Cadastrar produto    
    Criar dados dinamicos para produto
    ${payload}    Create Dictionary    nome=${nomeproduto}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}  
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Enviar requisição POST para /produtos com token
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response_produto}    POST On Session    serverest    /produtos   headers=${headers}    json=${payload}    expected_status=201  
    Set Suite Variable    ${response_produto}


Alterar nome produto
    Criar dados dinamicos para produto 
    ${payload}    Create Dictionary    nome=${nome}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade} 
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Extrair ID do produto
    [Arguments]    ${response}
    ${json}=     Set Variable  ${response_produto.json()}
    Log          Retorno do produto:\n${json}
    Should Contain    ${json}    _id
    ${idproduto}=  Get From Dictionary  ${json}  _id
    Log          ID do produto: ${idproduto}
    Set Suite Variable    ${idproduto}    

Enviar requisição PUT para /produtos/id com token
    [Arguments]  ${idproduto} 
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response_produto}    PUT On Session    serverest    /produtos/${idproduto}   headers=${headers}    json=${payload}    
    Set Suite Variable    ${response_produto}   


Enviar requisição GET para /produtos com token 
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response_produto}    GET On Session    serverest    /produtos   headers=${headers}    
    Set Suite Variable    ${response_produto} 

Enviar requisição DELETE para /produtos/id com token
    [Arguments]  ${idproduto} 
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response_produto}    DELETE On Session    serverest    /produtos/${idproduto}   headers=${headers}     expected_status=ANY   
    Set Suite Variable    ${response_produto} 


Validar status code 201
    Should Be Equal As Integers    ${response_produto.status_code}    201
    Log    Status recebido: ${response_produto.status_code}
Validar status code 200
    Should Be Equal As Integers    ${response_produto.status_code}    200
    Log    Status recebido: ${response_produto.status_code}

Validar status code 400
    Should Be Equal As Integers    ${response_produto.status_code}    400
    Log    Status recebido: ${response_produto.status_code}



Verificar mensagem de sucesso e presença do ID do produto
    ${json}=    Evaluate    json.dumps(${response_produto.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response_produto.json()}    message
    Should Be Equal As Strings    ${message}    Cadastro realizado com sucesso
    
    ${idproduto}=         Get From Dictionary    ${response_produto.json()}    _id
    Should Not Be Empty    ${idproduto}
    Log    ID gerado: ${idproduto}


Verificar mensagem de sucesso e alterações aplicadas
    ${json}=    Evaluate    json.dumps(${response_produto.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response_produto.json()}    message
    Should Be Equal As Strings    ${message}    Registro alterado com sucesso

Verificar que a lista contém produtos válidos
    ${json}=    Evaluate    json.dumps(${response_produto.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}    

Verificar mensagem de sucesso, e exclusao de produto 
    ${json}=    Evaluate    json.dumps(${response_produto.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response_produto.json()}    message
    Should Be Equal As Strings    ${message}    Registro excluído com sucesso  

Verificar mensagem indicando vínculo com carrinho
     ${json}=    Evaluate    json.dumps(${response_produto.json()}, indent=2)    json
    Log    JSON da resposta:\n${json}
    
    ${message}=    Get From Dictionary    ${response_produto.json()}    message
    Should Be Equal As Strings    ${message}    Não é permitido excluir produto que faz parte de carrinho
    