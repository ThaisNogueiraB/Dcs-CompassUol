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

Criar dados dinamicos para produto 
    ${nomeproduto}=    FakerLibrary.Word
    ${preco}=    FakerLibrary.Random Int
    ${descricao}=    FakerLibrary.Sentence
    ${quantidade}=    FakerLibrary.Random Int
    Set Suite Variable    ${nomeproduto}
    Set Suite Variable    ${preco}
    Set Suite Variable    ${descricao}
    Set Suite Variable    ${quantidade}
