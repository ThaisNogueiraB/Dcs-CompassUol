*** Settings ***
Library    RequestsLibrary
Resource    ../resources/auth_keywords.robot
Resource    ../resources/booking_keywords.robot

*** Test Cases ***

Cenario 01- Criar um novo token com sucesso 200  
    [Tags]    POSTTOKEN
    Criar sessao Restful-booker
    POST- Criar token com sucesso

Cenario 02- Criar reserva com sucesso 200 
    [Tags]    POST
    Criar sessao Restful-booker
    POST- Criar nova reserva 

Cenario 03- Obter uma reserva com sucesso 200
    [Tags]   GET
    Criar sessao Restful-booker
    GET- Obter reserva por ID

Cenario 04- Obter id de todas as reservas com sucesso 200
    [Tags]    GET
    Criar sessao Restful-booker
    GET- Obter todas as reservas 

Cenario 05- Atualizar reserva com sucesso 200
    [Tags]    PUT
    Criar sessao Restful-booker
    PUT- Atualizar uma reserva atual

Cenario 06- Atualizar reserva parcial com sucesso 200
    [Tags]    PATCH
    Criar sessao Restful-booker
    PATCH- Atualizar uma reserva parcialmente 
Cenario 07- Excluir reserva com sucesso 201
    [Tags]    DELETE
    Criar sessao Restful-booker
    DELETE- Excluir reserva existentes
