# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Simple Test Case
    [Documentation]    Just goes to the main screen
    Appstate           Home
    ClickText          User menu
    ClickText          Logout