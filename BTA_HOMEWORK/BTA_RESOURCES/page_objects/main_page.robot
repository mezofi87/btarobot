*** Settings ***
Resource          ../helper_keywords.robot

*** Variables ***

*** Keywords ***
Delete And Validate Products From Cart
    @{product_prices}    Create List
    FOR    ${index}    IN RANGE    1    3
        UI Mouse Over    loc product container by number    ${index}
        ${product_price}    UI Get Text    loc product price by number    ${index}
        ${stripped_product_price}    Strip String    ${product_price}    characters=$
        Append To List    ${product_prices}    ${stripped_product_price}
        UI Click    loc cart button on product by number    ${index}
        UI Wait Until Element Is Visible    loc cart successful message text
        UI Click    loc continue shopping button
        UI Wait Until Element Is Not Visible    loc continue shopping button
    END
    Log List    ${product_prices}
    UI Mouse Over    loc cart link
    ${cart_total}    UI Get Text    loc cart total value
    ${stripped_cart_total}    Strip String    ${cart_total}    characters=$
    ${selected_price}    Get From List    ${product_prices}    0
    UI Click    loc product delete link on cart by price    $${selected_price}
    UI Wait Until Element Is Not Visible    loc product delete link on cart by price    $${selected_price}
    ${stripped_cart_total}    Convert To Number    ${stripped_cart_total}
    ${selected_price}    Convert To Number    ${selected_price}
    ${subtract_result}    Evaluate    ${stripped_cart_total}-${selected_price}
    ${cart_total}    UI Get Text    loc cart total value
    ${stripped_cart_total}    Strip String    ${cart_total}    characters=$
    Should Be Equal As Numbers    ${subtract_result}    ${stripped_cart_total}
    ${selected_price}    Get From List    ${product_prices}    1
    UI Click    loc product delete link on cart by price    $${selected_price}
    UI Wait Until Element Is Not Visible    loc product delete link on cart by price    $${selected_price}
    UI Wait Until Element Is Visible    loc empty product caption on cart

Add And Validate Products On Cart
    [Arguments]    ${add_amount}
    @{product_list}    Create List
    ${product_name}    Set Variable    ${EMPTY}
    ${product_price}    Set Variable    ${EMPTY}
    FOR    ${index}    IN RANGE    1    ${${add_amount}+1}
        UI Mouse Over    loc product container by number    ${index}
        ${product_title}    UI Get Element Attribute    title    loc product name by number    ${index}
        ${product_price}    UI Get Text    loc product price by number    ${index}
        Append To List    ${product_list}    ${product_title}:${product_price}
        UI Click    loc cart button on product by number    ${index}
        UI Wait Until Element Is Visible    loc cart successful message text
        UI Click    loc continue shopping button
        UI Wait Until Element Is Not Visible    loc continue shopping button
        ${cart_amount}    UI Get Text    loc cart amount
        Should Be Equal As Numbers    ${cart_amount}    ${index}
    END
    Log List    ${product_list}
    UI Mouse Over    loc cart link
    ${product_count_on_cart}    UI Get Element Count    loc product info box from cart
    ${product_list_length}    Get Length    ${product_list}
    Should Be Equal As Numbers    ${product_count_on_cart}    ${product_list_length}
    FOR    ${index}    IN RANGE    0    ${product_list_length}
        ${list_item}    Get From List    ${product_list}    ${index}
        ${product_title}    ${product_price}    Split String    ${list_item}    :
        UI Wait Until Element Is Visible    loc product title from cart by title text    ${product_title}
    END

Check Search Results
    [Arguments]    ${search_text}
    ${container_count}    UI Get Element Count    loc product container
    ${container_count_with_text}    UI Get Element Count    loc product container by search text    ${search_text}
    Should Be Equal As Numbers    ${container_count}    ${container_count_with_text}

Navigate To Sign in Page
    UI Click    loc sign in link

Search Product
    [Arguments]    ${text}
    UI Input Text    ${text}    loc product search input
    UI Click    loc product search button

loc cart amount
    ${loc}    Set Variable    //span[@class='ajax_cart_quantity unvisible']
    [Return]    ${loc}

loc cart button on product by number
    [Arguments]    ${number}
    ${loc}    Set Variable    (//div[@class='product-container'])[${number}]//a[@title='Add to cart']
    [Return]    ${loc}

loc cart link
    ${loc}    Set Variable    //a[@title='View my shopping cart']
    [Return]    ${loc}

loc cart successful message text
    ${loc}    Set Variable    //h2[contains(.,'Product successfully added to your shopping cart')]
    [Return]    ${loc}

loc cart total value
    ${loc}    Set Variable    //span[@class='price cart_block_total ajax_block_cart_total']
    [Return]    ${loc}

loc continue shopping button
    ${loc}    Set Variable    //span[contains(@title,'Continue shopping')]
    [Return]    ${loc}

loc product container
    ${loc}    Set Variable    //div[@class='product-container']
    [Return]    ${loc}

loc product container by number
    [Arguments]    ${number}
    ${loc}    Set Variable    (//div[@class='product-container'])[${number}]
    [Return]    ${loc}

loc product container by search text
    [Arguments]    ${search_text}
    ${loc}    Set Variable    //div[@class='product-container']//h5/a[contains(@title,'${search_text}')]
    [Return]    ${loc}

loc product info box from cart
    ${loc}    Set Variable    //div[@class='cart-info']
    [Return]    ${loc}

loc product name by number
    [Arguments]    ${number}
    ${loc}    Set Variable    (//div[@class='product-container'])[${number}]//a[@class='product-name']
    [Return]    ${loc}

loc product price by number
    [Arguments]    ${number}
    ${loc}    Set Variable    (//div[@class='product-container'])[${number}]//span[@itemprop='price']
    [Return]    ${loc}

loc product search button
    ${loc}    Set Variable    //button[@name='submit_search']
    [Return]    ${loc}

loc product search input
    ${loc}    Set Variable    //input[@id='search_query_top']
    [Return]    ${loc}

loc product title from cart by title text
    [Arguments]    ${title_text}
    ${loc}    Set Variable    //div[@class='cart-info']//a[@title='${title_text}']
    [Return]    ${loc}

loc sign in link
    ${loc}    Set Variable    //a[@class='login']
    [Return]    ${loc}

loc product delete link on cart by price
    [Arguments]    ${price}
    ${loc}    Set Variable    //span[@class='price' and text()='${price}']/../..//span[@class='remove_link']
    [Return]    ${loc}

loc empty product caption on cart
    ${loc}    Set Variable    //span[@class='ajax_cart_no_product' and text()='(empty)']
    [Return]    ${loc}

Navigate To Home Screen
    Go To    ${url}

Purchase A Product From Main Page
    UI Mouse Over    loc product container by number    1
    UI Click    loc cart button on product by number    1
    UI Wait Until Element Is Visible    loc cart successful message text
    UI Click    loc first proceed to checkout link
    UI Wait Until Element Is Not Visible    loc first proceed to checkout link

loc first proceed to checkout link
    ${loc}    Set Variable    //a[@title='Proceed to checkout']
    [Return]    ${loc}
