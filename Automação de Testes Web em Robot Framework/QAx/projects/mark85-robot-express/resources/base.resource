*** Settings ***
Library    libs/database.py
Library     Browser
Library    JSONLibrary

Resource     env.resource

Resource     pages/components/Header.resource
Resource     pages/components/Alert.resource
Resource     pages/components/Notice.resource

Resource     pages/SignupPage.resource
Resource     pages/LoginPage.resource
Resource     pages/TaskCreatePage.resource
Resource     pages/TaskPage.resource

Resource     services.resource


*** Keywords ***
Start Sesion
    New Browser    browser=chromium    headless=False
    New Page       ${BASE_URL}

#Helppers
Get fixture
    [Arguments]    ${file_name}    ${scenario}
    
    ${data}    Load Json From File       
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    [Return]    ${data}[${scenario}] 


Reset user from database 
    [Arguments]    ${user}

    clean user from database     ${user}[email]
    insert user from database    ${user}

Create a new task from API

    [Arguments]    ${data}

    POST user session    ${data}[user]
    POST a new task      ${data}[tasks]

Do login   

    [Arguments]    ${user}    

    Submit login form              ${user}
    User Should be logged in       ${user}[name] 