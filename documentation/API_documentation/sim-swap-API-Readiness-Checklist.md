# API Readiness Checklist

Checklist for sim-swap 2.0.0-rc.1 in r2.1

| Nr | API release assets  | alpha | release-candidate |  initial<br>public | stable<br> public | Status | Reference information |
|----|----------------------------------------------|:-----:|:-----------------:|:-------:|:------:|:----:|:----:|
|  1 | API definition                               |   M   |         M         |    M    |    M   |   Y  | [relative link](code/API_definitions/sim-swap.yaml) |
|  2 | Design guidelines from Commonalities applied |   O   |         M         |    M    |    M   |   Y  | [r2.2](https://github.com/camaraproject/Commonalities/releases/tag/r2.2) |
|  3 | Guidelines from ICM applied                  |   O   |         M         |    M    |    M   |   Y  | [r2.2](https://github.com/camaraproject/IdentityAndConsentManagement/releases/tag/r2.2) |
|  4 | API versioning convention applied            |   M   |         M         |    M    |    M   |   Y  |      |
|  5 | API documentation                            |   M   |         M         |    M    |    M   |   Y  | Embed documentation into API spec - [link](/code/API_definitions/sim-swap.yaml) |
|  6 | User stories                                 |   O   |         O         |    O    |    M   |   Y  | [check](/documentation/API_documentation/SIM-Swap_check_User_Story.md) [retrieve](/documentation/API_documentation/SIM-Swap_retrieve_User_Story.md) |
|  7 | Basic API test cases & documentation         |   O   |         M         |    M    |    M   |   Y  | [check](/code/Test_definitions/check-sim-swap.feature) [retrieve](/code/Test_definitions/retrieve-sim-swap-date.feature) |
|  8 | Enhanced API test cases & documentation      |   O   |         O         |    O    |    M   |   Y  | [check](/code/Test_definitions/check-sim-swap.feature) [retrieve](/code/Test_definitions/retrieve-sim-swap-date.feature) |
|  9 | Test result statement                        |   O   |         O         |    O    |    M   |   N  |      |
| 10 | API release numbering convention applied     |   M   |         M         |    M    |    M   |   Y  |      |
| 11 | Change log updated                           |   M   |         M         |    M    |    M   |   Y  | [relative link](/CHANGELOG.md) |
| 12 | Previous public release was certified        |   O   |         O         |    O    |    M   |   Y  | [relative link](https://www.open-gateway.gsma.com/operators-map)    |

(*) If you encounter issues with the provided test files (.feature), please create an issue in the API Sub-Project to signal these issues so they can be fixed in a patch release.

To fill the checklist:
- in the line above the table, replace the api-name, api-version and the rx.y by their actual values for the current API version and release.
- in the Status column, put "Y" (yes) if the release asset is available or fulfilled in the current release, a "N" (no) or a "tbd". Example use of "tbd" is in case an alpha or release-candidate API version does not yet provide all mandatory assets for the release.
- in the Reference information column, provide the relative links (from the API repository home folder) to the release asset once available, the applicable release numbers (not versions) of Commonalities and ICM, and any other relevant links or information.
- For the point 12: The Reference information comment shall reference a note (e.g. "see (1)") under the checklist table to be added that states the certified company(s) as can be found on the following link: [GSMA Open Gateway Portal](https://open-gateway.gsma.com/).

Note: the checklists of a public API version and of its preceding release-candidate API version can be the same.

The documentation for the content of the checklist is here: see API Readiness Checklist section in the [API Release Process](https://lf-camaraproject.atlassian.net/wiki/x/jine).