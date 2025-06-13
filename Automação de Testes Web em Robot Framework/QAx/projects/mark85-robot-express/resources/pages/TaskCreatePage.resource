*** Settings ***
Documentation    Acoes e elementos da pagina de cadastro de tarefa
Library    Browser

*** Keywords ***

Submit task form
    [Arguments]    ${task}

    Fill Text    css=input[placeholder$=tarefa]    ${task}[name]

    ${tags_element}    Set Variable    css=input[name=tags]    
    
    FOR    ${tag}    IN    @{task}[tags]
        Fill Text     ${tags_element}    ${tag}
        Sleep    1
        Press Keys    ${tags_element}     Enter
    END
    
    Click    css=button >> text=Cadastrar

   