*** Settings ***
Documentation  Currency Conversion Calculator
Library  SeleniumLibrary
Resource  ../Resources/Common.robot
Resource  ../Resources/Data/CurrConCalculator.robot
Suite Setup  Start Test  ${url}  ${browser}


*** Test Cases ***
Input Sell
  [Tags]  InputSell
  #Given: User is in the Currency Conversion Calculator
  #When: User Input amount on Sell
  CurrConCalculator.Input Amount  Sell  ${amount}
  #Then: Buy Will be empty
  CurrConCalculator.Verify Amount  Sell  ${amount}

Input Buy
  [Tags]  InputBuy
  #Given: User is in the Currency Conversion Calculator
  #When: User Input amount on Sell
  CurrConCalculator.Input Amount  Buy  ${amount}
  #Then: Buy Will be empty
  CurrConCalculator.Verify Amount  Buy  ${amount}

Select Country
  [Tags]  SelectCountry
  #Given: User is in the Currency Conversion Calculator
  #When: User Input amount on Sell
  CurrConCalculator.Select Country  ${countrylink}
  #Then: Buy Will be empty
  CurrConCalculator.Verify Currency  ${currency}


Select Multiple Countries
  [Tags]  SelectMultipleCountries
  #Given: User is in the Currency Conversion Calculator
  #Loop for mutiple countries
  FOR  ${country}  IN  @{countries}
  #When: User Input amount on Sell
    CurrConCalculator.Select Country  ${country.countrylink}
  #Then: Buy Will be empty
    CurrConCalculator.Verify Currency  ${country.currency}
  END
  #End of loop

Verify Loss With SwedBank
  [Tags]  VerifyLossWithSwedBank
  #Given: User is in the Currency Conversion Calculator
  #Then: Loss With SwedBank will be calculated
  CurrConCalculator.Verify Loss With SwedBank  ${countrycode}


Verify Mutiple Loss With SwedBank
  [Tags]  VerifyMutipleLossWithSwedBank
  #Given: User is in the Currency Conversion Calculator
  #Then: Loss With SwedBank will be calculated
  FOR  ${countrycodes}  IN  @{countrycodes}
    CurrConCalculator.Verify Loss With SwedBank  ${countrycodes}
  END

Test