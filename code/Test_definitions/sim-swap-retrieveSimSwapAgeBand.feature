Feature: CAMARA SIM Swap API, vwip - Operation retrieveSimSwapAgeBand

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specified in sim_swap.yaml
  #
  # Retrieve SIM swap age band

  Background: Common retrieveSimSwapAgeBand setup
    Given the resource "/sim-swap/vwip/retrieve-age-band"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # This first scenario serves as a minimum, not testing any specific age band value
  @retrieve_age_band_1_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given a valid phone number identified by the token or provided in the request body
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SimSwapAgeBandInfo"

  # Scenarios testing specific age band values

  @retrieve_age_band_2_recent_swap_band_1
  Scenario: Retrieve age band showing recent SIM swap (band 1)
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped in the last 4 hours
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the value of response property "$.simSwapAgeBand" == 1

  @retrieve_age_band_3_mid_age_swap_band_10
  Scenario: Retrieve age band showing mid-age SIM swap (band 10)
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped in the last 20 days
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the value of response property "$.simSwapAgeBand" == 10

  @retrieve_age_band_4_old_swap_band_17
  Scenario: Retrieve age band showing old SIM swap (band 17)
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped more than 3 years ago
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the value of response property "$.simSwapAgeBand" == 17

  @retrieve_age_band_5_never_swapped_sentinel_111
  Scenario: Retrieve age band showing SIM has never been swapped (sentinel 111)
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has never been swapped
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the value of response property "$.simSwapAgeBand" == 111

  # Scenarios testing different access token types

  @retrieve_age_band_6_3legged_token
  Scenario: Retrieve age band using 3-legged access token
    Given the header "Authorization" is set to a valid 3-legged access token identifying a phone number
    And the request body does not include "phoneNumber"
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/SimSwapAgeBandInfo"

  @retrieve_age_band_7_2legged_token
  Scenario: Retrieve age band using 2-legged access token
    Given the header "Authorization" is set to a valid 2-legged access token
    And the request body property "$.phoneNumber" is set to a valid phone number
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/SimSwapAgeBandInfo"

  # Error scenarios

  @retrieve_age_band_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_age_band_400.1_invalid_phone_number
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @retrieve_age_band_422.1_missing_identifier
  Scenario: Phone number not included and cannot be deduced from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @retrieve_age_band_422.2_service_not_applicable
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  # 501 Not Implemented - operation is optional

  @retrieve_age_band_501_not_implemented
  Scenario: Operation not implemented by provider
    Given the provider does not implement the retrieve-age-band operation
    And the request body is set to a valid request body
    When the request "retrieveSimSwapAgeBand" is sent
    Then the response status code is 501
    And the response property "$.status" is 501
    And the response property "$.code" is "NOT_IMPLEMENTED"
    And the response property "$.message" contains a user friendly text
