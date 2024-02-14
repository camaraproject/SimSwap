# Week 2 meeting

## Participants

11 January 2024:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Huub Appelboom|KPN|
|3|Sönke Peters|Vodafone|
|4|Klaus Reifenrath|Vodafone|
|5|FERNANDO PRADO CABRILLO|Telefonica|
|6|JORGE GARCIA HOSPITAL|Telefonica|
|7|Gregory Liokumovich|Ericsson|
|8|Cormac Hegarty A|Ericsson|
|9|Foo Ming Hui|Singtel|
|10|Victor Javier Quiroga Reyes|madisonmk.com|


## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap

1. Discussion about *wildcard* scope handling
   * describe a way to handle wildcard scopes inside API description
   * requires adding new scope inside yaml file
2. New release API planned after MWC 2024
3. Issue [#84](https://github.com/camaraproject/SimSwap/issues/84) discussion
   * good summary provided by @eric-murray
   * awaiting resolution inside commonalities
4. API requires fixing with regards to "null" value
   * *lastSimChange* attribute should be **REQUIRED**

### NumberVerification
1. Linting rules
   * align with @rartych
2. Number Verify flow with aggregator
   * @mhfoo provides sample diagram
   * provide a reference to OGW

### OTP Validation

1. Check if OAUTH2.0 Client Credentials flow (2-legged) is applicable in this API
2. Current design makes it challenging to identify MNO that has to serve this API, i.e. there is no MNO discover process (e.g. with a support of Telco Finder) in place
3. @ajamus is asked to join for a discussion

## AoB

N/A

## APs
1. AP1 @DT-DawidWroblewski - creates a PR to simSwap api and makes lastSimChange attribute **REQUIRED**
2. AP2 @mhfoo - creates a sequence diagram
