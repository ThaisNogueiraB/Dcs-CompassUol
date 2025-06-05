*** Settings ***
Documentation  arquivos base para requisiçoes 
Library     Collections
Library    RequestsLibrary
Library    OperatingSystem

Resource    ../support/commun/common.robot
Resource    ../support/fixture/dynamics.robot
Resource    ../support/variables/serverest_variables.robot


*** Keywords ***
Criar Sessao
    Create Session    serveRest    ${BASE_URL}

Validar status code "${statuscode}"
    ${statuscode}=    Convert To Integer    ${statuscode}
    Should Be Equal As Integers    ${response.status_code}    ${statuscode}
    Log    Status recebido: ${response.status_code}

Salvar token gerado
    ${token}=    Get From Dictionary    ${response.json()}    authorization
    Log    Token gerado: ${token}
    Set Suite Variable    ${token}
    RETURN    ${token}    