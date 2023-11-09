# Week 26 meeting

## Participants

29th June 2023:
|No|Name|Company|
|:---:|:---|:---:|
|1|Dawid Wróblewski **(organizer)**|DT|
|2|MONA MOKHBER|Telefonica|
|3|JORGE GARCIA HOSPITAL|Telefonica|
|4|Klaus Reifenrath|Vodafone|
|5|Ludovic ROBERT|Orange|
|6|Toshi (Toshiyasu) Wakayama|KDDI|
|7|Cormac Hegarty A|Ericsson|
|8|Gregory Liokumovich|Ericsson|
|9|Sajith Nedunmullage|IBEM|
|10|Gareth Williams|GSMA|


## Agenda

1. Present information about actual work inside API repos.
2. AoB

## MoM

### Sim Swap
- disussion to introduce new idea to SIM swap repo, to deliver sim swap event as a stream. This idea shall be discussed further.
 
### NumberVerification
- merged PR regarding text of API description
- discussion about issue #33 - versioning

### OTP Validation
- discussion about having 3-legged-token within the API flow
  
-----

## AoB
- @bigludo7 gave a briefing from OPG/OPAG meeting in London
- 

## APs
1. AP @DT-DawidWroblewski => prepare a text that shall be used as a reference to Mobile Connect standard within Camara APIs, according to discussion inside #200. @monamok suggested to have 2 PRs for this activity:
   1. for deleting two flavors and leaving one (CAMARA) for avoiding confusion inside Camara repositories
   2. for adding reference text
2. AP @DT-DawidWroblewski create a release for NumberVerify API from commit "db1665"