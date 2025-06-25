# Changelog CAMARA SimSwap

## Table of contents

- **[r3.1](#r31)**
- **[r2.2](#r22)**
- **[r2.1](#r21)**
- **[r1.3](#r13)**
- **[r1.2](#r12)**
- **[r1.1](#r11)**
- **[v0.4.0](#v040)**

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r3.1

This release contains the definition and documentation of
* sim-swap 2.1.0-rc.2
* sim-swap-subscriptions 0.3-rc.1

The API definition(s) are based on
* Commonalities v0.6.0-rc.1
* Identity and Consent Management v0.4.0-rc.1

## sim-swap 2.1.0-rc.2

**sim-swap v2.1.0-rc.2 is the first release candidate of the Sim Swap API v2.1.0**

*Note: the release candidate version is -rc.2 to avoid version collisions in the url path with the previous release candidate of v2, since both v2.0.0-rc.1 and v2.1.0-rc.1 would have the same number (v2rc1)

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r3.1/code/API_definitions/sim-swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r3.1/code/API_definitions/sim-swap.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r3.1/code/API_definitions/sim-swap.yaml)

### Added
* Add a documentation note when regulations prevent less than 100 days for check by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/213
* Documented Error Responses info.description section by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/221

### Changed
* Update x-correlator format by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/222

### Removed
* Remove AUTHENTICATION_REQUIRED error code by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/216


## Sim Swap Subscriptions v0.3.0-rc.1

**sim-swap-subscriptions v0.3.0-rc.1 is the first release candidate of the Sim Swap Subscriptions API v0.3.0**

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r3.1/code/API_definitions/sim-swap-subscriptions.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r3.1/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r3.1/code/API_definitions/sim-swap-subscriptions.yaml)

### Added
* [Sim-Swap-Subscriptions]: Add `type` and `format` for `startsAt` by @maxl2287 in https://github.com/camaraproject/SimSwap/pull/207
* [Sim-Swap-Subscriptions]: Add `subscriptionMaxEvents` as a config-property by @maxl2287 in https://github.com/camaraproject/SimSwap/pull/204

### Changed
* Update x-correlator format by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/222

### Removed
* [Sim-Swap-Subscriptions]: Remove `phoneNumber` from the required properties in the Swap-Event by @maxl2287 in https://github.com/camaraproject/SimSwap/pull/206
* [Sim-Swap-Subscriptions]: remove `SUBSCRIPTION_MISMATCH` error-code by @maxl2287 in https://github.com/camaraproject/SimSwap/pull/209
* Remove AUTHENTICATION_REQUIRED error code by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/216

### Fixed
* [Sim-Swap-Subscriptions]: Document that `subscription-ends` notification is also sent when deleted by requester by @maxl2287 in https://github.com/camaraproject/SimSwap/pull/205

## New Contributors
* @maxl2287 made their first contribution in https://github.com/camaraproject/SimSwap/pull/208

**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/r2.2...r3.2

# r2.2

## Release Notes

This release contains the definition and documentation of
* sim-swap 2.0.0
* sim-swap-subscriptions 0.2

The API definition(s) are based on
* Commonalities v0.5.0
* Identity and Consent Management v0.3.0


## sim-swap 2.0.0

**sim-swap 2.0.0 is the public release of the Sim Swap API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.2/code/API_definitions/sim-swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.2/code/API_definitions/sim-swap.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r2.2/code/API_definitions/sim-swap.yaml)

### Added
* Add management of monitoredPeriod in sim swap for retrieve-date operation by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/153
* Include pattern for x-correlator header by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/183
* Add 400 OUT_OF_RANGE error when the maxAge is above 2400 by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/189

### Changed
* Update sim-swap-check.feature by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/168
* Update test wording to avoid confusion with "activation" terminology by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/170
* Sim swap alignment with Commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/180

## Sim Swap Subscriptions v0.2.0

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r2.2/code/API_definitions/sim-swap-subscriptions.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.2/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.2/code/API_definitions/sim-swap-subscriptions.yaml)

### Added
* [Sim-Swap-Subscription]: Add TerminationReason SUBSCRIPTION_DELETED by @daniel-dierich in https://github.com/camaraproject/SimSwap/pull/177
* Include pattern for x-correlator header by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/183

### Changed
* Sim swap subscriptions alignment with Commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/179
* Align sim swap subscriptions with latest Commonalities by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/192

### Removed
* [sim-swap-subscriptions]: remove `allof` in `sinkcredential` by @dfischer-tech in https://github.com/camaraproject/SimSwap/pull/175

## New Contributors
* @dfischer-tech made their first contribution in https://github.com/camaraproject/SimSwap/pull/175

**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/r1.3...r2.2

# r2.1

## Release Notes

This release contains the definition and documentation of
* sim-swap 2.0.0-rc.1
* sim-swap-subscriptions 0.2-rc.1

The API definition(s) are based on
* Commonalities v0.5.0-rc.1
* Identity and Consent Management v0.3.0-rc.1


## sim-swap 2.0.0-rc.1

**sim-swap 2.0.0-rc.1 is the pre-release for v2.0.0 of the Sim Swap API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.1/code/API_definitions/sim-swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.1/code/API_definitions/sim-swap.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r2.1/code/API_definitions/sim-swap.yaml)

### Added
* Add management of monitoredPeriod in sim swap for retrieve-date operation by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/153
* Include pattern for x-correlator header by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/183

### Changed
* Update sim-swap-check.feature by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/168
* Update test wording to avoid confusion with "activation" terminology by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/170
* Sim swap alignment with Commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/180

## Sim Swap Subscriptions v0.2.0-rc.1

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r2.1/code/API_definitions/sim-swap-subscriptions.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.1/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r2.1/code/API_definitions/sim-swap-subscriptions.yaml)

### Added
* [Sim-Swap-Subscription]: Add TerminationReason SUBSCRIPTION_DELETED by @daniel-dierich in https://github.com/camaraproject/SimSwap/pull/177
* Include pattern for x-correlator header by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/183

### Changed
* Sim swap subscriptions alignement with commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/179

### Removed
* [sim-swap-subscriptions]: remove `allof` in `sinkcredential` by @dfischer-tech in https://github.com/camaraproject/SimSwap/pull/175

## New Contributors
* @dfischer-tech made their first contribution in https://github.com/camaraproject/SimSwap/pull/175

**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/r1.3...r2.1

# r1.3

## Release Notes

This release contains the definition and documentation of
* sim-swap 1.0.0
* sim-swap-subscriptions 0.1.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## sim-swap 1.0.0

**sim-swap 1.0.0 is the public release for v1.0.0 of the Sim Swap API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.3/code/API_definitions/sim-swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.3/code/API_definitions/sim-swap.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.3/code/API_definitions/sim-swap.yaml)

**Main Changes**
* This release only contains and update for the test plan to cover scenarios where no sim swap occurred

### Fixed
* Update test plan by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/159

## Sim Swap Subscriptions v0.1.1

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.3/code/API_definitions/sim-swap-subscriptions.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.3/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
    - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.3/code/API_definitions/sim-swap-subscriptions.yaml)

**Main Changes**
* Fixed an schema reference that prevented the `createSimSwapSubscription` operation callback request body to render properly

### Fixed
* Add EventSimSwap to Sim Swap Subscriptions by @daniel-dierich in https://github.com/camaraproject/SimSwap/pull/157

## New Contributors
* @daniel-dierich made their first contribution in https://github.com/camaraproject/SimSwap/pull/157

**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/r1.2...r1.3

# r1.2

## Release Notes

This release contains the definition and documentation of
* sim-swap 1.0.0
* sim-swap-subscriptions 0.1.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## sim-swap 1.0.0

**sim-swap 1.0.0 is the public release for v1.0.0 of the Sim Swap API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.2/code/API_definitions/sim-swap.yaml)

**Main Changes**
* API and test definitions updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release
* Additional documentation & test cases added.


### Added
* User Story in documentation/API_documentation directory by @jgarciahospital [PR125](https://github.com/camaraproject/SimSwap/pull/125)
* Test Definition in Test_Definitions directory by @fernandopradocabrillo [PR70](https://github.com/camaraproject/SimSwap/pull/70)
* Added the API name `sim-swap` as a scope to request access to both available endpoints by @AxelNennker in https://github.com/camaraproject/SimSwap/pull/103

### Changed
* Made response properties `latestSimChange` and `swapped` required since they will always be returned by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/97
* Updated pattern to make the '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/100
* Replaced "MSISDN" with "phone number" in descriptions to follow Commonalities guidelines by @gregory1g in https://github.com/camaraproject/SimSwap/pull/116
* Removed unused errors and align with Commonalities error definitions by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/126

### Fixed
* N/A

### Removed
* N/A

## New Contributors
* N/A

## Sim Swap Subscriptions v0.1.0

**sim-swap-subscriptions v0.1.0 is the first initial version for the CAMARA Sim Swap Subscriptions API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.2/code/API_definitions/sim-swap-subscriptions.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
    - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap-subscriptions.yaml)
 
**Main Changes**
* Initial contribution of the API definition for Sim Swap Subscriptions allowing API consumers to subscribe to get notified when a sim swap occurs on a device.
* API and test definitions updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release
* Test cases added.

### Added
* Initial yaml contribution by @bigludo7 [PR60](https://github.com/camaraproject/SimSwap/pull/60)
* Test Definition in Test_Definitions directory by @bigludo7 [PR147](https://github.com/camaraproject/SimSwap/pull/147)

### Changed
* N/A

### Fixed
* N/A

### Removed
* N/A

## New Contributors
* N/A

**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/v0.4.0...r1.2

# r1.1

## Release Notes

This release contains the definition and documentation of
* Sim Swap API 1.0.0-rc.1
* Sim Swap Subscriptions v0.1.0-alpha.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## Sim Swap v1.0.0-rc.1

**sim-swap 1.0.0-rc.1 is the first release-candidate version for the v1.0.0 of the Sim Swap API**
This version contains significant changes compared to v0.4.0, and it is not backward compatible.

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim_swap.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim_swap.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim_swap.yaml)

### Added
* User Story in documentation/API_documentation directory by @jgarciahospital [PR125](https://github.com/camaraproject/SimSwap/pull/125)
* Test Definition in Test_Definitions directory by @fernandopradocabrillo [PR70](https://github.com/camaraproject/SimSwap/pull/70)
* add API-Name aka wild-card scope by @AxelNennker in https://github.com/camaraproject/SimSwap/pull/103

### Changed
* Make response properties "latestSimChange" and "swapped" required since they will always be returned [Issue 96](https://github.com/camaraproject/SimSwap/issues/96)
* Updated pattern to make the '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/100
* phone number instead of MSISDN to follow communalities guidelines by @gregory1g in https://github.com/camaraproject/SimSwap/pull/116
* Remove unused errors and align with commonalities errors by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/126

### Removed

* n/a

## Sim Swap Subscriptions v0.1.0-alpha.1

**sim-swap-subscriptions v0.1.0-alpha.1 is the first alpha version for CAMARA Sim Swap subscription API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim-swap-subscriptions.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
    - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim-swap-subscriptions.yaml)

## Please note:

- There are bug fixes to be expected and incompatible changes in upcoming versions 
- The API version is suitable for test implementations and has the purpose to collect feedback for its further development. It should not be used with customers in productive environments.

### Added

* Add a new API to manage sim swap notification subscription & notification. by @bigludo7 [PR60](https://github.com/camaraproject/SimSwap/pull/60)
* Add subscriptionMaxEvents for maximum number of SIMSwap notifications by  @bigludo7 [PR91](https://github.com/camaraproject/SimSwap/pull/91)
* Update SIM Swap notification subscription yaml to make the '+' mandatory for phoneNumber by @bigludo7 in [PR100](https://github.com/camaraproject/SimSwap/pull/100)
* align subscription model accordingly to the new format defined in Commonalities. This format is aligned with CloudEvents. Fixes examples for phoneNumber by @bigludo7 in [PR111](https://github.com/camaraproject/SimSwap/pull/111)

### Changed

* n/a

### Removed

* n/a

## New Contributors

* @trehman-gsma made their first contribution in https://github.com/camaraproject/SimSwap/pull/62
* @gregory1g made their first contribution in https://github.com/camaraproject/SimSwap/pull/82
* @rartych made their first contribution in https://github.com/camaraproject/SimSwap/pull/110
* @AxelNennker made their first contribution in https://github.com/camaraproject/SimSwap/pull/103


**Full Changelog**: https://github.com/camaraproject/SimSwap/compare/v0.4.0...r1.1

# v0.4.0

**This is the first alpha release of the CAMARA SimSwap API**

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/release-0.4.0/code/API_definitions/sim_swap.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/v0.4.0/code/API_definitions/sim_swap.yaml&nocors) 
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/v0.4.0/code/API_definitions/sim_swap.yaml)

## Please note:

- This is an alpha version, there are bug fixes to be expected and incompatible changes in upcoming versions 
- The release is suitable for implementors, but it is not recommended to use the API with customers in productive environments
- Version numbers before v0.4.0 were used during the development of this version but not released

## What's New

* SimSwap OAS with 2 endpoints (check & get date) by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/7
* Added API documentation for the 2-endpoints SIM Swap API by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/9
* Reshaping the content (+readme.md update) by @DT-DawidWroblewski in https://github.com/camaraproject/SimSwap/pull/13
* Update README.MD by @jlurien in https://github.com/camaraproject/SimSwap/pull/17
* Guidelines alignment regarding errors and camel case by @monamok in https://github.com/camaraproject/SimSwap/pull/20
* Glossary alignment by @monamok in https://github.com/camaraproject/SimSwap/pull/40
* Cleaning up repo by @DT-DawidWroblewski in https://github.com/camaraproject/SimSwap/pull/48
* Created a release branch release-0.4.0 based on [commit 6843563](https://github.com/camaraproject/SimSwap/commit/6843563242709cc82c6d5ea3cd6d484f14e44bfe)
* Fixed the security schema as agreed to three-legged only within the release branch
* Created CHANGELOG.md and updated README.md within the release branch

## New Contributors
* @monamok made their first contribution in https://github.com/camaraproject/SimSwap/pull/3
* @DT-DawidWroblewski made their first contribution in https://github.com/camaraproject/SimSwap/pull/8
* @bigludo7 made their first contribution in https://github.com/camaraproject/SimSwap/pull/7
* @jlurien made their first contribution in https://github.com/camaraproject/SimSwap/pull/17
* @fernandopradocabrillo made their first contribution in https://github.com/camaraproject/SimSwap/pull/46

**Full Changelog**: https://github.com/camaraproject/SimSwap/commits/v0.4.0
