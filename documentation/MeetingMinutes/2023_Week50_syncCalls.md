# Week 50 meeting

## Participants

14 December 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|ROBERT Ludovic|Orange|
|3|Toyeeb Rehman|GSMA|
|4|Gregory Liokumovich|Ericsson|
|5|Cormac Hegarty A|Ericsson|

## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap

1. Discussion about returned objects, while API cannot provide a legitimate response
   * if simSwap date is unavailable and service completed runtime, API should return object back to developer stating this fact
   * current API design enables followng return options:
    - ${date-time}
    - null
    - empty response
   * conclusion is that it is up to business side to decide what should be returned
2. Test cases
   * waiting for Commonalities WG guidelines

### NumberVerification
1. Discussion about phone number format
   * phone number pattern revieled in QoD sub-project
   * discussion has been taken over to commonalities
   * awaiting for commonalities guideline (@bigludo7 shares a link to discussion)
   * check with 
2. ad

### OTP Validation

1. Check if OAUTH2.0 Client Credentials flow (2-legged) is applicable in this API
2. Current design makes it challenging to identify MNO that has to serve this API, i.e. there is no MNO discover process (e.g. with a support of Telco Finder) in place
3. Further assessment has to be performed to check if API definition follows commonalities guidelines with regards to status codes & messages 

## AoB

1. OAS Linting
   * check if simSwap, NumberVerification, OTPValidation projects can follow OAS linting
   * topic triggered in [NumberVerificatio issue #75](https://github.com/camaraproject/NumberVerification/issues/75)
2. CSP definition
   * sub-projects has to follow a common Camara glossary
   * currently readers might experience confusion, when checking acronyms used in Camara, e.g. CSP can be defined as Communications Service Provider, but also as Cloud Service Provider
3. Discussion about Camara OIDC Profile, that is planned to be designed in 2024
   * should add more clarity to AuthN/AuthZ concept

## APs
1. AP1 @DT-DawidWroblewski - checks the status of phone number format discussion with QoD sub-project leaders (@hdamker)
2. AP2 @trehman-gsma - adds a comment about conclusion from meeting inside [#16](https://github.com/camaraproject/SimSwap/issues/16)
