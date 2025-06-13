*** Settings ***
Documentation   Cenarios de cadastro de tarefas

Resource    ../../resources/base.resource

Test Setup    Start Sesion
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa 

    ${data}    Get fixture    tasks   create

    Reset user from database    ${data}[user]

    Do login    ${data}[user] 

    Go to task form
    Submit task form    ${data}[tasks]  
    Task shold be registered    ${data}[tasks][name]  

Nao deve cadastrar tarefa com nome duplicado 

    [Tags]    tarefaduplicada

    ${data}    Get fixture    tasks   duplicate 

    #Dado que eu tenho um novo usuario
    Reset user from database    ${data}[user]

    #E que esse usuario ja cadastrou uma tarefa
    Create a new task from API    ${data}

    #E que estou logado na aplicaçao web
    Do login    ${data}[user]
    
    #Quando tento cadastrar essa tarefa que ja foi cadastrada 
    Go to task form
    Submit task form    ${data}[tasks]

    #Entao devo ver uma notificaçao de duplicidade 
    Notice shold be    Oops! Tarefa duplicada.   

Nao deve cadastrar uma nova tarefa quando atinge o limite de tags 

    [Tags]    limitedetag    

      ${data}    Get fixture    tasks   tags_limit 

    #Dado que eu tenho um novo usuario
    Reset user from database    ${data}[user]

    #E que estou logado na aplicaçao web
    Do login    ${data}[user] 
    
    #Quando tento cadastrar essa tarefa que ja foi cadastrada 
    Go to task form
    Submit task form    ${data}[tasks]

    #Entao devo ver uma notificaçao de duplicidade 
    Notice shold be    Oops! Limite de tags atingido.  

     
    