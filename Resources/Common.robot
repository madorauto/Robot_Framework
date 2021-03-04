*** Settings ***
Library  SeleniumLibrary
Resource  Pages/CurrConCalculator.robot
*** Keywords ***

Start Test
  [Arguments]  ${url}  ${browser}
  Open Browser  ${url}  ${browser}
  Maximize Browser Window
  Sleep  5s
