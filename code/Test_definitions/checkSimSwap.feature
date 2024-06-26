Feature: CAMARA SIM Swap API, 0.5.0 - Operation checkSimSwap

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #
  # References to OAS spec schemas refer to schemas specifies in sim_swap.yaml, version 0.5.0

  check if SIM swap has been performed during a past period

  Background: Common checkSimSwap setup
    Given the resource "sim-swap/v0/check"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema


  # This first scenario serves as a minimum, not testing any specific verificationResult
  @check_sim_swap_1_generic_success_scenario
  Scenario: Common validations for any sucess scenario
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/CheckSimSwapInfo"

  # Scenarios testing specific situations

  @check_sim_swap_2_valid_sim_swap_no_max_age
  Scenario: Check that the response shows that the SIM has been swapped
    Given the request body property "$.phoneNumber" is set to a phone number connected to the Operator's network that has been swapped in the last 240 hours
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == true

  @check_sim_swap_3_valid_sim_swap_max_age
  Scenario Outline: Check that the response shows that the SIM has been swapped
    Given the request body property "$.phoneNumber" is set to a phone number connected to the Operator's network that has been swapped in the last "<hours>" hours, where "<hours>" is equal or less than provided "maxAge" request body parameter
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
    Given the request body property "$.phoneNumber" is set to a phone number connected to the Operator's network that has been swapped more than 240 hours ago
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  @check_sim_swap_5_out_of_max_age
  Scenario: Check that the response shows that the SIM has not been swapped when the last swap was before the maxAge field
    Given the request body property "$.maxAge" is set to the number of hours since the last SIM swap minus 1
    And the request body property "$.phoneNumber" is set to a phone number connected to the network whose last SIM swap was more than "$.maxAge" hours ago
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  @check_sim_swap_6_no_sim_swap
  Scenario: Check that the response shows that the SIM has not been swapped
    Given the request body property "$.phoneNumber" is set to a phone number with a SIM that has never been swapped
    When the request "checkSimSwap" is sent
    Then the response status code is 200
    And the value of response property "$.swapped" == false

  # Specific errors

  @check_sim_swap_7_unknown_phone_number
  Scenario: Error when the phone number does not belong to the Operator
    Given the request body property "$.phoneNumber" is set to a phone number that does not belong to the Operator
    When the request "checkSimSwap" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "SIM_SWAP.UNKNOWN_PHONE_NUMBER"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_8_phone_number_provided_does_not_belong_to_the_user
  Scenario: Error when provided phone number does not belong to the user
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that does not belong to the user
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    When the request "checkSimSwap" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_9_phone_number_provided_does_not_match_the_token
  Scenario: Error when the phone number provided in the request body belongs to the user but does not match the phone number asssociated with the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber that belongs to the user but does not match the one associated with the token
    And the header "Authorization" is set to a valid access token
    When the request "checkSimSwap" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_10_phone_number_provided_cannot_be_deducted_from_access_token
  Scenario: Error when the phone number is provided in the request body but cannot be deducted from the access token
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber of the user
    And the header "Authorization" is set to a valid access token from which the phone number cannot be deduced
    When the request "checkSimSwap" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_11_phone_number_not_provided_and_cannot_be_deducted_from_access_token
  Scenario: Error when phone number can not be deducted from access token and it is not provided in the request body
    Given the header "Authorization" is set to a valid access token from which the phone number cannot be deduced
    When the request "checkSimSwap" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @check_sim_swap_12_phone_number_conflict
  Scenario: Error when another request is created for the same phoneNumber
    Given the request body property "$.phoneNumber" is set to a valid testing phoneNumber
    And the header "Authorization" is set to a valid access token emitted
    And another request is created for the same phoneNumber
    When the request "checkSimSwap" is sent
    Then the response status code is 409
    And the response property "$.status" is 409
    And the response property "$.code" is "CONFLICT"
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
