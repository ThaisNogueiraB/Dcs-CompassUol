*** Settings ***    
Documentation    Arquivo de testes para Endpoint/carrinho    

*** Test Cases ***
CT-027:Criação de carrinho válido

    Criar Sessao
    
    Cadastrar produto e obter ID
    
    Autenticar usuário
    
    Enviar requisição POST para /carrinhos
    
    Validar status code 201
    
    Verificar ID do carrinho na resposta


CT-029: Criação de carrinho com produto inexistente
    
    Criar Sessao
    
    Montar payload com ID de produto inexistente
    
    Enviar requisição POST para /carrinhos
    
    Validar status code 400
    
    Verificar mensagem de erro

CT-031: Visualização de carrinho válido

    Criar Sessao
    
    Criar carrinho e obter ID
    
    Autenticar usuário
    
    Enviar requisição GET para /carrinhos/{_id}
    
    Validar status code 200
    
    Verificar se produtos estão presentes na resposta

CT-032: Finalização de compra com carrinho válido

    Criar Sessao
    
    Criar carrinho com produtos válidos
    
    Autenticar usuário
    
    Enviar requisição DELETE para /carrinhos/concluir-compra
    
    Validar status code 200
    
    Verificar mensagem de sucesso

CT-033: Finalização de compra e validação de esvaziamento
    
    Criar Sessao
    
    Finalizar compra de carrinho existente
    
    Enviar GET para /carrinhos/concluir-compra
    
    Validar que carrinho não existe mais

CT-034: Cancelamento de compra com carrinho válido
    
    Criar Sessao
    
    Criar carrinho com produtos
    
    Autenticar usuário
    
    Enviar requisição DELETE para /carrinhos/cancelar-compra
    
    Validar status code 200
    
    Verificar mensagem de cancelamento e estoque reabastecido