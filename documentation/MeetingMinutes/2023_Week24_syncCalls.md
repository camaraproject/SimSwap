# Week 24 meeting

## Participants

15th June 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|MONA MOKHBER|Telefonica|
|3|Klaus Reifenrath|Vodafone|
|4|Sönke Peters|Vodafone|
|5|Nevin Aquinas|Vodafone|
|6|Wolfgang Arendt|Vodafone|
|7|Ludovic ROBERT|Orange|
|8|Toshi (Toshiyasu) Wakayama|KDDI|
|9|Gautam Hazari|Sekura|
|10|Mohammad Sahid Khan|Etisalat|
|11|Prashant Sidana|Etisalat|
|12|Cormac Hegarty A|Ericsson|
|13|Gregory Liokumovich|Ericsson|
|14|Ashwin Nabil Careem|IBEM|
|15|Sajith Nedunmullage|IBEM|


## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
- discussed error code for a scenario when MSISDN cannot be handled by MNO => general code message was suggested and placed inside PR
- Timezone discussion => AP to move it to commonalities
- discussion about how to handle Mobile Connect APIs => 3 scenarios came out from discussion:
  1. create a dedicated sub-project for Mobile Connect APIs inside Camara
  2. create a dedicated branch & tag inside existing repositories
  3. create a reference to Mobile Connect APIs inside Camara API description and archive MC flavor => AP to place these inside Issue#200 inside Commonalities WG
 
### NumberVerification
- merged PR, which delivers details/enhancements for Camara NumberVerify API decsriptin (yaml)
- sequence diagram presents high level flow. Additional description regarding *Network Authentication* might be required.
- Discussion around Access Token - for NumberVerify it is impossible to use an Access Token from other APIs, e.g. QoD, as NumberVerification API requires building an MNO context beteween client and MNO, so Access Token is unique for this scenario 

### OTP Validation
- Etisalat (Mohammad) described use cases for *message_id* parameter

-----

## AoB

## APs
1. Take discussion about time format to Commonalities WG => @bigludo7
2. Prepare scenarios for Mobile Connect APIs handling for a decission to move forward => @DT-DawidWroblewski
3. Etisalat to deliver use case description for *message_id* and onboarding procedure and place it in GitHub. Afterwards group shall decide how to progress with this change inside OTPValidationAPI repo
