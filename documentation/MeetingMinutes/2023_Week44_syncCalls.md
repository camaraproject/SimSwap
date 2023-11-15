# Week 44 meeting

## Participants

2nd November 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|Alexander Boraczynski|Vodafone|
|3|Klaus Reifenrath|Vodafone|
|4|FERNANDO PRADO CABRILLO|Telefonica|
|5|JORGE GARCIA HOSPITAL|Telefonica|
|6|Toshi Wakayama|KDDI|
|7|Gregory Liokumovich|Ericsson|
|8|Cormac Hegarty A|Ericsson|

## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
1. activation date discussion 

> Problem: should it be considered as a sim swap event? 

- makes sense for a multi-sim scenario, when the new sim is activated
- delivering a flag, that informs about using the activation date is an option, although adding new keys in the response body triggers work with Data Privacy, as this would be a new attribute returned in the API response
- this can be country-specific information, therefore might require additional description (inside yaml)
- AP @DT-DawidWroblewski creates a dedicated issue for this problem
2. value on "no event" scenario
- returning "error" should not be considered a good solution, as CSP performs a sim swap check

> Decision - use "null" value on an event of no sim change, delivered as a value

2. Notification subscription PR 
- work ongoing
- callback URL: should it be a part of developer onboarding?

### NumberVerification
1. Product naming
2. OpenID Connect vs OAUTH2.0
- OpenID Connect stays as a Camara preferred security scheme
- it means that */token* response contains tokens: **id_token** & **access_token**
- there is concern about the content of **id token sub value** - requires further discussion
- AP @fernandopradocabrillo - create a PR to fix the description in yaml


### OTP Validation

- no updates
  
-----

## AoB

1. No AoB

## APs
1. @DT-DawidWroblewski create a dedicated issue for a problem: should activation_date be considered as a sim swap event? 
2. @fernandopradocabrillo - create a PR to fix description in yaml regarding access_token