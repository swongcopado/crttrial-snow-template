*** Settings ***
Library                   QNow
Library                   RequestsLibrary
Library                   Collections
Library                   String


*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                chrome
${username}               admin                             # given as example here. Give this, password & login_url in CRT variables section
${login_url}              https://${devinstanceid}.service-now.com  # given as example here. Give this, username & password in CRT variables section


*** Keywords ***
Setup Browser
    Open Browser        about:blank             ${BROWSER}


End suite
    Close All Browsers


Login
    [Documentation]     Login to ServiceNow instance
    TypeText            User name               ${username}
    TypeSecret          Password                ${password}
    ClickText           Log in
    VerifyText          User menu               # verify that user menu / avatar appears


Home
    GoTo                ${login_url}
    ${is_hibernating}=    IsText    is hibernating
    Run Keyword If        ${is_hibernating}    Wake Instance
    ${not_logged_in}=   IsText                  Log in
    Run Keyword If      ${not_logged_in}        Login


# REST API example
Delete Incident
    [Documentation]     Adds user to ServiceNow via REST API
    [Arguments]         ${inc_id}
    ${auth}=            Create List             ${username}             ${password}
    ${headers}=         Create Dictionary       Content-Type=application/json   Accept=application/json
    ${data}=            Create Dictionary       sysparm_query=number=${inc_id}   sysparm_limit=1

    ${session}=         Create Session          incidents               ${login_url}/api        auth=${auth}
    ${resp}=            Get On Session          incidents               /now/table/incident     ${data}         headers=${headers}

    ${object}=          Evaluate                json.loads("""${resp.content}""", strict=False)
    ${short_desc}=      Get From Dictionary     ${object["result"][0]}  short_description
    ${sys_id}=          Get From Dictionary     ${object["result"][0]}  sys_id
    Log                 Removing incident "${short_desc}"
    ${resp}=            Delete On Session       incidents               /now/table/incident/${sys_id}

Wake Instance
    [Documentation]    Checks if the instance is Hibernating and wake it up if it is.
    ClickText         Sign in    
    ClickText         Agree and Proceed  
    ClickText         Close
    Login To ServiceNow
    FOR               ${i}      IN RANGE    10
        ${waking_up}=           isText      Waking up instance
        IF            ${waking_up}
            Sleep     10s 
        ELSE
            BREAK
        END    
    END
    ClickText         Start Building

Login To ServiceNow
    [Documentation]    Log in to ServiceNow
    SetConfig    ShadowDOM    true
    ClickText    Sign In
    TypeText     Email        ${snowuser}
    ClickText    Next
    TypeText     Password     ${snowpassword}
    ClickText    Sign In