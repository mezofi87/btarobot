*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String
Library           OperatingSystem
Library           DateTime

*** Variables ***
${selenium_timeout}    60
${url}            http://automationpractice.com
${browser}        Chrome

*** Keywords ***
UI Wait Until Element Is Visible
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}

UI Click
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Wait Until Keyword Succeeds    5x    200ms    Click Element    ${result}

UI Input Text
    [Arguments]    ${text}    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Clear Element Text    ${result}
    Input Text    ${result}    ${text}

UI Clear Input Text
    [Arguments]    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Clear Element Text    ${result}

UI Mouse Over
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Wait Until Element Is Visible    ${result}
    Mouse Over    ${result}

UI Press Enter
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Press Keys    ${result}    RETURN

UI Press Tab
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Press Keys    ${result}    TAB

UI Wait Until Element Is Not Visible
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Not Visible    ${result}    ${selenium_timeout}

UI Wait Until Page Contains Element
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}

UI Wait Until Page Does Not Contain Element
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Does Not Contain Element    ${result}    ${selenium_timeout}

UI Open Browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Comment    Close All Browsers
    Comment    ${chromeoptions}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Comment    ${prefs}    Create Dictionary    download.default_directory=${browser_download_dir}
    Comment    Call Method    ${chromeoptions}    add_experimental_option    prefs    ${prefs}
    Comment    Run Keyword If    ${run_headless}==${True}    Call Method    ${chromeoptions}    add_argument    --headless
    Comment    Run Keyword If    ${run_docker}==${True}    Call Method    ${chromeoptions}    add_argument    --disable-gpu
    Comment    Run Keyword If    ${run_docker}==${True}    Call Method    ${chromeoptions}    add_argument    --no-sandbox
    Comment    Run Keyword If    ${run_docker}==${True}    Call Method    ${chromeoptions}    add_argument    --kiosk
    Comment    Run Keyword If    ${run_docker}==${True}    Call Method    ${chromeoptions}    add_argument    --disable-dev-shm-usage
    Comment    Run Keyword If    ${run_docker}==${False}    Call Method    ${chromeoptions}    add_argument    --start-maximized
    Comment    ${webdriver_created}    Run Keyword And Return Status    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    Comment    ${actual_webdriver}    Run Keyword Unless    ${webdriver_created}    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    Comment    ${webdriver}    Get Current Webdriver
    Comment    Enable Download In Headless Chrome    ${webdriver}    ${browser_download_dir}
    Comment    Set Window Size    1920    1080
    Comment    Go To    ${url}

UI Page Should Contain Element
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Page Should Contain Element    ${result}

UI Page Should Not Contain Element
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Page Should Not Contain Element    ${result}

UI Get Text
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    ${text}    Set Variable    ${EMPTY}
    FOR    ${loopvar}    IN RANGE    1    99999
        sleep    300ms
        ${text}    Get Text    ${result}
        Exit For Loop If    '${text}'!='${EMPTY}' or ${loopvar}==50
    END
    Run Keyword If    '${text}'=='${EMPTY}'    FAIL    Getting text is not possible in 15s
    [Return]    ${text}

UI Element Should Be Visible
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Element Should Be Visible    ${result}

UI Clear Element Text With Backspace
    [Arguments]    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}
    Wait Until Element Is Visible    ${result}
    ${attr_value}    SeleniumLibrary.Get Element Attribute    ${result}    value
    ${backspace_count}    Get Length    ${attr_value}
    Run Keyword If    '${attr_value}'!=''    Repeat Keyword    ${backspace_count+1}    Press Keys    ${result}    BACKSPACE

Generate Timestamp
    ${date}    Get Current Date    result_format=%Y%m%d%H%M%S
    [Return]    ${date}

UI Select Dropdown
    [Arguments]    ${option_value}    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Select From List By Value    ${result}    ${option_value}

UI Select Checkbox
    [Arguments]    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Select Checkbox    ${result}

UI Choose File
    [Arguments]    ${file}    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}
    Choose File    ${result}    ${file}

UI Get Value
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    ${value}    Set Variable    ${EMPTY}
    FOR    ${loopvar}    IN RANGE    1    99999
        sleep    300ms
        ${value}    Get Value    ${result}
        Exit For Loop If    '${value}'!='${EMPTY}' or ${loopvar}==50
    END
    Run Keyword If    '${value}'=='${EMPTY}'    FAIL    Getting text is not possible in 15s
    [Return]    ${value}

UI Element Should Be Disabled
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    Element Should Be Disabled    ${result}

UI Press Esc
    [Arguments]    ${locators}    @{keywordargs}
    ${result}=    Run Keyword    ${locators}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Press Keys    ${result}    ESCAPE

UI Get Element Count
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    ${element_count}    Get Element Count    ${result}
    [Return]    ${element_count}

UI Get Element Attribute
    [Arguments]    ${attribute}    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    ${attribute_result}    Get Element Attribute    ${result}    ${attribute}
    [Return]    ${attribute_result}

UI Get Inner Html
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    ${innerhtml}    Set Variable    ${EMPTY}
    FOR    ${loopvar}    IN RANGE    1    99999
        sleep    300ms
        ${innerhtml}    Get Element Attribute    ${result}    innerHTML
        ${innerhtml_length}    Get Length    ${innerhtml}
        Exit For Loop If    ${innerhtml_length}>0 or ${loopvar}==50
    END
    Run Keyword If    ${innerhtml_length}=='0'    FAIL    Getting text is not possible in 15s
    [Return]    ${innerhtml}
