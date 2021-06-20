*** Settings ***
Resource          ../helper_keywords.robot

*** Keywords ***
loc myaccount heading
    ${loc}    Set Variable    //h1[text()='My account']

Check My Account Page Items
    UI Wait Until Element Is Visible    loc order page link
    UI Wait Until Element Is Visible    loc credit slips page link
    UI Wait Until Element Is Visible    loc addresses page link
    UI Wait Until Element Is Visible    loc information page link
    UI Wait Until Element Is Visible    loc wishlist page link

loc order page link
    ${loc}    Set Variable    //a[@title='Orders']
    [Return]    ${loc}

loc credit slips page link
    ${loc}    Set Variable    //a[@title='Credit slips']
    [Return]    ${loc}

loc addresses page link
    ${loc}    Set Variable    //a[@title='Addresses']
    [Return]    ${loc}

loc information page link
    ${loc}    Set Variable    //a[@title='Information']
    [Return]    ${loc}

loc wishlist page link
    ${loc}    Set Variable    //a[@title='My wishlists']
    [Return]    ${loc}
