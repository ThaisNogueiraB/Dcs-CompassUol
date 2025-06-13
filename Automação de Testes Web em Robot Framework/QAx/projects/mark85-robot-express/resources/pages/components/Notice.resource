*** Settings ***
Documentation    Acoes e elementos do componente de notificaçoes 
Library    Browser

*** Keywords ***    
Notice shold be
    [Arguments]    ${expected_text}

    ${element}    Set Variable    css=.notice p 

    Wait For Elements State    ${element}    visible    5
    Get Text                   ${element}    equal      ${expected_text}