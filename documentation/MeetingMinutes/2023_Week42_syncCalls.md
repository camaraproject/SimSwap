# Week 42 meeting

## Participants

19th October 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Alexander Boraczynski|Vodafone|
|3|Sönke Peters|Vodafone|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|JORGE GARCIA HOSPITAL|Telefonica|
|6|Toyeeb Rehman|GSMA|
|7|Gregory Liokumovich|Ericsson|
|8|Cormac Hegarty A|Ericsson|

## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
1. SimSwap Notification Subscription API 

- subscribing to SIM swap events might bring some new legal challenges - get feedback from marketing/legal about subscribing to End-User data resource events. -> AP
- Notification Subscription API requires different technical solutions on the MNO side. Therefore, it requires a feasibility study on the MNO side

2. Discussion on the [Issue#16](https://github.com/camaraproject/SimSwap/issues/16)

- An empty string value may be feasible, as it enables API to deliver 200 OK in an event where no SIM change occurred
- null may be an option
- SIM card activation date may be an option, although it should be limited, i.e. it makes sense when it is limited by period (e.g. when the activation date is older than 30 days it does not make sense to return it)

3. Test cases discussion
- @trehman-gsma introduced test cases for Camara SIM Swap API
- an issue shall follow to discuss this topic -> AP 
- release version should be created upon merged PR

### NumberVerification
1. Discussion on the Issue [#61](https://github.com/camaraproject/NumberVerification/issues/61) and changes introduced in the [PR#60](https://github.com/camaraproject/NumberVerification/pull/60)
- changes introduced by TEF point to usage of OAUTH2.0 Authorization Code grant, therefore security scheme has to be updated, as it is not OpenID Connect (that creates id_token & access_token)
- there should be a general rule describing access_token - should it be in the form of JWT? What claims should it contain? Once TEF delivers a statement about changes introduced, a discussion should follow inside Commonalities WG


### OTP Validation
1. release version [v0.5.0](https://github.com/camaraproject/OTPvalidationAPI/releases/tag/v0.5.0) created
  
-----

## AoB

1. No AoB

## APs
1. @DT-DawidWroblewski gets initial feedback from Telekom about subscribing to end-user data resource events
2. @trehman-gsma creates an issue to discuss test cases for Camara SIM Swap API