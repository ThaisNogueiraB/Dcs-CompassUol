# API ServeRest - Testes Automatizados

Este projeto contem suites de testes automatizados para a API [ServeRest](https://compassuol.serverest.dev/) utilizando o **Robot Framework**. Os casos de teste exercitam os principais endpoints da aplicacao, verificando funcionalidades de usuarios, login, produtos e carrinho.

# Estrutura de Pastas - Projeto API ServeRest (Robot Framework)

```plaintext
api_serverest_teste_automatizado/
├── keywords/                     
│   ├── carrinho_keywords.robot
│   ├── login_keywords.robot
│   ├── produtos_keywords.robot
│   └── usuarios_keywords.robot
│
├── reports/                      
│   ├── reports_carrinho/
│   ├── reports_completo/
│   ├── reports_login/
│   ├── reports_produtos/
│   └── reports_usuario/
│
├── support/                     
│
├── tests/                        
│   ├── carrinho_tests.robot
│   ├── login_tests.robot
│   ├── produtos_tests.robot
│   └── usuarios_tests.robot
│
└── README.md                    
```


## Estrutura do Projeto

- `tests/` - arquivos com os casos de teste.
- `keywords/` - keywords reutilizaveis com a logica das acoes.
- `support/` - bibliotecas de apoio e variaveis de configuracao.
- `reports/` - pasta onde sao gerados os relatorios de execucao.

## Pré-requisitos
- Python 3.x
- Robot Framework
- robotframework-requests

## Execução
1. Para executar todos os testes e gerar relatorios em `reports/`:
   ```bash
   robot -d reports tests/
   ```
2. Tambem e possivel executar somente casos marcados com uma tag, por exemplo `Postlogin`:
   ```bash
   robot -i Postlogin tests/
   ```
3. Ao final da execucao, abra o `report.html` ou `log.html` gerado dentro da pasta `reports/`  para visualizar os resultados.

4. Execute `robot tests/` para iniciar a bateria de testes.

Os relatórios foram criados na pasta `reports`.


# Manutenção
Projeto construído para rodar de forma modular e isolada. Uso da FakeLibrary para dados dinâmicos.
