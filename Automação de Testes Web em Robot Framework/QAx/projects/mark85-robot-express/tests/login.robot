*** Settings ***
Documentation     Cenario de autenticaçao do usuario

Library    Collections
Resource    ../resources/base.resource

Test Setup    Start Sesion
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder logar com um usuario pre-cadastrado

    ${user}    Create Dictionary
    ...    name=Nometeste
    ...    email=teste@teste.com
    ...    password=teste123  
    
    remove user from database    ${user}[email]
    insert user from database    ${user}
    
    Submit login form    ${user}
    User Should be logged in    ${user}[name]    

Nao deve logar com senha invalida 
    ${user}    Create Dictionary
    ...    name=fulano teste
    ...    email=fulano@teste.com
    ...    password=fulano123


    remove user from database    ${user}[email]
    insert user from database    ${user}

    Set To Dictionary    ${user}    password=123456
    
    Submit login form    ${user}
    Notice shold be     Ocorreu um erro ao fazer login, verifique suas credenciais.
   