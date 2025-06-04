*** Settings ***    
Documentation    Arquivo de testes para Endpoint/produtos    

*** Test Cases ***
CT-017:Cadastro de produto válido

    Criar Sessao

    Autenticar usuário e obter token JWT
    
    Enviar requisição POST para /produtos com token no header
    
    Validar status code 201
    
    Verificar mensagem de sucesso e presença do ID do produto

CT-021 - - Atualização de produto válido

    Criar Sessao
    
    Cadastrar um produto previamente

    Enviar requisição PUT para /produtos/{_id} com token JWT
    
    Validar status code 200
    
    Verificar mensagem de sucesso e alterações aplicadas

CT-023 - - Listagem de produtos válida

    Criar Sessao
    
    Autenticar usuário e obter token JWT
    
    Enviar requisição GET para /produtos com token JWT
    
    Validar status code 200
    
    Verificar que a lista contém produtos válidos

CT-025 - - Exclusão de produto válido

    Criar Sessao
    
    Cadastrar produto sem vínculo com carrinho
    
    Enviar requisição DELETE para /produtos/{_id} com autenticação
    
    Validar status code 200
    
    Verificar mensagem de sucesso

CT-026 - - Exclusão de produto vinculado a carrinho

    Criar Sessao
    
    Criar carrinho com um produto
    
    Tentar excluir esse produto com DELETE /produtos/{_id}
    
    Validar status code 400
    
    Verificar mensagem indicando vínculo com carrinho

