# Overview

<span class="colour" style="color:rgb(0, 0, 0)">The SIM Swap API provides programmable interface for developers and other users (capabilities consumers) to request last date of Sim Swap performed on the mobile line invoice, or, to ask for a check if a simswap has been performed during a delay. </span> 

## 1\. Introduction

The SIM Swap API performs real-time checks on the activation date of a SIM card on the mobile network. It reveals if an individual mobile phone number (msisdn) has been ported to another SIM card.

The SIM Swap API is useful to prevent fraud by reducing the risk of account takeover fraud by strengthening SIM based authentication processes such as SMS One-time passwords. Fraudsters are using Simswap techniques to intercept SMS messages and reset passwords or receive verification codes that allow them to access protected accounts.

The SIM Swap API is used by an application to get information about a mobile line latest simswap date. It can be easily integrated and used through this secured API and 
allows ISV to get this information an easy & secured way. The API provides management of 2 resources answering 2 distinct questions:<br>
- When last simswap occured ?
- Does a simswap occured during last n hours ?
<br>

Depending on the network provider implementation, legal enforcement, etc... either one or both resources could be implemented. 
<br>

__Note__: simswap is covered as well in Mobile Connect (MC) ATP (Account-Takeover-Protection) process. The MC pattern is exposed in another Camara API from the simswap API family. Network provided are free to implement the MC version, or this version, or both.


## 2\. Quick Start

The usage of the API is based on distinct resources.

Before starting to use the API, the developer needs to know about the below specified details:

**API service endpoint**

2 endpoints are defined in the SIM Swap API: <br>
- POST /<base-url>/simSwap/v0/retrieve-date : a msisdn is passed in the request, the last SIM swap date is provided in response
- POST /<base-url>/simSwap/v0/check : a msisdn and an age is passed in the request, a 'swapped' boolean is provided in response.

**Authentication**

Security access token based on three legged are described for this API with dedicated scope.<br> Security access keys such as OAuth 2.0 client credentials used by Client applications to invoke the simSwap API.

**Identifier for the the mobile line to be checked**

In order to identify the mobile line to be checked, a msisdn must be provided. 


Sample API invocations are presented in Section 4.6.

## 3\. Authentication and Authorization

The SIM Swap API could  make use of the OAUTH 2.0 client credentials grant which is applicable for server to server use cases involving trusted partners
or clients without any protected user data involved.
In this method the API invoker client is registered as a confidential client with an authorization grant type of client_credentials [[1]](#1).
The SIM Swap API could also be protected thru a 3-legged process in order to get end used consent before to provide information.
Depending on local legal regulation, Network provider may require the 3-legged process to provide simswap information.


## 4\. API Documentation

### 4.1 API Version

0.3.0

### 4.2 Details

#### 4.2.1 Endpoint Definition

Following table defines API endpoints of exposed REST based for SIM Swap API operations.

| **Endpoint** | **Operation** | **Description** |
| -------- | --------- | ----------- |
| POST<br>  \<base-url>/simSwap/v0/retrieve-date | **Request last SIM swap date** | Create request in order to get the latest SIM swap date |
| POST<br>  \<base-url>/simSwap/v0/check | **SIM Swap** | Create request to check if a SIM swap occurred during a defined period (like last 48hours) |


#### SIM Swap API Resource Operations:
<br>

| **Request last simswap date** |
| -------------------------- |
| **HTTP Request**<br> POST \<base-url>/simSwap/v0/retrieve-date<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> msisdn must be provided <br>**Request Body Parameters**<br> **msisdn**: Subscriber number in E.164 format (starting with country code). Optionally prefixed with '+'.

 <br>**Response**<br> **200: Contains information about sim swap change**<br>  Response body: <br>**latest_sim_change** : timestanp of latest SIM swap performed. <br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** |
<br>

<br>

| **SIM Swap** |
| -------------------------- |
| **HTTP Request**<br> POST \<base-url>/simSwap/v0/check<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> msisdn and age must be provided <br>**Request Body Parameters**<br> **msisdn**: Subscriber number in E.164 format (starting with country code). Optionally prefixed with '+'.<br> **max_age**: Delay in hours to be checked for simswap.

 <br>**Response**<br> **200: Contains information about SIM swap check**<br>  Response body: <br>**swapped** : Indicates whether the SIM card has been swapped during the delay. Should be valued only if an age is passed in the request. <br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** |
<br>
<br>
### 4.3 Errors

Since CAMARA SIM Swap API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).

Details of HTTP based error/exception codes for SIM Swap API are described in Section 4.2 of each API REST based method.
Following table provides an overview of common error names, codes, and messages applicable to SIM Swap API.

| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1	|400 |	INVALID_INPUT |	"Expected property is missing: msisdn" |
|2	|400 |	INVALID_INPUT |	"Expected property is missing: age" |
|10	|401 |	UNAUTHORIZED |	"No authorization to invoke operation" |
|11	|403 |	FORBIDDEN |	"Operation not allowed" |
|12	|404 |	NOT_FOUND |	"Payment Id does not exist" |
|13	|409 |	CONFLICT |	"Another payment is created for the same client correlator" |
|14	|500 |	INTERNAL |	"Payment could not be created" |
|15	|503 |	SERVICE_UNAVAILABLE |	"Service unavailable" |

<br>
### 4.4 Policies

N/A
<br>
### 4.5 Code Snippets
<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippets elaborates REST based API call with "*curl"* to request  </span>


Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 1. Request last simswap date  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/simSwap/v0/retrieve-date`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br>    -d '{ "msisdn": "+33068741256"}'  |
| response will be: <br> 201 <br>   -d '{ "latest_sim_change": "2020-10-11T13:33:26.618Z" }'|
<br>

| Snippet 2. Request last simswap date  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/simSwap/v0/check`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br>    -d '{ "msisdn": "+33068741256", <br> "max_age": 240}'  |
| response will be: <br> 201 <br>   -d '{ "swapped": "false" }'|
<br>



### 4.6 FAQ's

(FAQs will be added in a later version of the documentation)

### 4.7 Terms

N/A

### 4.8 Release Notes

N/A


## References


<a name="1">[1] [CAMARA Commonalities : Authentication and Authorization Concept for Service APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/Working/CAMARA-AuthN-AuthZ-Concept.md) <br>
<a name="2">[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes/) <br>