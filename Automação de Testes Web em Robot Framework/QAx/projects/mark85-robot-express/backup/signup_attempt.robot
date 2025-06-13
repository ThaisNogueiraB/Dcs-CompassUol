*** Settings ***
Documentation    Cenarios de tentativa de cadastro com senha muito curta 
Resource     ../resources/base.resource  
Test Template    Short password  
Test Setup       Start Sesion
Test Teardown    Take Screenshot     

*** Test Cases ***
Nao deve logar com senha de 1 digito     1
Nao deve logar com senha de 2 digito     12
Nao deve logar com senha de 3 digito     123
Nao deve logar com senha de 4 digito     1234
Nao deve logar com senha de 5 digito     12345


