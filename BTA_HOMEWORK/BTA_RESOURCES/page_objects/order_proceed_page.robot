*** Settings ***
Resource          ../helper_keywords.robot

*** Keywords ***
loc proceed to checkout link
    ${loc}    Set Variable    (//a[@title='Proceed to checkout'])[2]
    [Return]    ${loc}

loc proceed to checkout button on address tab
    ${loc}    Set Variable    //button[@name='processAddress']
    [Return]    ${loc}

loc agree terms checkbox on shipping tab
    ${loc}    Set Variable    //input[@id='cgv']
    [Return]    ${loc}

loc proceed to checkout button on shipping tab
    ${loc}    Set Variable    //button[@name='processCarrier']
    [Return]    ${loc}

loc pay by bank wire link on payment tab
    ${loc}    Set Variable    //a[@title='Pay by bank wire']
    [Return]    ${loc}

loc confirm order button on payment tab
    ${loc}    Set Variable    //button/span[text()='I confirm my order']
    [Return]    ${loc}

loc order finish information box
    ${loc}    Set Variable    //div[@class='box']
    [Return]    ${loc}

Complete And Validate Order
    UI Click    loc proceed to checkout link
    UI Click    loc proceed to checkout button on address tab
    UI Select Checkbox    loc agree terms checkbox on shipping tab
    UI Click    loc proceed to checkout button on shipping tab
    UI Click    loc pay by bank wire link on payment tab
    UI Click    loc confirm order button on payment tab
    ${order_information}    UI Get Inner Html    loc order finish information box
    ${target_string}    Get Regexp Matches    ${order_information}    [A-Z]{9}
    ${order_reference}    Set Variable    ${target_string[0]}
    UI Click    loc back to orders link
    [Return]    ${order_reference}

loc back to orders link
    ${loc}    Set Variable    //a[@title='Back to orders']
    [Return]    ${loc}
