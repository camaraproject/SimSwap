# Week 14 meeting

## Participants

4th April 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|MONA MOKHBER|Telefonica|
|3|José Luis Urien Pinedo|Telefonica|
|4|JORGE GARCIA HOSPITAL|Telefonica|
|5|PEDRO ANTONIO DE ALARCON SANCHEZ|Telefonica|
|6|Ludovic ROBERT|Orange|
|7|Cormac Hegarty|Ericsson|

## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap API

- [Issue #16](https://github.com/camaraproject/SimSwap/issues/16)
- participants discussed a scenario, when Service Provider requests sim swap information from MNO, but MNO has not registered an event of a sim Change. MNO performed API service, but value cannot be returned. Success (200OK) or Error (401 or 404) has implications for API consumer. We continue discusson to find a solution that can be described in API documentation.
- 
 
### NumberVerify

- [Issue #35](https://github.com/camaraproject/NumberVerification/issues/35)
- participants identified that current API descriptions might be confusing for software developers - two API definitions: MobileConnect & Camara flavors
- Mobile Identity APIs are commercially available and software developers are familiar with existing API design - making a change to existing standard might not be identified by software developers community as a positive change, due to existing Mobile Connect implementations
- additionally, recent changes inside commonalities working group describing the [notation of APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/API-design-guidelines.md#42-inputoutput-resource-definition), requires adoption of Mobile Connect API definition to be compliant with CAMARA
- there is a willingness assess benefits developers can get when having APIs similar to MC but not exactly aligned with them nor with 3GPP/TMF.

### OTP Validation

- no updates

-----

## AoB

- no AoB

## APs

1. Continue discussion on next alignment call that takes place 13th April 2023.
