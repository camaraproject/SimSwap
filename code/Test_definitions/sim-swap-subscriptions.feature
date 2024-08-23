Feature: CAMARA sim swap subscriptions  API, v0.1.0
  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  # * A mobile line identified by its phone number "phoneNumber" associated with a sim card 1
  # * Be able to perform a sim swap for this mobile line shifting from sim card 1 to sim card 2
  # * a callback url identified as "callbackUrl" allows to receive notification
  #
  # References to OAS spec schemas refer to schemas specifies in sim-swap-subscriptions.yaml, version v0.1.0

  Background: Common subscriptions setup
    Given the resource "/sim-swap-subscriptions/v0/subscriptions" as BaseURL                                                            |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

##########################
# Happy path scenarios
##########################

  # These first scenarios serves as a minimum
  
  @sim_swap_subscription_creation_01_sync_creation
  Scenario: Check sync subscription creation - This scenario could be bypass if async creation is provided (following scenario)
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And types, protocol, sink and config.subscriptionDetail.phoneNumber are present with provided value
    And startsAt is valued with a datetime corresponding to the date time of the response

  @sim_swap_subscription_creation_02_async_creation
  Scenario: Check async subscription creation - This scenario could be bypass if previous scenario is provided
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

  @sim_swap_subscription_retrieve_03_retrieve_by_id
  Scenario: Check existing subscription is retrieved by id
    Given a valid subscription is existing and identified by an "id"
    And use BaseURL
    When get sim swap subscription with subscriptionId="id"
    Then the response property "$.status" is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @sim_swap_subscription_retrieve_04_retrieve_list
  Scenario: Check existing subscription is retreived in list
    Given valid subscriptions are existing
    And use BaseURL
    When get sim swap subscription
    Then the response property "$.status" is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And all valid subscriptions are listed

  @sim_swap_subscription_delete_05_delete_subscription
  Scenario: Check deletion of existing subscription & triggering of subscription-ends event
    Given a valid subscription is existing and identified by an "id"
    And use BaseURL
    When delete sim swap subscription with subscriptionId="id"
    Then the response property "$.status" is 204
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And The callback notification application receives subscription-ends event at provided callbackUrl
    And notification body complies with the OAS schema at "##/components/schemas/Subscription/CloudEvent"
    And type="org.camaraproject.sim-swap-subscriptions.v0.subscription-ends"
    And data.phoneNumber="$.phoneNumber"
    And data.subscriptionId is valued with the subcriptionId
    And time is valued by the date time of subscription termination

  @sim_swap_subscription_creation_06_swapped
  Scenario: Check swapped event is triggered when a sim swap is performed on the device
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 201
    And subcriptionId is provided 
    When sims swap is performed on this mobile line
    Then The callback notification application receives swapped event at provided callbackUrl
    And notification body complies with the OAS schema at "##/components/schemas/Subscription/CloudEvent"
    And type="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And data.phoneNumber="$.phoneNumber"
    And data.subscriptionId is valued with the subcriptionId
    And time is valued by the date time of the sim swap

#########################
# Rainy Day scenario
#########################

##################
# Error code 400
##################

  @sim_swap_subscription_creation_20_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"<>"HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_21_invalid_credential
  Scenario: subscription creation with invalid credential
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    And "$.sinkCredential.credentialType" <> "ACCESSTOKEN"
    And "$.sinkCredential.accessTokenType" = "bearer"
    And "$.sinkCredential.accessToken" is valued with a valid value
    And "$.sinkCredential.accessTokenExpiresUtc" is valued with a valid value
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_22_invalid_token
  Scenario: subscription creation with invalid token
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    And "$.sinkCredential.credentialType" = "ACCESSTOKEN"
    And "$.sinkCredential.accessTokenType" <> "bearer"
    And "$.sinkCredential.accessToken" is valued with a valid value
    And "$.sinkCredential.accessTokenExpiresUtc" is valued with a valid value
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_23_invalid_eventType
  Scenario: subscription creation with invalid event type
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"<>"org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_24_invalid_subscription_expire_time
  Scenario: subscription creation with invalid expire time
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is set to provided callbackUrl
    And "$.config.subscriptionExpireTime" is set in the past
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_25_require_input_properties_missing
  Scenario: subscription creation with required properties missing
    Given use BaseURL
    When create sim swap subscription 
    And the request body property "<input_property>" is not included
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property                           |
      | $.protocol                               |
      | $.sink                                   |
      | $.types                                  |
      | $.config.subscriptionDetail.phoneNumber  |

  @sim_swap_subscription_creation_26_invalid_sink
  Scenario: subscription creation with invalid sink
    Given use BaseURL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set with with provided phoneNumber
    And "$.sink" is not set to an url
    And "$.config.subscriptionExpireTime" is set in the past
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text


##################
# Error Code 401
##################

  @sim_swap_subscription_creation_40_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_41_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_creation_42_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_retrieve_43_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_retrieve_44_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_retrieve_45_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_delete_46_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_delete_47_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_delete_48_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

##################
# Error Code 403
##################

  @sim_swap_subscription_creation_60_phone_number_token_mismatch
  Scenario: Inconsistent access token context for the phone number
    # To test this, a token have to be obtained for a different phone number
    Given the request body property "$.config.subscriptionDetail.phoneNumber" is set to a valid testing phone number
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    And use BaseUrL
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text


  @sim_swap_subscription_retrieve_61_phone_number_token_mismatch
  Scenario: Inconsistent access token context for the phone number
    # To test this, a token have to be obtained for a different phone number
    Given an existing subscription for a phone number
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text


  @sim_swap_subscription_delete_62_device_token_mismatch
  Scenario: Inconsistent access token context for the device
    # To test this, a token have to be obtained for a different device
    Given an existing subscription for a phone number
    And the header "Authorization" is set to a valid access token emitted for a different phone number
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

##################
# Error Code 404
##################

  @sim_swap_subscription_retrieve_80_not_found_retrieve_by_id
  Scenario: Request to retrieve a non-existing subscription
    Given use BaseURL
    When get sim swap subscription with subscriptionId set to non-existing subscription id
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscription_delete_81_not_found_delete_by_id
  Scenario: Request to delete a non-existing subscription
    Given use BaseURL
    When delete sim swap subscription with subscriptionId set to non-existing subscription id
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

##################
# Error Code 422
##################

  @sim_swap_subscription_creation_100_not_applicable
  Scenario: request for an unapplicable phone number for sim swap subscription
    # To test this it is required to have a phone number not compatibme with sim swap subscription
    Given use BaseUrL
    When create sim swap subscription 
    And "$.types"="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And "$.protocol"="HTTP"
    And "$.config.subscriptionDetail.phoneNumber" is set to a valid testing device that does not allow sim swap subscription
    And "$.sink" is set to provided callbackUrl
    Then the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text
