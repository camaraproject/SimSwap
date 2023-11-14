# Changelog CAMARA SimSwap

## Table of Contents

- [v0.4.0](#v040)

# v0.4.0

**This is the first alpha release of the CAMARA SimSwap API**

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SimSwap/blob/release-0.4.0/code/API_definitions/sim_swap.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/v0.4.0/code/API_definitions/sim_swap.yaml&nocors) 
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/SimSwap/v0.4.0/code/API_definitions/sim_swap.yaml)

## Please note:

- This is an alpha version, it should be considered as a draft
- There are bug fixes to be expected and incompatible changes in upcoming versions 
- The release is suitable for implementors, but it is not recommended to use the API with customers in productive environments
- Version numbers before v0.4.0 were used during the development of this version but not released
- [GSMA Mobile Connect Account Takeover Protection specification](https://www.gsma.com/identity/wp-content/uploads/2022/12/IDY.24-Mobile-Connect-Account-Takeover-Protection-Definition-and-Technical-Requirements-v2.0.pdf) was used as source of input for this API. For more about Mobile Connect, please see [Mobile Connect website](https://mobileconnect.io/).

## What's Changed

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
