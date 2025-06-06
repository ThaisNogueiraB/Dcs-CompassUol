*** Settings ***    
Documentation    Arquivo de testes para Endpoint/login 
Resource    ../keywords/login_keywords.robot
Resource    ../keywords/usuarios_keywords.robot
Suite Setup    Criar Sessao 


*** Test Cases ***
CT-013:Login com credenciais válidas

    [Tags]    Postlogin

    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login

    Validar status code "200"

    Verificar presença do token JWT na resposta

CT-014:Login com e-mail não cadastrado
    
    [Tags]    Postlogininvalido

    Gerar credenciais com email invalido

    Enviar requisição POST para /login    401

    Validar status code "401"

    Verificar mensagem de erro indicando credenciais inválidas

CT-015:Login com senha incorreta

    [Tags]    Postloginsenhainvalida
    
    Gerar credenciais com senha invalida
    
    Enviar requisição POST para /login    401
    
    Validar status code "401"
    
    Verificar mensagem de erro indicando credenciais inválidas

CT-016:Expiração de token após 10 minutos

    [Tags]    tokenexpirado
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login 
    
    Salvar token gerado
    
    Sleep    ${TOKEN_EXPIRY_WAIT}    #(simulando tempo real)
        
    Acessar um endpoint protegido com o token expirado      
    
    Validar status code "401"
    
    Validar mensagem de erro informando que o token expirou
