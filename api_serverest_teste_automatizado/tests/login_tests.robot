*** Settings ***    
Documentation    Arquivo de testes para Endpoint/login   

*** Test Cases ***
CT-013:Login com credenciais válidas

    Criar Sessao

    Enviar requisição POST para /login

    Validar status code 200

    Verificar presença do token JWT na resposta

CT-014:Login com e-mail não cadastrado

    Criar Sessao

    Enviar requisição POST para /login

    Validar status code 401

    Verificar mensagem de erro indicando credenciais inválidas

CT-015:Login com senha incorreta
    
    Criar Sessao
    
    Cadastrar usuário com senha válida
    
    Enviar requisição POST para /login
    
    Validar status code 401
    
    Verificar mensagem de erro indicando falha de autenticação


