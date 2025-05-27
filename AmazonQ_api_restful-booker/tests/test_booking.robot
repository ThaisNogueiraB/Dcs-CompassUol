*** Settings ***
Resource    ../resources/auth_keywords.robot
Resource    ../resources/booking_keywords.robot
Test Setup    Criar sessao Restful-booker

*** Test Cases ***
Cenario 01- Criar um novo token com sucesso 200
    [Tags]    POSTTOKEN
    ${token}    POST- Criar token com sucesso

Cenario 02- Criar reserva com sucesso 200
    [Tags]    CRIARRESERVA
    ${token}    POST- Criar token com sucesso
    ${booking_id}    POST- Criar reserva

Cenario 03- Obter uma reserva com sucesso 200
    [Tags]    OBTERRESERVA
    ${token}    POST- Criar token com sucesso
    ${booking_id}    POST- Criar reserva
    ${booking}    GET- Obter reserva por ID    ${booking_id}

Cenario 04- Obter id de todas as reservas com sucesso 200
    [Tags]    OBTERIDRESERVA
    ${bookings}    GET- Obter todas as reservas

Cenario 05- Atualizar reserva com sucesso 200
    [Tags]    ATUALIZARESERVATOTAL
    ${token}    POST- Criar token com sucesso
    ${booking_id}    POST- Criar reserva
    ${updated_booking}    PUT- Atualizar reserva completa   ${booking_id}    ${token}

Cenario 06- Atualizar reserva parcial com sucesso 200
    [Tags]    ATUALIZARESERVAPARCIAL
    ${token}    POST- Criar token com sucesso
    ${booking_id}    POST- Criar reserva
    &{updates}    Create Dictionary    firstname=Jane    lastname=Smith
    ${updated_booking}    PATCH- Atualizar reserva parcial    ${booking_id}    ${token}    &{updates}

Cenario 07- Excluir reserva com sucesso 201
    [Tags]    EXCLUIRRESERVA
    ${token}    POST- Criar token com sucesso
    ${booking_id}    POST- Criar reserva
    DELETE- Excluir reserva    ${booking_id}    ${token}