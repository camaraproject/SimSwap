# Week 36 meeting

## Participants

9th September 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Alexander Boraczynski|Vodafone|
|3|ROBERT Ludovic|Orange|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|JORGE GARCIA HOSPITAL|Telefonica|
|6|Prashant Sidana|Etisalat|
|7|Gregory Liokumovich|Ericsson|
|8|Cormac Hegarty A|Ericsson|



## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
1. Alexander Boraczyński requested to have information about differences between Mobile Connect & CAMARA versions of SimSwap API to have visibility on changes that have to be performed on local systems to implement CAMARA API flavour, as Mobile Connect APIs are currently commercially served on the German market (Local Champion activity).
2. Notification/subscription concept to be introduced as an issue that will work out the PR that brings new API in SimSwap family (new yaml file and API description).
   - @bigludo7 shall create an issue to continue the discussion about this topic.
   - @DT-DawidWroblewski suggested using [Mobile Connect IDY.02 specification](https://www.gsma.com/identity/wp-content/uploads/2022/11/IDY.02-v2.0.pdf) as a starting point to this discussion, as it implements CIBA with polling and notification functions.
   - @gregory1g mentioned that specific MSISDN lifecycle events, like MSISDN port-out from CSP should be taken into consideration while designing notification services - cancelling subscription on such an event
3. @psidana1983 asked about the Camara compliance topic: What if MNO decides to implement only a single endpoint from the API description?  @bigludo7 explained that it is fine to do so, although the other endpoint should get proper handling and give an error response (e.g. API unavailable)
 
### NumberVerification
1. NumberVerification API repo requires consolidation - @fernandopradocabrillo will create a PR with changes
2. @ecormac mentioned inconsistency in security/auth schemes in API definition OAUTH2.0 Authorization Code & OpenID Connect are used across the document - this should be fixed. 
3. @ecormac asked about the condition of NumberVerification API and if it is stable enough for developers to use. @DT-DawidWroblewski confirmed that resource definition is stable and can be used for resource exposure towards developers. However, today it is challenging to have a common service description towards developers due to multiple ways of doing Network Authentication across the MNO landscape.

### OTP Validation
1. Stable version - no issues or pending PRs
  
-----

## AoB


## APs
1. @fernandopradocabrillo Updates PR #52:
   - Update version number
   - undelete oauth2clientCredentials
2. @fernandopradocabrillo creates a dedicated PR for changes to security in yaml, according to commonalities work
3. @fernandopradocabrillo creates a PR for NumberVerification API that consolidates API information into yaml file and syncs with commonalities (similar to PR from SimSwap API)
4. @ecormac creates an issue with the authentication description issue inside the NumberVerification description