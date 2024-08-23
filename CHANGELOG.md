# Changelog CAMARA SimSwap

## Table of contents

- **[r1.2](#r12)**
- **[r1.1](#r11)**
- **[v0.4.0](#v040)**

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for each first alpha or release-candidate API version, all changes since the release of the previous public API version
* for subsequent alpha or release-candidate API versions, the delta with respect to the previous pre-release
* for a public API version, the consolidated changes since the release of the previous public API version

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
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swaps.yaml)
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

**sim-swap-subscriptions v0.1.0 is the first initial version for CAMARA Sim Swap subscription API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.2/code/API_definitions/sim-swap-subscriptions.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.2/code/API_definitions/sim-swap-subscriptions.yaml)
 
**Main Changes**
* Initial contribution of the API definition for sim swap subscription allowing API consumer to subscribe to get notified when a sim swap occurs on a device.
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
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim_swap.yaml)

### Added
* User Story in documentation/API_documentation directory by @jgarciahospital [PR125](https://github.com/camaraproject/SimSwap/pull/125)
* Test Definition in Test_Definitions directory by @fernandopradocabrillo [PR70](https://github.com/camaraproject/SimSwap/pull/70)
* add API-Name aka wild-card scope by @AxelNennker in https://github.com/camaraproject/SimSwap/pull/103

### Changed
* Make response properties "latestSimChange" and "swapped" required since they will always be returned [Issue 96](https://github.com/camaraproject/SimSwap/issues/96)
* Update yaml to make the '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/100
* phone number instead of MSISDN to follow communalities guidelines by @gregory1g in https://github.com/camaraproject/SimSwap/pull/116
* Remove unused errors and align with commonalities errors by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/126

### Removed

* n/a

## Sim Swap Subscriptions v0.1.0-alpha.1

**sim-swap-subscriptions v0.1.0-alpha.1 is the first alpha version for CAMARA Sim Swap subscription API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim-swap-subscriptions.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim-swap-subscriptions.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/r1.1/code/API_definitions/sim-swap-subscriptions.yaml)

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
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/v0.4.0/code/API_definitions/sim_swap.yaml)

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
