Feature: CAMARA SIM Swap API, 1.0.0 - Operation retrieveSimSwapDate

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specifies in sim_swap.yaml, version 1.0.0
  #
  # Get timestamp of last MSISDN <-> IMSI pairing change for the provided phone number.

  Background: Common retrieveSimSwapDate setup
    Given the resource "sim-swap/v1/retrieve-date"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

  # This first scenario serves as a minimum, not testing any specific verificationResult
  @retrieve_sim_swap_date_1_generic_success_scenario
  Scenario: Common validations for any sucess scenario
    Given a valid phone number identified by the token or provided in the request body
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SimSwapInfo"

  # Scenarios testing specific situations

  @retrieve_sim_swap_date_2_valid_sim_swap
  Scenario: Retrieve SIM swap date for a valid SIM swap
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" contains a valid timestamp

  # This scenario applies for operators which do not limit the "monitoring history"
  @retrieve_sim_swap_date_3_no_sim_swap_returns_activation_date
  Scenario: Response contains the sim's activation date when it hasn't been swapped
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has never been swapped
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" contains the sim's activation timestamp

  # This test applies if the operator allows to do the request for a phone number that hasn't been associated with a sim card yet
  @retrieve_sim_swap_date_4_sim_never_associated
  Scenario: Retrieves SIM swap date for a phone number that has never been associated with a sim card
    Given a valid phone number identified by the token or provided in the request body
    And the phone number is not associated to any sim card
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" is null

  # This scenario applies when there is a local regulation with a time limitation on the information that can be returned
  @retrieve_sim_swap_date_5_no_sim_swap_or_activation_date_due_to_legal_constrain
  Scenario: Retrieves SIM swap date for a valid SIM swap
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped before the limited history window threshold
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 200
    And the response property "$.latestSimChange" is null

  # Specific errors

  @retrieve_sim_swap_date_6_phone_number_not_supported
  Scenario: Error when the service is not supported for the provided phone number
    Given the request body property "$.phoneNumber" is set to a phone number for which the service is not available
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_7_phone_number_provided_does_not_match_the_token
  Scenario: Error when the phone number provided in the request body does not match the phone number asssociated with the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that does not match the one associated with the token
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_8_phone_number_not_provided_and_cannot_be_deducted_from_access_token
  Scenario: Error when phone number can not be deducted from access token and it is not provided in the request body
    Given the header "Authorization" is set to a valid access token from which the phone number cannot be deducted
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNIDENTIFIABLE_PHONE_NUMBER"
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
