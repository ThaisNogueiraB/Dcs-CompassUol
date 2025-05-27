*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary

*** Keywords ***
POST- Criar reserva
    [Documentation]    Cria uma nova reserva no sistema
    ...              Gera dados aleatórios para a reserva usando FakerLibrary
    ...              Retorna o ID da reserva criada
    ${firstname}    First Name
    ${lastname}    Last Name
    ${bookingdates}    Create Dictionary    checkin=2024-01-01    checkout=2024-01-10
    ${payload}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Breakfast
    ${response}    POST On Session    Restful-booker    /booking    json=${payload}
    ${booking_id}=    Set Variable    ${response.json()['bookingid']}

    Should Be True    ${booking_id} > 0

    RETURN    ${response.json()}[bookingid]

GET- Obter reserva por ID
    [Documentation]    Obtém os detalhes de uma reserva específica pelo ID
    [Arguments]    ${booking_id}
    ${response}    GET On Session    Restful-booker    /booking/${booking_id}
    RETURN    ${response.json()}

GET- Obter todas as reservas
    [Documentation]    Lista todas as reservas existentes no sistema
    ${response}    GET On Session    Restful-booker    /booking
    RETURN    ${response.json()}

PUT- Atualizar reserva completa
    [Documentation]    Atualiza todos os dados de uma reserva existente
    [Arguments]    ${booking_id}    ${token}
    ${firstname}    First Name
    ${lastname}    Last Name
    ${bookingdates}    Create Dictionary    checkin=2024-02-01    checkout=2024-02-10
    ${payload}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=200
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Café da manhã e jantar
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    PUT On Session    Restful-booker    /booking/${booking_id}    json=${payload}    headers=${headers}
    RETURN    ${response.json()}

PATCH- Atualizar reserva parcial
    [Documentation]    Atualiza parcialmente os dados de uma reserva
    [Arguments]    ${booking_id}    ${token}    &{updates}
    ${payload}    Create Dictionary    totalprice=250    additionalneeds=Café da manhã, almoço e jantar
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    PATCH On Session    Restful-booker    /booking/${booking_id}    json=${payload}    headers=${headers}
    RETURN    ${response.json()}

DELETE- Excluir reserva
    [Documentation]    Remove uma reserva do sistema
    [Arguments]    ${booking_id}    ${token}
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    DELETE On Session    Restful-booker    /booking/${booking_id}    headers=${headers}
    RETURN    ${response.status_code}