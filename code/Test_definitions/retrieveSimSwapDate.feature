Feature: CAMARA SIM Swap API, 0.5.0 - Operation retrieveSimSwapDate

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specifies in sim_swap.yaml, version 0.5.0

  Get timestamp of last MSISDN <-> IMSI pairing change for a mobile user account provided with MSIDN.

  Background: Common retrieveSimSwapDate setup
    Given the resource "sim-swap/v0/retrieve-date"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

  # This first scenario serves as a minimum, not testing any specific verificationResult
  @retrieve_sim_swap_date_1_generic_success_scenario
  Scenario: Common validations for any sucess scenario
    Given the request body property "$.phoneNumber" is set to a valid testing phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SimSwapInfo"


  # Scenarios testing specific situations

  @retrieve_sim_swap_date_2_valid_sim_swap
  Scenario: Check SIM swap date for a valid SIM swap
    Given the request body property "$.phoneNumber" is set to a phone number connected to the Operator's network
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" contains a valid timestamp

  @retrieve_sim_swap_date_3_no_sim_swap_returns_activation_date
  Scenario: Response contains the sim's activation date when it hasn't been swapped
    Given the request body property "$.phoneNumber" is set to a phone number connected to the Operator's network whose sim has never been swapped
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" contains the sim's activation timestamp

  # This test applies if the operator allows to do the request for a sim that has never been connected to the network
  @retrieve_sim_swap_date_4_sim_not_activated
  Scenario: Check SIM swap date for a non-activated sim
    Given the request body property "$.phoneNumber" is set to a phone number never connected to the Operator's network
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" is null

  # This scenario applies when there is a local regulation with a time limitation on the information that can be returned
  @retrieve_sim_swap_date_5_no_sim_swap_or_activation_date_due_to_legal_constrain
  Scenario: Check SIM swap date for a valid SIM swap
    Given the request body property "$.phoneNumber" is set to a valid testing phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" is null

  # Specific errors

  @retrieve_sim_swap_date_6_unknown_phone_number
  Scenario: Check that the response shows an error when the phone number does not belong to the Operator
    Given the request body property "$.phoneNumber" is set to a phone number that does not belong to the Operator
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "SIM_SWAP.UNKNOWN_PHONE_NUMBER"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_7_phone_number_provided_does_not_belong_to_the_user
  Scenario: Error when provided phone number does not belong to the user
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that does not belong to the user
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_8_phone_number_provided_does_not_match_the_token
  Scenario: Error when the phone number provided in the request body belongs to the user but does not match the phone number asssociated with the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that belongs to the user but does not match the one associated with the token
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_9_phone_number_provided_cannot_be_deducted_from_access_token
  Scenario: Error when the phone number is provided in the request body but cannot be deducted from the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber of the user
    And the header "Authorization" is set to a valid access token from which the phone number cannot be deduced
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_10_phone_number_not_provided_and_cannot_be_deducted_from_access_token
  Scenario: Error when phone number can not be deducted from access token and it is not provided in the request body
    Given the header "Authorization" is set to a valid access token from which the phone number cannot be deduced
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_11_phone_number_conflict
  Scenario: Check that the response shows an error when another request is created for the same phoneNumber
    Given the request body property "$.phoneNumber" is set to a valid testing phone number
    And the header "Authorization" is set to a valid access token emitted
    And another request is created for the same phoneNumber
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is "409"
    And the response property "$.status" is 409
    And the response property "$.code" is "CONFLICT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @retrieve_sim_swap_date_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 400 errors

  @retrieve_sim_swap_date_4_invalid_phone_number
  Scenario: Check that the response shows an error when the phone number is invalid
    Given the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
