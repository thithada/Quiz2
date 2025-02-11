*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
# Basic variables
${BROWSER}        chrome
${URL}            http://automationexercise.com
${NAME}           Test User
${EMAIL}          test@example.com
${SUBJECT}        Test Subject
${MESSAGE}        This is a test message
${FILE_PATH}      ${EXECDIR}${/}test_files${/}test.txt

*** Keywords ***
# Browser initialization
Open Browser And Navigate
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

# Homepage verification
Verify Homepage
    Wait Until Element Is Visible    xpath://a[contains(text(),'Home')]
    Page Should Contain    Automation Exercise

# Click Contact Us button
Click Contact Us Button
    Click Element    xpath://a[contains(text(),'Contact us')]

# Verify Get In Touch section
Verify Get In Touch Section
    Wait Until Element Is Visible    xpath://h2[contains(text(),'Get In Touch')]
    Element Should Be Visible    xpath://h2[contains(text(),'Get In Touch')]

# Fill contact form
Fill Contact Form
    Input Text    name:name    ${NAME}
    Input Text    name:email    ${EMAIL}
    Input Text    name:subject    ${SUBJECT}
    Input Text    name:message    ${MESSAGE}
    ${test_file}=    Create And Get Test File
    Choose File    name:upload_file    ${test_file}

# Create test file
Create And Get Test File
    Create Directory    ${EXECDIR}${/}test_files
    ${file_path}=    Set Variable    ${EXECDIR}${/}test_files${/}test.txt
    Create File    ${file_path}    This is test file content
    [Return]    ${file_path}

# Submit form and handle alert
Submit Form And Handle Alert
    Click Button    name:submit
    Handle Alert    accept

# Verify success message
Verify Success Message
    Wait Until Element Is Visible    xpath://div[contains(text(),'Success! Your details have been submitted successfully.')]
    Element Should Be Visible    xpath://div[contains(text(),'Success! Your details have been submitted successfully.')]

# Return to homepage and verify
Return To Homepage And Verify
    Click Element    xpath://a[contains(text(),'Home')]
    Wait Until Element Is Visible    xpath://a[contains(text(),'Home')]
    Page Should Contain    Automation Exercise

# Clean up test files
Clean Test Files
    Remove File    ${EXECDIR}${/}test_files${/}test.txt
    Remove Directory    ${EXECDIR}${/}test_files

*** Test Cases ***
Contact Form Test
    Open Browser And Navigate
    Verify Homepage
    Click Contact Us Button
    Verify Get In Touch Section
    Fill Contact Form
    Submit Form And Handle Alert
    Verify Success Message
    Return To Homepage And Verify
    [Teardown]    Run Keywords    Close Browser    AND    Clean Test Files
