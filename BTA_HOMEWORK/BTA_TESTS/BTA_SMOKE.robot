*** Settings ***
Suite Setup
Test Setup
Resource          ../BTA_RESOURCES/page_objects/main_page.robot
Resource          ../BTA_RESOURCES/page_objects/sign_in_page.robot
Resource          ../BTA_RESOURCES/page_objects/create_account_page.robot
Resource          ../BTA_RESOURCES/page_objects/my_account_page.robot
Resource          ../BTA_RESOURCES/page_objects/order_proceed_page.robot
Resource          ../BTA_RESOURCES/page_objects/order_history_page.robot

*** Test Cases ***
REGISTRATION
    [Setup]    UI Open Browser
    Navigate To Sign in Page
    Create An Account
    Finalize Registration
    Check My Account Page Items
    [Teardown]    Close All Browsers

PRODUCT_SEARCH
    [Setup]    UI Open Browser
    Search Product    Printed
    Check Search Results    Printed
    [Teardown]    Close All Browsers

ADD_TO_CART
    [Setup]    UI Open Browser
    Add And Validate Products On Cart    3
    [Teardown]    Close All Browsers

DELETE_FROM_CART
    [Setup]    UI Open Browser
    Delete And Validate Products From Cart
    [Teardown]    Close All Browsers

PURCHASE PRODUCT
    [Setup]    UI Open Browser
    Navigate To Sign in Page
    Log In    mezofi20210620164227@btahomework.com    Simon
    Navigate To Home Screen
    Purchase A Product From Main Page
    ${order_reference}    Complete And Validate Order
    Check Order Reference    ${order_reference}
    [Teardown]    Close All Browsers
