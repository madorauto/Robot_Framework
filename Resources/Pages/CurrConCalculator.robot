*** Settings ***
Documentation  Currency Conversion Calculator Page
Library  SeleniumLibrary
Library  String
*** Keywords ***

Input Amount
  [Arguments]  ${BuySell}  ${amount}
  Wait Until Element Is Visible  xpath=//label[text()="${BuySell}"]/following-sibling::input  timeout=30
  Input Text  xpath=//label[text()="${BuySell}"]/following-sibling::input  ${amount}


Verify Amount
  [Arguments]  ${BuySell}  ${amount}
  Run Keyword If  '${BuySell}' == 'Sell'  Verify BuySell  Buy
  Run Keyword If  '${BuySell}' == 'Buy'  Verify BuySell  Sell


Verify BuySell
  [Arguments]  ${BuySell}
  ${amount}=  Get Value  xpath=//label[text()="${BuySell}"]/following-sibling::input
  Run Keyword If  '${amount}' != '${EMPTY}'  Failed BuySell  ${BuySell}

Failed BuySell
  [Arguments]  ${BuySell}
  Fail  Failed: ${BuySell} has value.

Click Country Language Menu
  Wait Until Element Is Visible  xpath=//span[@role="button"]  timeout=30
  Click Element   xpath=//span[@role="button"]

Click Country Menu
   Wait Until Element Is Visible  id=countries-dropdown  timeout=30
   Click Button  id=countries-dropdown

Click Country
  [Arguments]  ${countrylink}
  Wait Until Page Contains Element  xpath=//a[@href="${countrylink}"]  timeout=10
  Click Link   xpath=//a[@href="${countrylink}"]

Select Country
  [Arguments]  ${country}
  Click Country Language Menu
  Click Country Menu
  Click Country  ${country}

Verify Currency
  [Arguments]  ${currency}
  Wait Until Element Is Visible  xpath=//div[@data-ng-model="currencyExchangeVM.filter.from"]//span/span[text()="${currency}"]  timeout=30
  Element Should Be Visible  xpath=//div[@data-ng-model="currencyExchangeVM.filter.from"]//span/span[text()="${currency}"]

Verify Loss With SwedBank
  [Arguments]  ${countrycode}
  ${paysera}  Verify Paysera Amount  ${countrycode}
  ${swedbank}  Verify Swedbank Amount  ${countrycode}
  Verify Loss  ${paysera}  ${swedbank}  ${countrycode}


Verify Paysera Amount
  [Arguments]  ${countrycode}
  Wait Until ELement Is Visible  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td)[3]//span[@class="ng-binding"]  timeout=30
  ${paysera}=  Get Text  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td)[3]//span[@class="ng-binding"]
  [Return]  ${paysera}

Verify Swedbank Amount
  [Arguments]  ${countrycode}
  Wait Until ELement Is Visible  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td)[4]//span[@class="ng-binding"]  timeout=30
  ${swedbank}=  Get Text  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td)[4]//span[@class="ng-binding"]
  [Return]  ${swedbank}


Verify Loss
  [Arguments]  ${paysera}  ${bank}  ${countrycode}
  Wait Until Element Is Visible  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td//span[@class="other-bank-loss ng-binding ng-scope"])[1]  timeout=30
  ${loss}=  Get Text  xpath=(//span[@class="flag-icon-small flag-icon-${countrycode}"]/ancestor::td/following-sibling::td//span[@class="other-bank-loss ng-binding ng-scope"])[1]
  ${loss}=  Remove String  ${loss}  (  )
  ${payseraamount}=  Set Variable  ${paysera}
  ${payseraamount}=  Remove String  ${payseraamount}  ,
  ${bankamount}=  Set Variable  ${bank}
  ${bankamount}=  Remove String  ${bankamount}  ,
  ${calculatedloss}=  Evaluate  ${bankamount} - ${payseraamount}
  ${calculatedloss}=  Evaluate  "%.2f" % ${calculatedloss}
  Run Keyword If  '${loss}' != '${calculatedloss}'  Failed Loss  ${loss}  ${calculatedloss}

Failed Loss
  [Arguments]  ${loss}  ${calculatedloss}
  Fail  Failed: ${loss} and ${calculatedloss} is not equal.
