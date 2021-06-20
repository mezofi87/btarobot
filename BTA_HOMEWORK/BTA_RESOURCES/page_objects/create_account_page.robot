*** Settings ***
Resource          ../helper_keywords.robot

*** Keywords ***
loc customer firstname input
    ${loc}    Set Variable    //input[@id='customer_firstname']
    [Return]    ${loc}

loc customer lastname input
    ${loc}    Set Variable    //input[@id='customer_lastname']
    [Return]    ${loc}

loc customer email input
    ${loc}    Set Variable    //input[@id='email']
    [Return]    ${loc}

loc customer password input
    ${loc}    Set Variable    //input[@id='passwd']
    [Return]    ${loc}

loc birth days select
    ${loc}    Set Variable    //select[@id='days']
    [Return]    ${loc}

loc birth months select
    ${loc}    Set Variable    //select[@id='months']
    [Return]    ${loc}

loc newsletter checkbox
    ${loc}    Set Variable    //input[@id='newsletter']
    [Return]    ${loc}

loc special offer checkbox
    ${loc}    Set Variable    //input[@id='optin']
    [Return]    ${loc}

loc address firstname input
    ${loc}    Set Variable    //input[@id='firstname']
    [Return]    ${loc}

loc address lastname input
    ${loc}    Set Variable    //input[@id='lastname']
    [Return]    ${loc}

loc address company input
    ${loc}    Set Variable    //input[@id='company']
    [Return]    ${loc}

loc address input
    ${loc}    Set Variable    //input[@id='address1']
    [Return]    ${loc}

loc address city input
    ${loc}    Set Variable    //input[@id='city']
    [Return]    ${loc}

loc address state select
    ${loc}    Set Variable    //select[@id='id_state']
    [Return]    ${loc}

loc address postcode input
    ${loc}    Set Variable    //input[@id='postcode']
    [Return]    ${loc}

loc address country select
    ${loc}    Set Variable    //select[@id='id_country']
    [Return]    ${loc}

loc address home phone input
    ${loc}    Set Variable    //input[@id='phone']
    [Return]    ${loc}

loc address mobile phone input
    ${loc}    Set Variable    //input[@id='phone_mobile']
    [Return]    ${loc}

loc address alias input
    ${loc}    Set Variable    //input[@id='alias']
    [Return]    ${loc}

loc register submit button
    ${loc}    Set Variable    //button[@id='submitAccount']
    [Return]    ${loc}

Finalize Registration
    Comment    Filling personal information
    UI Click    loc title male input
    UI Input Text    Pop    loc customer firstname input
    UI Input Text    Simon    loc customer lastname input
    UI Input Text    Simon    loc customer password input
    UI Select Dropdown    20    loc birth days select
    UI Select Dropdown    6    loc birth months select
    UI Select Dropdown    1987    loc birth years select
    UI Select Checkbox    loc newsletter checkbox
    UI Select Checkbox    loc special offer checkbox
    Comment    Filling address information
    UI Input Text    Pop    loc address firstname input
    UI Input Text    Simon    loc address lastname input
    UI Input Text    POP Inc.    loc address company input
    UI Input Text    Fashion street 67    loc address input
    UI Input Text    Angelcity    loc address city input
    UI Select Dropdown    6    loc address state select
    UI Input Text    12345    loc address postcode input
    UI Input Text    +36804445556    loc address mobile phone input
    UI Click    loc register submit button

loc title male input
    ${loc}    Set Variable    //input[@id='id_gender1']
    [Return]    ${loc}

loc birth years select
    ${loc}    Set Variable    //select[@id='years']
    [Return]    ${loc}
