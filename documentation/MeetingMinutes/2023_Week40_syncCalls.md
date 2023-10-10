# Week 38 meeting

## Participants

2nd October 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Klaus Reifenrath|Vodafone|
|3|ROBERT Ludovic|Orange|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|Toshi Wakayama|KDDI|
|6|Gregory Liokumovich|Ericsson|
|7|Cormac Hegarty A|Ericsson|



## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
1. security scheme discussion

- OAUTH2.0 Client credentials security scheme should supported by SIM Swap API, as this solution that is currently serverd to customers within Mobile Connect API services suite.
- Commonalities WG delivered an elegant solution to discover security schemes, that are available
- changes has to be introduced to API description that gives developer information about what security schemes are supported -> AP 

2. API version

- discussion about moving towards v0.8.0, that can be used to create a release

3. API release

- release version should be created upon merged PR


### NumberVerification
1. product naminig
2. updating scope values
3. network based authentication description
4. UML update
### OTP Validation
1. API version

- it has been agreed to update API version to 0.8.0 and create release version
  
-----

## AoB

1. security schemes discussion in Commonalities

currently there is a strong recommendation from Commonalities WG to use three-legged-token flow for APIs that involves end-user resource. However, it is up to sub-project to specify details of each API security scheme.

## APs
1. @DT-DawidWroblewski creates commit to @fernandopradocabrillo PR in SimSwap API sub-project, with addons:
   1. description in yaml about supported security schemes inside SimSwap API
   2. version 0.8.0
2. @DT-DawidWroblewski creates SimSwap API release version based on v0.8.0
3. @DT-DawidWroblewski updates OTPValidation API version to 0.8.0
4. @DT-DawidWroblewski creates OTPValidation API release version based on v0.8.0