Feature: CAMARA SIM Swap API, v2.1.0 - Operation retrieveSimSwapDate

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specified in sim_swap.yaml
  #
  # Get timestamp of last MSISDN <-> IMSI pairing change for the provided phone number.

  Background: Common retrieveSimSwapDate setup
    Given the resource "/sim-swap/v2/retrieve-date"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # This first scenario serves as a minimum, not testing any specific verificationResult
  @retrieve_sim_swap_date_1_generic_success_scenario
  Scenario: Common validations for any success scenario
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
    And the response optionally contains the property "$.monitoredPeriod" with the value of monitored time frame (in days) supported by the MNO

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
  # alternative to scenario @retrieve_sim_swap_date_401.4_expired_access_token
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

    # Error scenarios for management of input parameter phoneNumber

  @retrieve_sim_swap_date_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And  the request body property "$.phoneNumber" is set to a valid phone number
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @retrieve_sim_swap_date_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
  @retrieve_sim_swap_date_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "retrieveSimSwapDate" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text
