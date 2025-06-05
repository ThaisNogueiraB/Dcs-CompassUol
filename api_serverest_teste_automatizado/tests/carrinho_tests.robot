*** Settings ***    
Documentation    Arquivo de testes para Endpoint/carrinho 
Resource    ../keywords/carrinho_keywords.robot
Resource    ../keywords/login_keywords.robot
Resource    ../keywords/usuarios_keywords.robot
Resource    ../keywords/produtos_keywords.robot
Suite Setup     Criar Sessao  

*** Test Cases ***
CT-027:Criação de carrinho válido
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}

    
    Criar carrinho 

    Enviar requisição POST para /carrinhos    201

    Extrair ID do carrinho    ${response}
    
    Validar status code "201"
    
    Verificar ID do carrinho na resposta


CT-029: Criação de carrinho com id inexistente

    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}

    
    Criar carrinho com id inexistente
    
    Enviar requisição POST para /carrinhos    400
    
    Validar status code "400"
    
    Verificar mensagem de erro de Produto não encontrado

CT-031: Visualização de carrinho válido

    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado


    Criar carrinho 

    Enviar requisição POST para /carrinhos    201

    Extrair ID do carrinho    ${response}


    Enviar requisição GET para /carrinhos
    
    Validar status code "200"
    
    Verificar se produtos estão presentes na resposta

CT-032: Finalização de compra com carrinho válido
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}

    
    Criar carrinho 

    Enviar requisição POST para /carrinhos    201

    Extrair ID do carrinho    ${response}


    Enviar requisição DELETE para /carrinhos/concluir-compra
    
    Validar status code "200"
    
    Verificar mensagem de sucesso,registro excluido

CT-033: Finalização de compra e validação de esvaziamento
    
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}

    
    Criar carrinho 

    Enviar requisição POST para /carrinhos    201

    Extrair ID do carrinho    ${response}


    Enviar requisição DELETE para /carrinhos/concluir-compra

    
    Enviar GET para /carrinhos/id    400      

    Validar status code "400"
    
    Validar que carrinho não existe mais

CT-034: Cancelamento de compra com carrinho válido
    
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}

    
    Criar carrinho 

    Enviar requisição POST para /carrinhos    201

    Extrair ID do carrinho    ${response}

    
    Enviar requisição DELETE para /carrinhos/cancelar-compra   
    
    Validar status code "200"
    
    Verificar mensagem de cancelamento e estoque reabastecido