*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
&{BOOKING_DATA}    firstname=John
...                lastname=Doe
...                totalprice=100
...                depositpaid=true
...                additionalneeds=Breakfast
&{BOOKING_DATES}    checkin=2024-01-01    checkout=2024-01-10

*** Keywords ***
POST- Criar reserva
    ${dates}    Create Dictionary    &{BOOKING_DATES}
    ${payload}    Create Dictionary    &{BOOKING_DATA}    bookingdates=${dates}
    ${response}    POST On Session    Restful-booker    /booking    json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${booking_id}    Set Variable    ${response.json()}[bookingid]
    Set Test Variable    ${BOOKING_ID}    ${booking_id}
    [Return]    ${BOOKING_ID}

    Log    ${response.status_code}   
    Log    ${response.json()}
   

GET- Obter reserva por ID
    [Arguments]    ${booking_id}
    ${response}    GET On Session    Restful-booker    /booking/${booking_id}
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}
    Log    ${response.status_code}   
    

GET- Obter todas as reservas
    ${response}    GET On Session    Restful-booker    /booking
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}
    Log   ${response.status_code}   

PUT- Atualizar reserva
    [Arguments]    ${booking_id}    ${token}
    ${dates}    Create Dictionary    &{BOOKING_DATES}
    ${payload}    Create Dictionary    &{BOOKING_DATA}    bookingdates=${dates}
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    PUT On Session    Restful-booker    /booking/${booking_id}    json=${payload}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}
    Log   ${response.status_code} 

PATCH- Atualizar reserva parcial
    [Arguments]    ${booking_id}    ${token}    &{updates}
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    PATCH On Session    Restful-booker    /booking/${booking_id}    json=${updates}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}
    Log   ${response.status_code}

DELETE- Excluir reserva
    [Arguments]    ${booking_id}    ${token}
    &{headers}    Create Dictionary    Cookie=token=${token}
    ${response}    DELETE On Session    Restful-booker    /booking/${booking_id}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    Log   ${response.status_code}  