Feature: CAMARA SIM Swap API, v2.1.0 - Operation checkSimSwap

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specified in sim_swap.yaml
  #
  # check if SIM swap has been performed during a past period

  Background: Common checkSimSwap setup
    Given the resource "/sim-swap/v2/check"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # This first scenario serves as a minimum, not testing any specific verificationResult
  @check_sim_swap_1_generic_success_scenario
  Scenario: Common validations for any sucess scenario
    Given a valid phone number identified by the token or provided in the request body
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/CheckSimSwapInfo"

  # Scenarios testing specific situations

  @check_sim_swap_2_valid_sim_swap_no_max_age
  Scenario: Check that the response shows that the SIM has been swapped using default value for maxAge
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped in the last 240 hours
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == true

  @check_sim_swap_3_valid_sim_swap_max_age
  Scenario Outline: Check that the response shows that the SIM has been swapped - maxAge is provided in the request
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped in the last "<hours>"
    And the "maxAge" request body property is set to a value equal or greater than "<hours>" within the allowed range
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == true

    Examples:
      | hours |
      | 260   |
      | 120   |
      | 24    |
      | 12    |

  @check_sim_swap_4_more_than_240_hours
  Scenario: Check that the response shows that the SIM has not been swapped when the last swap was more than 240 hours ago
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has been swapped more than 240 hours ago
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  @check_sim_swap_5_out_of_max_age
  Scenario: Check that the response shows that the SIM has not been swapped when the last swap was before the maxAge field
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "maxAge" is set to the number of hours since the last SIM swap minus 1
    And the last swap for this phone number's SIM was more than "maxAge" hours ago
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  @check_sim_swap_6_no_sim_swap_no_max_age
  Scenario: Check that the response shows that the SIM has not been swapped - maxAge is not provided in the request parameter
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has never been swapped
    And the activation of the SIM occurred more than 240 hours ago
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  @check_sim_swap_7_no_sim_swap_with_max_age
  Scenario Outline: Check that the response shows that the SIM has not been swapped - maxAge is provided in the request parameter
    Given a valid phone number identified by the token or provided in the request body
    And the SIM for this phone number has never been swapped
    And the activation of the SIM occurred more than "<hours>" hours ago
    And the request body property "maxAge" is set to a value less than "<hours>" within the allowed range
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

    Examples:
      | hours |
      | 260   |
      | 120   |
      | 24    |
      | 12    |

  # Generic 401 errors

  @check_sim_swap_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "checkSimSwap" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_401.2_expired_access_token
  Scenario: Expired access token
    # alternative to scenario @check_sim_swap_401.4_expired_access_token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "checkSimSwap" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "checkSimSwap" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 400 errors

  @check_sim_swap_400.1_invalid_max_age
  Scenario: Check that the response shows an error when the max age is invalid
    Given the request body property "$.maxAge" does not comply with the OAS schema at "/components/schemas/CreateCheckSimSwap"
    When the request "checkSimSwap" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_400.2_invalid_max_age_value
  Scenario: Check that the response shows an error when the max age is above the limit
    Given the request body property "$.maxAge" is set to 100000
    When the request "checkSimSwap" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "OUT_OF_RANGE"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_400.3_max_age_out_of_monitored_period
  Scenario: Check that the response shows an error when the max age is above the supported monitored period of the API Provider
    # This test only applies if the API Provider has a restricted monitored period by local regulations
    Given the request body property "$.maxAge" is set to a valid value above the supported monitored period of the API Provider
    When the request "checkSimSwap" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "OUT_OF_RANGE"
    And the response property "$.message" contains a user friendly text

  # Error scenarios for management of input parameter phoneNumber

  @check_sim_swap_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
      Given the header "Authorization" is set to a valid access token which does not identify a single phone number
      And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
      When the request "checkSimSwap" is sent
      Then the response status code is 400
      And the response property "$.status" is 400
      And the response property "$.code" is "INVALID_ARGUMENT"
      And the response property "$.message" contains a user friendly text

  @check_sim_swap_C02.02_phone_number_not_found
  Scenario: Phone number not found
      Given the header "Authorization" is set to a valid access token which does not identify a single phone number
      And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
      When the request "checkSimSwap" is sent
      Then the response status code is 404
      And the response property "$.status" is 404
      And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
      And the response property "$.message" contains a user friendly text

  @check_sim_swap_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
      Given the header "Authorization" is set to a valid access token identifying a phone number
      And  the request body property "$.phoneNumber" is set to a valid phone number
      When the request "checkSimSwap" is sent
      Then the response status code is 422
      And the response property "$.status" is 422
      And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
      And the response property "$.message" contains a user friendly text

  @check_sim_swap_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
      Given the header "Authorization" is set to a valid access token which does not identify a single phone number
      And the request body property "$.phoneNumber" is not included
      When the request "checkSimSwap" is sent
      Then the response status code is 422
      And the response property "$.status" is 422
      And the response property "$.code" is "MISSING_IDENTIFIER"
      And the response property "$.message" contains a user friendly text

  # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
  @check_sim_swap_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
      Given that the service is not available for all phone numbers commercialized by the operator
      And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
      When the request "checkSimSwap" is sent
      Then the response status code is 422
      And the response property "$.status" is 422
      And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
      And the response property "$.message" contains a user friendly text
