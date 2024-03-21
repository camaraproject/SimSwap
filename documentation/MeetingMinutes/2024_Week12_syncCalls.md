# Week 12 meeting

## Participants

21 March 2024:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Huub Appelboom|KPN|
|3|ROBERT Ludovic|Orange|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|JORGE GARCIA HOSPITAL|Telefonica|
|6|Cormac Hegarty A|Ericsson|
|7|Toshi Wakayama|KDDI|
|8|Alex|IPification|
|9|Parichaya Shrivastava|spryfoxnetworks|


## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap

1. Alex from IPFication mentioned about Number Recycle product that can enhance existing simSwap API family
   * there was an ask to add this idea to Camara API backlog
2. Community discussed [PR#97](https://github.com/camaraproject/SimSwap/pull/94)
   * changes are fixing issues [#96](https://github.com/camaraproject/SimSwap/issues/96) & [#16](https://github.com/camaraproject/SimSwap/issues/166)
   * community decided to approve this PR
3. PRs regarding *testing* are awaiting resolution from [Commonalities WG](https://github.com/camaraproject/Commonalities/issues/94)

### NumberVerification
1. Discussion on [Issue #86](https://github.com/camaraproject/NumberVerification/issues/86)
   * @DT-DawidWroblewski mentioned about work that is currently concluded at GSMA Authorization Server Authenticator Capabilities Group, where new specification is in formal GSMA approval process. ETA - April 2024.
   * [Link to Member Gateway](https://membergateway.sharepoint.com/sites/wg-ISAG-ASACG)
   * it was suggested to move this issue to a discussion at [Identity&Consent Management group](https://github.com/camaraproject/IdentityAndConsentManagement) level
2. Number Verification API community input to [OIDC profile discussion](https://github.com/camaraproject/IdentityAndConsentManagement/pull/121)
   * Number Verification API has its own specifics that has to be considered inside Camara OIDC profile, like:
   * * no need to pass any phone number as a *login_hint* inside authorization request
   * * it must follow OIDC flow, where *network authentication* happens at MNO */authorize* endpoint 
   * * ID Token is a result of OIDC flow, although it does not bring any value to developer currenlty (this might change when Camara community desceibes ID Token & access token in a context of ODIC flow)
   * it was suggested to pass our community feedback **when first document, that decsribes Camara OIDC profile, arrives**

### OTP Validation
1. Closing issues
   * [#41](https://github.com/camaraproject/OTPvalidationAPI/issues/41) -> @DT-DawidWroblewski creates a PR to fix a link to release version

## AoB
1. meeting series created by @DT-DawidWroblewski shall be canceled => @bigludo7 shall create new series on a same basis, i.e. every 2 weeks at Thursday, 8:30 AM, CET
2. @bigludo7 shall mention about *open position* for **simSwap/NumberVerification/OTPValidationAPI** lead at Camara TSC
3. @DT-DawidWroblewski mentioned that Deutsche Telekom delegates a new person to join this community

## APs
