*** Variables ***
${url}  https://www.paysera.bg/v2/en-LT/fees/currency-conversion-calculator
${browser}  chrome
${amount}  100
${countrylink}  https://www.paysera.com/v2/en-GB/fees/currency-conversion-calculator
${currency}  GBP

@{countries}  &{country1}  &{country2}  &{country3}
&{country1}  countrylink=https://www.paysera.com/v2/en-GB/fees/currency-conversion-calculator  currency=GBP
&{country2}  countrylink=https://www.paysera.lv/v2/en-LV/fees/currency-conversion-calculator  currency=EUR
&{country3}  countrylink=https://www.paysera.ro/v2/en-RO/fees/currency-conversion-calculator  currency=RON

${countrycode}  us
@{countrycodes}  ru  dk  pl