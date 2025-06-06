*** Settings ***
documentation   Keywords e variaveis para uso geral 
Library    OperatingSystem

*** Keywords ***
Validar status code "${statuscode}"
    ${statuscode}=    Convert To Integer    ${statuscode}
    Should Be Equal As Integers    ${response.status_code}    ${statuscode}
    Log    Status recebido: ${response.status_code}

Salvar token gerado
    ${token}=    Get From Dictionary    ${response.json()}    authorization
    Log    Token gerado: ${token}
    Set Suite Variable    ${token}
    RETURN    ${token} 

