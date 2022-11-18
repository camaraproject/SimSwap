# API Reference

CAMARA Sim Swap is based on Mobile Connect Account Takeover Protection (ATP) standardized product:

[IDY.26 Mobile Connect Account Takeover Protection Definition and Technical Requirements](assets/docs/(placeholder4MCspec).docx)
[IDY.56 Mobile Connect Client Credentials Profile](assets/docs/(placeholder4MCspec).docx)
[IDY.56-1 Mobile Connect Client Credentials Profile for Attributes](assets/docs/(placeholder4MCspec).docx)
[OAUTH2.0 - Client Credentials Grant](https://www.rfc-editor.org/rfc/rfc6749#section-4.4)

## About Mobile Connect

Mobile Connect is a worldwide initiative by Mobile Operators to bring a wide portfolio of Identity services to market that enable SPs and End-Users to transact with one-another more securely through strong authentication, authorisation and exchange of attributes, subject to User consent.

The Mobile Connect architecture consists of a Core framework around which additional components can be added to support the different Mobile Connect services as well as other API based services that delivers value to the customer. The Core framework is based upon the OpenID Connect (OIDC) protocol suite and allows Users to be identified by their MSISDN (or a related Pseudonymous Customer Reference) to enable authentication on their mobile device. Attributes sharing services are based upon the OAUTH2.0 framework - Client Credentials grant.

## Sim Swap / Account Takeover Protection definition

Mobile Connect ATP allows Service Providers (SP) to check attributes associated with a User’s mobile account to provide a secure method of combatting identity fraud.
Many online banking accounts today are protected using secure online banking credentials (e.g., password and secret customer number), and additionally using the phone number associated with the User’s bank account to increase security. This two-factor security helps mitigate fraud if one of the factors is compromised, for example if the User’s online banking credentials have been stolen.
Mobile Connect ATP allows SPs to perform additional checks on the User’s mobile phone status to determine whether or not this factor may have been compromised.  In particular, the service returns an indication of whether there has been a recent SIM swap and may optionally return other information relating to the User’s mobile account:

- Recent SIM change (MSISDN - IMSI pairing) - REQUIRED
- Active unconditional call diverts - OPTIONAL
- Device reported lost or stolen - OPTIONAL
- Recent device change (Timestamp of last MSISDN - IMEI pairing change) - OPTIONAL
- Mobile phone account status (active or inactive) – OPTIONAL

## Use Case examples

Mobile Connect ATP offers a range of practical use cases. Some of the use cases identified for implementation are listed in the table below:

1. Prevention of various types of fraud in banking such as SIM swap fraud
2. Making SMS one-time passwords more secure
3. Secure authentication (authenticate + ATP)
4. Securing add new payee transactions in banking 

## ATP Functional Description

In specific use cases, the SP (Service Provider) server needs to have access to a Resource Server with an access token not tied to the User. This must be done by using the Client Credentials grant (OAuth2.0). In other words, the Client Credentials grant type is used by an SP to obtain an access token outside of the context of a user.

### ATP Service Flow

**Figure 1** illustrates the Client Credential mode flow. This specification details the parameters involved in the Access Token Request and Response.

![Figure 1 - Mobile Connect Client Credentials Mode Flow](assets/images/figure1cc.png)

The high level flow is as follows:

- The SP needs an Access Token not tied to the user for a specific use case. This assumes that the SP is already registered with Mobile Connect.
- The SP sends an Access Token request to the ID GW (Authorization Server) with a grant type “client_credentials” and optional scope(s) (representing the resource(s) requested).
- The ID GW authenticates the SP using its client credentials. If the request is valid, the ID GW sends an Access Token for the scope(s).
- Where requested, the SP can then call the relevant resource endpoint (*/userInfo*) by submitting the received Access Token to retrieve the requested attributes/claims (not shown in Figure 1).

### User Consent Management

The use of Client Credentials profile implies that personal data are not involved in the exchanges between the SP and the Resource Server unless:

1. the service logic and the lawful data processing basis allow it.
2. the SP and the Operator agree that the Operator is not involved in the customer consent management (**i.e.: legitimate interest and/or consent managed exclusively on Service Provider side**).

## ATP Service Specification

### OAUTH Token Request Parameters

|Parameter|Usage Category|Description|
|:---|:---:|:---|
|grant_type|REQUIRED|Value MUST be set to “client_credentials”.|
|scope|REQUIRED|The scope of the access request as described in Section 3.3 of the OAuth2.0 specification. For ATP scope value is: **"mc_atp"**|

**Table 1 - Mobile Connect ATP Client Credentials request parameters**

### Resource Request

Folllwing mechanism is defined to indicate the MC User whose data is being queried in the request. Namely, the following HTTP headers MUST be used for that purpose:

|HTTP Header|Usage Category|Description|
|:---|:---|:---|
|User-ID-Type|REQUIRED [if the bearer type access token provided in the request is generic]|MC User identification type used in the User-ID header. One of these values MUST be used: <ul><li>**MSISDN**: Indicates the User-ID contains a plain MSISDN in international format according to ITU-T recommendation E.164. The plus sign (+) MUST NOT be included as a prefix.</li><li> **ENCR_MSISDN**: Indicates the User-ID contains an encrypted MSISDN. Support for the MSISDN user ID type is REQUIRED, whereas for ENCR_MSISDN is OPTIONAL.</li><ul>|
|User-ID|REQUIRED [if the bearer type access token provided in the request is generic]|MC User identification value as per the type indicated in the HTTP header above.|

Both the names and the values of these HTTP headers MUST be treated as case insensitive.

### ATP API details

YAML proposal:

1. [DT](../../code/API_code/simSwap.yaml)
2. [Orange](../../code/API_code/checkSimSwap-v0.3.0.camara.swagger.yaml)

#### Token Request

>POST /token?grant_type=client_credentials&scope=mc_atp HTTP/1.1
Content-Type: application/x-www-form-urlencoded; charset=ISO-8859-1
Authorization: Basic {client_id:client_secret}
Host: mobileconnect.telekom.de
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 0

#### Token Response

>HTTP/1.1 200 OK
Date: Fri, 18 Nov 2022 08:01:19 GMT
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Cache-Control: no-store
Pragma: no-cache
Strict-Transport-Security: max-age=15724800; includeSubDomains
{"access_token":"{AccessToken}","scope":"mc_atp","token_type":"Bearer","expires_in":"500"}

#### Resource Request

>POST /openid/userinfo HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Authorization: Bearer {AccessToken}
User-ID-Type: msisdn
User-ID: {msisdn}
Host: mobileconnect.telekom.de
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 0

#### Resource Response

- Boolean
>{
    "simChange":"false"
    "correlation_id":"6d9d6d48-b01b-4460-a9f0-d696bcdfeb95"
}
- Date
>{
    "simChange": "2020-07-13",
    "correlation_id": "59c82672-107b-4019-b469-169bf955d8f1"
}
- Timestamp
>{
    "simChange": "2019-10-18T00:00:00",
    "correlation_id": "11e75083-9f82-4732-9b8d-fd37539f7e6b"
}