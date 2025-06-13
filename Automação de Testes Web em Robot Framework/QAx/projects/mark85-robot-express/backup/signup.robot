*** Settings ***
Documentation    Cenarios de testes de cadastro de usuarios 
Resource    ../resources/base.resource


Test Setup       Start Sesion
Test Teardown    Take Screenshot

Library    FakerLibrary

*** Test Cases ***
Deve poder cadastrar um novo usuario

    [Tags]    Cadastrosucesso

   ${user}        Create Dictionary
   ...    name=Nometeste
   ...    email=teste@teste.com
   ...    password=senha123


    Remove user from database    ${user}[email]
    
    Go to signup page
    
    Submit signup form    ${user}

    Notice shold be    Boas vindas ao Mark85, o seu gerenciador de tarefas.


Nao deve permitir o cadastro com email duplicado

    [Tags]  Cadastroduplicado 


    ${user}        Create Dictionary
   ...    name=fulanoteste
   ...    email=fulano@teste.com
   ...    password=senha123  

    remove user from database    ${user}[email]
    insert user from database    ${user}

    Go to signup page
    
    Submit signup form    ${user}

    Notice shold be    Oops! Já existe uma conta com o e-mail informado. 

Campos Obrigatorios

    [Tags]    camposobrigatorios    

    ${user}    Create Dictionary  
    ...        name=${EMPTY}    
    ...        email=${EMPTY}     
    ...        password=${EMPTY}   

    Go to signup page

    Submit signup form    ${user}

    Alert should be    Informe seu nome completo    
    Alert should be    Informe seu e-email    
    Alert should be    Informe uma senha com pelo menos 6 digitos    
  

Nao deve cadastrar com email incorreto

    [Tags]    emailinvalido    

    ${user}    Create Dictionary  
    ...        name=nometeste    
    ...        email=teste.com.br    
    ...        password=teste123
    
    Go to signup page

    Submit signup form    ${user}

    Alert should be    Digite um e-mail válido

Nao deve cadastrar com senha muito curta

    [Tags]    senhacurta    

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}

        ${user}    Create Dictionary  
        ...        name=nometeste    
        ...        email=teste@teste.com     
        ...        password=${password} 

        Go to signup page

        Submit signup form    ${user}

        Alert should be    Informe uma senha com pelo menos 6 digitos   
    END


Nao deve cadastrar com senha de 1 digito 

    [Tags]    senhacurta  
    [Template]
    Short password    1
Nao deve cadastrar com senha de 2 digito 

    [Tags]    senhacurta  
    [Template]
    Short password    12
    
Nao deve cadastrar com senha de 3 digito 

    [Tags]    senhacurta  

    [Template]
    Short password    123

Nao deve cadastrar com senha de 4 digito 

    [Tags]    senhacurta  
    [Template]
    Short password    1234

Nao deve cadastrar com senha de 5 digito 

    [Tags]    senhacurta  
    [Template]
    Short password    12345  

#tamplate
Short password

    [Arguments]    ${short_pass}

    ${user}    Create Dictionary  
    ...        name=nometeste    
    ...        email=teste@teste.com     
    ...        password=${short_pass} 

    Go to signup page

    Submit signup form    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos    


