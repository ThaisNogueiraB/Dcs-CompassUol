*** Settings ***
Documentation  arquivos base para requisiçoes 
Library     Collections
Library    RequestsLibrary
Library    OperatingSystem

Resource    ../support/common/common.robot
Resource    ../support/fixture/dynamics.robot
Resource    ../support/variables/serverest_variables.robot


*** Keywords ***
Criar Sessao
    Create Session    serveRest    ${BASE_URL}
   