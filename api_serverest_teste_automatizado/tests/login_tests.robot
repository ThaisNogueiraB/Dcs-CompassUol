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

    Gerar credenciais invalidas

    Enviar requisição POST para /login    401

    Validar status code "401"

    Verificar mensagem de erro indicando credenciais inválidas

CT-015:Login com senha incorreta
    
    Cadastrar usuário com senha válida
    
    Enviar requisição POST para /login
    
    Validar status code "401"
    
    Verificar mensagem de erro indicando falha de autenticação

CT-016:Expiração de token após 10 minutos
    
    Realizar login e salvar o token gerado
        
    Tentar acessar um endpoint protegido com o token expirado    
    
    Validar status code "401"
    
    Validar retorno 
