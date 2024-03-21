#
# Revision: 0

Feature: SIM Swap - retrieveSimSwapDate

    Get timestamp of last MSISDN <-> IMSI pairing change for a mobile user account provided with MSIDN.

    Background: An environment where Operator's API GW exposes retrieveSimSwapDate
        Given an environment with Operator's API GW
        And the endpoint "sim-swap/v0/retrieve-date"
        And the method "post"
        And the request body is set to:
            """
            {
              "phoneNumber": "+346661113334"
            }
            """
        And the header "x-correlator" is set to "[UUIDv4]"


    # Common errors


    @retrieveSimSwapDate_E10.01
    Scenario: Error response for expired access token
        Given I want to test "retrieveSimSwapDate"
        And an expired access_token
        When I request "retrieveSimSwapDate"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E10.02
    Scenario: Error response for invalid access token
        Given I want to test "retrieveSimSwapDate"
        And an invalid access_token
        When I request "retrieveSimSwapDate"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E10.03
    Scenario: Error response for no header "Authorization"
        Given I want to test "retrieveSimSwapDate"
        And the header "Authorization" is not sent
        When I request "retrieveSimSwapDate"
        Then the response status code is "401"
        And the API returns the error code "UNAUTHENTICATED"
        And the API returns a human readable error message


    # API Specific Errors


    @retrieveSimSwapDate_E19.101_InvalidPhoneNumber
    Scenario: Check that the response shows an error when the phone number is invalid
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to an invalid phone number
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E19.102_NoPhoneNumber
    Scenario: Check that the response shows an error when the phone number is missing
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the request body is set to:
            """
            {}
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "400"
        And the API returns the error code "INVALID_ARGUMENT"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E19.103_UnknownPhoneNumber
    Scenario: Check that the response shows an error when the phone number does not belong to the Operator
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number that does not belong to the Operator
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "404"
        And the API returns the error code "SIM_SWAP.UNKNOWN_PHONE_NUMBER"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E19.104_PhoneNumberProvidedDoesNotMatchTheAccessToken
    Scenario: Check that the response shows an error when phone number provided does not match the one in the access token
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the access token identifies the user
        And the access token contains a phone number from the user
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number that did not match the one encoded in the access token
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "403"
        And the API returns the error code "SIM_SWAP.INVALID_TOKEN_CONTEXT"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E19.105_PhoneNumberProvidedIsNotPresentInAccessToken
    Scenario: Check that the response shows an error when phone number provided is not present in the access token
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the access token identifies the user
        And the access token does not contain a phone number from the user
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number of the user
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "403"
        And the API returns the error code "SIM_SWAP.INVALID_TOKEN_CONTEXT"
        And the API returns a human readable error message


    @retrieveSimSwapDate_E19.106_PhoneNumberNotProvidedAndAccessTokenDoesNotContainPhoneNumber
    Scenario: Check that the response shows an error when phone number can not be deducted from access token and it is not provided in the request body
        Given I want to test "retrieveSimSwapDate"
        And a valid access_token
        And the access token identifies the user
        And the access token does not contain a phone number from the user
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number of the user
        And the request body is set to:
            """
            {
              "phoneNumber": ""
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "403"
        And the API returns the error code "SIM_SWAP.INVALID_TOKEN_CONTEXT"
        And the API returns a human readable error message


    # API Specific validations


    @retrieveSimSwapDate_30.101_ValidSimSwap
    Scenario: Check SIM swap date for a valid SIM swap
        Given I want to test "retrieveSimSwapDate" for a user which have a phone number connected to the Operator's network
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number connected to the network
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "200"
        And the response property "$.latestSimChange" is present


    @retrieveSimSwapDate_30.102_NoSimSwap
    Scenario: Check SIM swap date for a valid SIM swap
        Given I want to test "retrieveSimSwapDate" for a user which have a phone number never connected to the Operator's network
        And a valid access_token
        And the variable "[CONTEXT: phoneNumber]" is set to a phone number never connected to the network
        And the request body is set to:
            """
            {
              "phoneNumber": "[CONTEXT: phoneNumber]"
            }
            """
        When I request "retrieveSimSwapDate"
        Then the response status code is "200"
        And the response property "$.latestSimChange" is not present

