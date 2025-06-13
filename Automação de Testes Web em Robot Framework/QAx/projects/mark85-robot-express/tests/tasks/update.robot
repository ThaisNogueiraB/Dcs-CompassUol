*** Settings ***
Documentation    Cenarios de teste de atualizaça de tarefas 
Resource    ../../resources/base.resource

Test Setup    Start Sesion
Test Teardown    Take Screenshot            

*** Test Cases ***

Deve poder marcar uma tarefa como concluida 
    
    ${data}    Get fixture    tasks    done

    Reset user from database    ${data}[user]

    Create a new task from API    ${data}
    
    Do login    ${data}[user]
    
    Mark task as completed    ${data}[tasks][name]
    Task shold be complete    ${data}[tasks][name]

    