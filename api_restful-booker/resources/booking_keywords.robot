*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
&{HEADERS}    Content-Type=application/json    Accept=application/json       


*** Keywords ***

POST- Criar nova reserva 
    ${payload}     Create Dictionary        
    ...    firstname=Jim
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=true  
    ...    bookingdates=${EMPTY}
    ...    additionalneeds=Breakfast

    &{bookingdates}    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${payload}    bookingdates=${bookingdates}  

    ${response}    POST On Session    alias=Restful-booker   url=/booking    json=${payload}
    
    Should Be True    ${response.status_code} == 200

    ${json}=    Set Variable    ${response.json()}    
    Set Suite Variable    ${booking_id}    ${json['bookingid']}

    Log    ${response.status_code}   
    Log    ${response.json()}
    Log    Booking ID armazenado: ${booking_id}
                 
GET- Obter reserva por ID
     ${response}    GET On Session    alias=Restful-booker   url=/booking/${booking_id}
     Should Be True    ${response.status_code} == 200
     Log   ${response.status_code}   
     Log    ${response.json()} 

GET- Obter todas as reservas
    ${response}    GET On Session    alias=Restful-booker   url=/booking
    Should Be True    ${response.status_code} == 200
     Log   ${response.status_code}   
     Log    ${response.json()}    

PUT- Atualizar uma reserva atual
    ${payload}    Create Dictionary    
    ...    firstname=James
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${EMPTY} 
    ...    additionalneeds=Breakfast 

    &{bookingdates}    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${payload}    bookingdates=${bookingdates}      

    &{auth_headers}    Create Dictionary    &{HEADERS}    Cookie=token=${auth_token}

    ${response}    PUT On Session    alias=Restful-booker    url=/booking/${booking_id}    headers=${auth_headers}    json=${payload}            
    
    Should Be True    ${response.status_code} == 200
    Log   ${response.status_code}   
    Log   ${response.json()}

PATCH- Atualizar uma reserva parcialmente 
    ${payload}    Create Dictionary    firstname=James    lastname=Brown

    &{auth_headers}    Create Dictionary    &{HEADERS}    Cookie=token=${auth_token}

    ${response}    PATCH On Session    alias=Restful-booker    url=/booking/${booking_id}    headers=${auth_headers}    json=${payload}

    Should Be True    ${response.status_code} == 200
    Log   ${response.status_code}   
    Log   ${response.json()}

DELETE- Excluir reserva existentes
    &{auth_headers}    Create Dictionary    &{HEADERS}    Cookie=token=${auth_token}

    ${response}    DELETE On Session    alias=Restful-booker    url=/booking/${booking_id}    headers=${auth_headers}
    
    Should Be True    ${response.status_code} == 201
    Log   ${response.status_code}      
