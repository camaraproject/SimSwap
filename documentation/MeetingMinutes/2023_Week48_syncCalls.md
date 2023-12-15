# Week 48 meeting

## Participants

30th November 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Sönke Peters|Vodafone|
|3|Sebastian Köller|Vodafone|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|JORGE GARCIA HOSPITAL|Telefonica|
|6|Foo Ming Hui|Singtel|
|7|Gregory Liokumovich|Ericsson|
|8|Cormac Hegarty A|Ericsson|

## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap

1. Discusson about sub-project/API name.
   
   Sugesstion that simSwap might be misleading, as for the audience it is explicit event, when subscriber makes a change of a SIM card.

   In general the scope of API is fine - it delivers a date of a last MSISDN and IMSI pairing, although it would be better to place additional use cases and sim swap scenarios in API description.

2. X-correlator
   
   X-correlator header should be a part of all API operators.

3. Test cases
   
   waiting for commonalities WG to deliver guidelines about test cases

### NumberVerification

1. Discussion about "eligibility check" before triggering Number Verification flow.
2. @DT-DawidWroblewski mentioned about activity in GSMA Authorization Server Authenticator Capabilities (ASAC) group, where community discuss about eligibility check and seamless authenticator capabilities.

[Link to join](https://myaccess.microsoft.com/%40MemberGateway.onmicrosoft.com#/access-packages/6658a7c4-7b25-4731-a3bc-b9bd7af7d2b1)
[Link to group](https://membergateway.sharepoint.com/sites/wg-ISAG-ASACG)

### OTP Validation
- no updates
  
-----

## AoB

- no AoB

## APs
* AP1 @gregory1g creates a PR to simSwap API that adds new description and use cases for simSwap event
* AP2 @fernandopradocabrillo creates a PR to add x-correlator to simSwap API
* 