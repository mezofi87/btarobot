*** Settings ***
Resource          ../helper_keywords.robot

*** Keywords ***
loc order history row by order reference
    [Arguments]    ${order_reference}
    ${loc}    Set Variable    //a[@class='color-myaccount' and contains(text(),'${order_reference}')]/../../../tr
    [Return]    ${loc}

Check Order Reference
    [Arguments]    ${order_reference}
    UI Wait Until Element Is Visible    loc order history row by order reference    ${order_reference}
