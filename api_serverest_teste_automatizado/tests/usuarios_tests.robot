*** Settings ***    
Documentation    Arquivo de testes para Endpoint/usuarios    
Resource    ../keywords/usuarios_keywords.robot
Suite Setup     Criar Sessao   

*** Test Cases ***
CT-001: Cadastro de usuário válido

    [Tags]    Postusuario

    Criar dados validos

    Enviar requisição POST para /usuarios

    Extrair ID do usuário criado

    Validar status code "201"

    Validar retorno 


CT-006:Alterar usuário válido

    [Tags]    Putusuario

    Alterar nome valido

    Enviar requisição PUT para /usuarios com o ID do usuário    ${id}    ${payload}
    
    Validar status code "200"
    
    Validar retorno 

CT-010: Listagem de usuários válida

    [Tags]    Getusuario

    Criar dados validos

    Enviar requisição POST para /usuarios

    
    Enviar requisição GET para /usuarios
    
    Validar status code "200"
    
    Validar retorno 

CT-012:Exclusão de usuário válido 

    [Tags]    Deleteusuario

    Criar dados validos

    Enviar requisição POST para /usuarios

    
    Enviar requisição DELETE para /usuarios com o ID do usuário    ${id}    ${payload}
    
    Validar status code "200"

    Validar retorno 


    


