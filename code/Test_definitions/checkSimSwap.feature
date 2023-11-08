Feature: SIM Swap 0.4.0 - checkSimSwap

    check if SIM swap has been performed during a past period

    Background: An environment where Operator's API GW exposes checkSimSwap
        Given an environment with Operator's API GW
        And the endpoint "sim-swap/v0/check"
        And the method "post"
        And the request body is set to:
            """
            {
              "phoneNumber": "+346661113334"
            }
            """
        And the header "x-correlator" is set to "[UUIDv4]"


    # Common errors


    @checkSimSwap_E10.01
    Scenario: Error response for expired access token
        Given I want to test "checkSimSwap"
        And an expired access_token
        When I request "checkSimSwap"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @checkSimSwap_E10.02
    Scenario: Error response for invalid access token
        Given I want to test "checkSimSwap"
        And an invalid access_token
        When I request "checkSimSwap"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @checkSimSwap_E10.03
    Scenario: Error response for no header "Authorization"
        Given I want to test "checkSimSwap"
        And the header "Authorization" is not sent
        When I request "checkSimSwap"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    # API Specific Errors


    @checkSimSwap_E19.101_InvalidPhoneNumber
    Scenario: Check that the response shows an error when the phone number is invalid
        Given I want to test "checkSimSwap"
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to an invalid phone number
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @checkSimSwap_E19.102_NoPhoneNumber
    Scenario: Check that the response shows an error when the phone number is missing
        Given I want to test "checkSimSwap"
        And a valid access_token
        And the request body is set to:
            """
            {}
            """
        When I request "checkSimSwap"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @checkSimSwap_E19.103_UnknownPhoneNumber
    Scenario: Check that the response shows an error when the phone number does not belong to the Operator
        Given I want to test "checkSimSwap"
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number that does not belong to the Operator
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "404"
        And the API returns the error code "SIM_SWAP.UNKNOWN_PHONE_NUMBER"
        And the API returns a human readable error message


    # API Specific validations


    @checkSimSwap_30.101_ValidSimSwapNoMaxAge
    Scenario: Check that the response shows that the SIM has been swapped
        Given I want to test "checkSimSwap" for a user which have a phone number connected to the Operator's network and swapped in the last 240 hours
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number connected to the network that has been swapped in the last 240 hours
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "200"
        And the value of response property "$.swapped" == true


    @checkSimSwap_30.102_ValidSimSwapMaxAge
    Scenario Outline: Check that the response shows that the SIM has been swapped
        Given I want to test "checkSimSwap" for a user which have a phone number connected to the Operator's network and swapped in the last "<hours>" hours
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number connected to the network that has been swapped in the last "<hours>" hours, where "<hours>" is equal or less than provided "maxAge" request body parameter
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]",
              "maxAge": 260
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "200"
        And the value of response property "$.swapped" == true

        Examples:
            | hours |
            | 260   |
            | 120   |
            | 24    |
            | 12    |


    @checkSimSwap_30.103_MoreThan240Hours
    Scenario: Check that the response shows that the SIM has not been swapped when the last swap was more than 240 hours ago
        Given I want to test "checkSimSwap" for a user which have a phone number connected to the Operator's network and swapped more than 240 hours ago
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number connected to the network that has been swapped more than 240 hours ago
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "200"
        And the value of response property "$.swapped" == false


    @checkSimSwap_30.104_OutOfMaxAge
    Scenario: Check that the response shows that the SIM has not been swapped when the last swap was before the maxAge field
        Given I want to test "checkSimSwap" for a user which have a phone number connected to the Operator's network and swapped more than the maxAge field ago
        And a valid access_token
        And the variable "[CONTEXT: maxAge]" is set to the number of hours since the last SIM swap minus 1
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number connected to the network whose last SIM swap was more than "[CONTEXT: maxAge]" hours ago
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]",
              "maxAge": "[CONTEXT: maxAge]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "200"
        And the value of response property "$.swapped" == false


    @checkSimSwap_30.105_NoSimSwap
    Scenario: Check that the response shows that the SIM has not been swapped
        Given I want to test "checkSimSwap" for a user which have a SIM that has never been swapped
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number with a SIM that has never been swapped
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "checkSimSwap"
        Then the response status code is "200"
        And the value of response property "$.swapped" == false

