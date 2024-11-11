Feature: CAMARA SIM Swap API, 1.0.0 - Operation checkSimSwap

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specifies in sim_swap.yaml, version 1.0.0
  #
  # check if SIM swap has been performed during a past period

  Background: Common checkSimSwap setup
    Given the resource "sim-swap/v1/check"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
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

  # Specific errors

  @check_sim_swap_8_phone_number_not_supported
  Scenario: Error when the service is not supported for the provided phone number
    Given the request body property "$.phoneNumber" is set to a phone number for which the service is not available
    When the request "checkSimSwap" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_9_phone_number_provided_does_not_match_the_token
  Scenario: Error when the phone number provided in the request body does not match the phone number asssociated with the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that does not match the one associated with the token
    And the header "Authorization" is set to a valid access token
    When the request "checkSimSwap" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_10_phone_number_not_provided_and_cannot_be_deducted_from_access_token
  Scenario: Error when phone number can not be deducted from access token and it is not provided in the request body
    Given the header "Authorization" is set to a valid access token from which the phone number cannot be deducted
    When the request "checkSimSwap" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNIDENTIFIABLE_PHONE_NUMBER"
    And the response property "$.message" contains a user friendly text

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

  @check_sim_swap_400.1_invalid_phone_number
  Scenario: Check that the response shows an error when the phone number is invalid
    Given the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "checkSimSwap" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_400.2_invalid_max_age
  Scenario: Check that the response shows an error when the max age is invalid
    Given the request body property "$.maxAge" does not comply with the OAS schema at "/components/schemas/CreateCheckSimSwap"
    When the request "checkSimSwap" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
