*** Settings ***
Documentation    Cenarios de teste de remocao  de tarefas 
Resource    ../../resources/base.resource

Test Setup    Start Sesion
Test Teardown    Take Screenshot            

*** Test Cases ***

Deve poder apagar uma tarefa indesejada 
    
    ${data}    Get fixture    tasks    delete

    Reset user from database    ${data}[user]

    Create a new task from API    ${data}
    
    Do login    ${data}[user]
    
    Request removal    ${data}[tasks][name]

    Task shold not exist    ${data}[tasks][name]