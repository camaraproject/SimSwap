# Changelog CAMARA SimSwap

## Table of Contents

- [r1.1](#r11)
- [v0.4.0](#v040)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

# r1.1 - rc

## Release Notes

This release contains the definition and documentation of
* Sim Swap API 1.0.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

# Sim Swap v1.0.0-rc.1

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim_swap.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim_swap.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/blob/r1.1/code/API_definitions/sim_swap.yaml)

**sim-swap 1.0.0-rc.1 is the first stable version for CAMARA Sim Swap API**

This version contains significant changes compared to v0.4.0, and it is not backward compatible.

### Added

* User Story in documentation/API_documentation directory by @jgarciahospital [PR125](https://github.com/camaraproject/SimSwap/pull/125)
* Test Definition in Test_Definitions directory by @fernandopradocabrillo [PR70](https://github.com/camaraproject/SimSwap/pull/70)
* add API-Name aka wild-card scope by @AxelNennker in https://github.com/camaraproject/SimSwap/pull/103

### Changed
* Make response properties "latestSimChange" and "swapped" required since they will always be returned [Issue 96](https://github.com/camaraproject/SimSwap/issues/96)
* Update SIM Swap & SIM Swap notification subscription yaml to make the '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/100
* Add README file to indicate shift to Confluence page by @bigludo7 in https://github.com/camaraproject/SimSwap/pull/101
* phone number instead of MSISDN to follow communalities guidelines by @gregory1g in https://github.com/camaraproject/SimSwap/pull/116
* Remove unused errors and align with commonalities errors by @fernandopradocabrillo in https://github.com/camaraproject/SimSwap/pull/126

### Removed

* n/a

## New Contributors

* @trehman-gsma made their first contribution in https://github.com/camaraproject/SimSwap/pull/62
* @gregory1g made their first contribution in https://github.com/camaraproject/SimSwap/pull/82
* @rartych made their first contribution in https://github.com/camaraproject/SimSwap/pull/110
* @AxelNennker made their first contribution in https://github.com/camaraproject/SimSwap/pull/103

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
