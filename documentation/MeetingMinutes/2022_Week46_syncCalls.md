#Participants


**Week 46**

15 November 2022:
|No|Name|Company|
|:---:|:---|:---:|
|1|Garreth Williams|GSMA|
|2|Mona Mokhber|Telefonica|
|3|José Luis Urien Pinedo|Telefonica|
|4|Ludovic Robert|Orange|
|5|Dawid Wróblewski|DT|

17 November 2022:
|No|Name|Company|
|:---:|:---|:---:|
|1|Maria Virtudes Briz Ruiz|Telefonica|
|2|Jung Yun-sun (Serena)|SK Telecom|
|3|Toshi Wakayama|KDDI|
|4|Harin Honesyandi Parandika|XL Indonesia|
|5|Heny Setywan|XL Indonesia|
|6|Dawid Wróblewski|DT|


#Agenda
1. progress of work
2. backlog items (grooming)
3. priorities for items
4. AOB

#MoM

1. Dawid Wroblewski (DW) presented information about Mobile Connect API services that are commercially available and CAMARA is willing to adopt them:
   1. **Mobile Connect Verified MSISDN** as *Number Verify*
   2. **Mobile Connect Authenticate with SMS OTP** as *Number Verify SMS 2FA*
   3. **Mobile Connect Account Takeover Protection** as *SimSwap*

2. DW mentioned about off-line discussion between Orange and DT regarding Sim Swap API:
   1. there are two different ideas how to handle API result
      - sim swap timestamp
      - boolean (Yes/No) i a given period (checks if sim swap was present in e.g. last 24h)

   2. additionally, there are two different API design patterns on a table:
      - API logic triggered by a dedicated "scope" value inside OAUTH2.0 Token Request - Mobile Connect like
      - API logic triggered by a dedicated URL path
   3. DW took action to rise an issue inside Commonalities Working Group to discuss this topic and shape the final design of CAMARA APIs
   
    [Issue #105](https://github.com/camaraproject/WorkingGroups/issues/105)

3. Maria Virtudes Briz Ruiz (MVBR) mentioned that Telefonica (TEF) has sim swap API commercially available based on Mobile Connect API. Addition that TEF wants to make is to expose additional sim Swap flavour - boolean.
4. Toshi Wakayama (TW) asked if it is mandatory to deploy whole Mobile Connect platform to serve Mobile Connect services - DW response that it is not required. Mobile Connect defines the way that APIs are consumed nortbound (by developer/SP), but gives freedom to MNO how it is depoyed internaly (only gives some hints/recommendations about how to handle processes).
5. DW claimed that Number Verify service cannot be handled by a single endpoint - this requires a dedicated flow due to the fact that MSISDN discovery is handled by MNOs in a varioius ways, e.g. Header Enrichment, Token Servers, Dedicated OAUTH platforms, EAP-AKA, etc.
6. Participants agree that it is critical to have a common approach to API design pattern to progress with firther API services design.
