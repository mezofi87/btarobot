*** Settings ***
Resource          ../helper_keywords.robot

*** Keywords ***
Create An Account
    ${timestamp}    Generate Timestamp
    ${customer_email}    Set Variable    mezofi${timestamp}@btahomework.com
    UI Input Text    ${customer_email}    loc create email input
    UI Click    loc create account submit button

loc create account submit button
    ${loc}    Set Variable    //button[@id='SubmitCreate']
    [Return]    ${loc}

loc create email input
    ${loc}    Set Variable    //input[@id='email_create']
    [Return]    ${loc}

loc email input
    ${loc}    Set Variable    //input[@id='email']
    [Return]    ${loc}

loc password input
    ${loc}    Set Variable    //input[@id='passwd']
    [Return]    ${loc}

Log In
    [Arguments]    ${email}    ${password}
    ${customer_email}    Set Variable    ${email}
    UI Input Text    ${customer_email}    loc email input
    UI Input Text    ${password}    loc password input
    UI Click    loc sign in submit button

loc sign in submit button
    ${loc}    Set Variable    //button[@id='SubmitLogin']
    [Return]    ${loc}
