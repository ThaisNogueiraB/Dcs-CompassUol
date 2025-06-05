*** Settings ***
Documentation    Gerar dados do usuario
Library    FakerLibrary

*** Keywords ***    
Criar dados dinamicos para usuario 
    ${nome}=    FakerLibrary.Name
    ${email}=    FakerLibrary.Email
    ${senha}=    FakerLibrary.Passport Number
    Set Suite Variable    ${nome}
    Set Suite Variable    ${email}
    Set Suite Variable    ${senha}