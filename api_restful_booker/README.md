
readme_content = """
# API Restful-Booker - Testes Automatizados

Este projeto contém a automação de testes para a API [Restful-Booker](https://restful-booker.herokuapp.com) utilizando **Robot Framework**.

## ✅ Estrutura dos Testes

- **auth_keywords.robot**  
  Responsável pelos testes de autenticação, geração de token e criação de sessão.

- **booking_keywords.robot**  
  Responsável pelos testes CRUD de reservas:  
  - Criar reserva  
  - Obter reserva  
  - Atualizar reserva (PUT e PATCH)  
  - Excluir reserva  

- **test_booking.robot**  
  Suite principal que executa os cenários completos de teste.

## ✅ Funcionalidades Testadas

- **Autenticação**: Geração e armazenamento do token.  
- **POST**: Criação de nova reserva.  
- **GET**: Consulta de reserva pelo ID.  
- **PUT**: Atualização total de uma reserva existente.  
- **PATCH**: Atualização parcial da reserva.  
- **DELETE**: Exclusão da reserva.

  