# SIM swap API documentation

## Overview

### Introduction

CAMARA Sim Swap API aims to deliver information about last SIM change event to prevent Account Takeover fraud. This API derives from the GSMA Mobile Connect Account Takeover Protection specification [Mobile Connect Account Takeover Protection](https://www.gsma.com/identity/wp-content/uploads/2022/12/IDY.24-Mobile-Connect-Account-Takeover-Protection-Definition-and-Technical-Requirements-v2.0.pdf).  For more about Mobile Connect, please see [about Mobile Connect](https://mobileconnect.io/).

### Quick start

1. Download the yaml file.
2. Contact CAMARA API maintainers to get guidance on the onboarding process:

   * [Deutsche Telekom - Dawid Wróblewski](https://github.com/DT-DawidWroblewski)
   * [Telefonica - José Luis Urien](https://github.com/jlurien)
   * [Orange - Ludovic Robert](https://github.com/bigludo7)

### Details

[DetailsPage](../../documentation/API_documentation/CAMARA/Check_sim_swap_API.md)


### Endpoint definitions


|Flavour|Endpoint type|Endpoint path|
|---|---|---|
|CAMARA|AuthN/AuthZ||
||resource|/retrieve-date<br>/check|

### Errors

Described inside yaml files.

### Release Notes

|No|Version|Changelog|
|:---:|---:|:---|
|1|0.5.0|Camara & Mobile Connect flavours available|
|2|0.6.0|Camara only version<br>(Mobile Connect archived)|

## API Spec
[API definition (code)](../../code/API_definitions/code/API_definitions/checkSimSwap.camara.swagger.yaml)

