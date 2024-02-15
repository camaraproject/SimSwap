# Week 4 meeting

## Participants

25 January 2024:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Huub Appelboom|KPN|
|3|Sönke Peters|Vodafone|
|4|Alexander Boraczynski|Vodafone|
|5|ROBERT Ludovic|Orange|
|6|FERNANDO PRADO CABRILLO|Telefonica|
|7|JORGE GARCIA HOSPITAL|Telefonica|
|8|Gregory Liokumovich|Ericsson|
|9|Cormac Hegarty A|Ericsson|
|10|Foo Ming Hui|Singtel|
|11|Surajj Jaggernath|Vodacom|


## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap

1. Discussion about *3-legged-flow* performance
   * OIDC CIBA vs OAUTH2.0 Client Credentials
   * end-user opt-out capability should be considered in overall discussion as well as Camara APIs characteristics, i.e. serving many developers and use cases
   * flow optimisation is a must

### NumberVerification
1. Discussion about Number Verify flow with aggregator provided by @mhfoo
2. Test Cases for Number Verification

### OTP Validation

N/A

## AoB

1. Onboarding APIs
   * there is a discussion at OGW to use security schemes that works with specific use cases, e.g. Client Credentials works with AntiFraud use cases & banks as a service providers 
2. Fine-tune error responses
   * remove *409*
   * ad error when phone *number is unknown*

## APs
1. AP1 @DT-DawidWroblewski - checks the status of phone number format discussion with QoD sub-project leaders (@hdamker)
2. AP2 @bigludo7 - adds test cases for Number Verification - starting with an issue
