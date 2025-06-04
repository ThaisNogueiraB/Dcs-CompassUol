*** Settings ***    
Documentation    Arquivo de testes para Endpoint/usuarios    

*** Test Cases ***
CT-001: Cadastro de usuário válido
    Criar Sessao 

    Montar payload JSON com os dados

    Enviar requisição POST para /usuarios

    Validar status code 201

    Validar presença de _id e mensagem de sucesso na resposta

CT-006:Alterar usuário válido

     Criar Sessao 

    Cadastrar um usuário previamente

    Enviar requisição PUT para /usuarios/{_id} com o ID do usuário
    
    Validar status code 200
    
    Verificar mensagem de sucesso na resposta

CT-010: Listagem de usuários válida

    Criar Sessao

    Cadastrar pelo menos um usuário previamente
    
    Enviar requisição GET para /usuarios
    
    Validar status code 200
    
    Verificar que a lista de usuários foi retornada com os dados esperados

CT-012:Exclusão de usuário válido

    Criar Sessao 

    Cadastrar um usuário previamente
    
    Enviar requisição DELETE para /usuarios/{_id} com o ID do usuário
    
    Validar status code 200

    Verificar mensagem de sucesso na resposta

CT-016:Expiração de token após 10 minutos

    Criar Sessao
    
    Realizar login e salvar o token gerado
        
    Tentar acessar um endpoint protegido com o token expirado    
    
    Validar status code 401
    
    Verificar mensagem de erro informando que o token expirou
    


