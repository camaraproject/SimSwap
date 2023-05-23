<a href="https://github.com/camaraproject/SimSwap/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/SimSwap?style=plastic"></a>
<a href="https://github.com/camaraproject/SimSwap/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/SimSwap?style=plastic"></a>
<a href="https://github.com/camaraproject/SimSwap/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/SimSwap?style=plastic"></a>
<a href="https://github.com/camaraproject/SimSwap/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/SimSwap?style=plastic"></a>
<a href="https://github.com/camaraproject/SimSwap" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/SimSwap?style=plastic"></a>
<a href="https://github.com/camaraproject/SimSwap/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>

# SimSwap

Repository to describe, develop, document and test the SimSwap API family

## Scope

* Service APIs for “SimSwap” (see APIBacklog.md)  
* It provides the customer with the ability to:
  * Obtain information on any recent SIM pairing change related to a User’s mobile account. 
  * NOTE: SIM pairing change means MSISDN <-> IMSI pairing change. Each SIM card comes with a distinct IMSI num, where MSISDN stands for a user's phone number. Each time a user apply for a new SIM card, supposed that he lost his original one, then what happen is MSISDN stays the same while IMSI changes.
* Scenario:
  * Sim Swap delivers customer related data, that might help in general authentication. But is not just about SIM-based authentication. Currently, one scenario is, it can help on preventing fraud by reducing the risk of account take over fraud by strengthening SIM based authentication processes such as SMS One-time passwords. Fraudsters are using SIM Swap techniques to intercept SMS messages and reset passwords or receive verification codes that allow them to access protected accounts.
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: October 2022
* Location: virtually

## Meetings

* Meetings are held virtually in MS Teams
* Current schedule: bi-weekly
  * Thursday 8:30 AM CET
* Meeting links: Microsoft Teams Meeting
* [Click to join MS Teams](https://teams.microsoft.com/l/meetup-join/19%3ameeting_NzIxMmIzM2YtYTU3ZS00NDUwLTg0MTktZjExNmVlZjU3ZDA1%40thread.v2/0?context=%7b%22Tid%22%3a%22a1859c9b-6466-499c-adbc-ddbcb69c97dd%22%2c%22Oid%22%3a%227716fdb3-6a83-4680-90c5-a32f08253ae4%22%7d)
* For more information, click [Meetings information](documentation/MeetingMinutes/README.MD)

## Results and Status

* Sub Project is in progress
* Current Release: v0.3.0
  * API [definition](code/API_definitions)
  * API [documentation](documentation)
  * For changes see [CHANGELOG.md](CHANGELOG.md)

## Contributorship and mailing list

* To subscribe / unsubscribe to the mailing list of this Sub Project and thus be / resign as Contributor please visit <https://lists.camaraproject.org/g/sp-ssw>.
* A message to all Contributors of this Sub Project can be sent using <sp-ssw@lists.camaraproject.org>.
