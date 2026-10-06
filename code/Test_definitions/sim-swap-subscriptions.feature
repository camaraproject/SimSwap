Feature: CAMARA Sim Swap Subscriptions API, vwip - Operations on subscriptions

  # Input to be provided by the implementation to the tester
  #
  # Testing assets:
  #   A sink-url identified as "callbackUrl", which receives notifications
  #   A mobile line identified by its phone number associated with a sim card 1
  #   Be able to perform a sim swap for this mobile line shifting from sim card 1 to sim card 2
  #
  # References to OAS spec schemas refer to schemas specified in sim-swap-subscriptions.yaml

  Background: Common sim-swap-subscriptions setup
    Given the resource "/sim-swap-subscriptions/vwip/subscriptions" as BaseURL
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

############################ Happy Path Scenarios #############################################

# Note: Depending on the API managed personal data specific scenario update may be required to specify use of 2-legs or 3-legs access token.

  @sim_swap_subscriptions_01_Create_sim_swap_subscriptions_subscription_sync
  Scenario: Create sim-swap-subscriptions subscription (sync creation)
  # Some implementations may only support asynchronous subscription creation
    Given that subscriptions are created synchronously
    And a valid subscription request body
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @sim_swap_subscriptions_02_Create_sim_swap_subscriptions_subscription_async
  Scenario: Create sim-swap-subscriptions subscription (async creation)
  # Some implementations may only support synchronous subscription creation
    Given that subscriptions are created asynchronously
    And a valid subscription request body
    When the request "createSimSwapSubscription" is sent
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

  @sim_swap_subscriptions_03_subscription_creation_event_validation
  Scenario: Receive notification for subscription-started event on creation
    Given a valid subscription request body
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201 or 202
    And event notification "subscription-started" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionStarted"
    And type="org.camaraproject.sim-swap-subscriptions.v0.subscription-started"
    And the response property "$.initiationReason" is "SUBSCRIPTION_CREATED"

  @sim_swap_subscriptions_04_Operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of sim-swap-subscriptions subscriptions when no subscriptions available
    Given a client without sim-swap-subscriptions subscriptions created
    When the request "retrieveSimSwapSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body property "$.subscriptions" is an empty array
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"

  @sim_swap_subscriptions_05_Operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions
    Given a client with sim-swap-subscriptions subscriptions created
    When the request "retrieveSimSwapSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And each item in the response body property "$.subscriptions" complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"

  @sim_swap_subscriptions_06_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @sim_swap_subscriptions_07_Operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And if the response property "$.status" is 204 then the response body is not available
    And if the response property "$.status" is 202 then the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

  @sim_swap_subscriptions_08_subscription_ends_on_expiry
  Scenario: Receive notification for subscription-ended event on expiry
    Given an existing sim-swap-subscriptions subscription with some value for the property "expiresAt" in the near future
    When the subscription is expired
    Then the event notification "subscription-ended" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnded"
    And type="org.camaraproject.sim-swap-subscriptions.v0.subscription-ended"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @sim_swap_subscriptions_09_subscription_ends_on_max_events
  Scenario: Receive notification for subscription-ended event on max events reached
    Given an existing sim-swap-subscriptions subscription with the property "config.subscriptionMaxEvents" set to 1
    When the event subscribed occurs
    Then event notification "swapped" is received on callback-url
    And event notification "subscription-ended" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnded"
    And type="org.camaraproject.sim-swap-subscriptions.v0.subscription-ended"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @sim_swap_subscriptions_10_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ended event on deletion
    Given the path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response code is 202 or 204
    And event notification "subscription-ended" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnded"
    And type="org.camaraproject.sim-swap-subscriptions.v0.subscription-ended"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

######################### Scenario in case initialEvent is managed ##############################

  @sim_swap_subscriptions_11_subscription_creation_initial_event
  Scenario: Receive initial event notification on creation
    Given the API supports initial events to be sent
    And a valid subscription request body with property "$.config.initialEvent" set to true
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201 or 202
    And an event notification of the subscribed type is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/CloudEvent"

######################### SIM Swap specific happy path scenario ##############################

  @sim_swap_subscriptions_swapped_event_validation
  Scenario: Receive notification for swapped event when a SIM swap is performed
    Given a valid subscription request body
    And the request body property "$.types" is set to "org.camaraproject.sim-swap-subscriptions.v0.swapped"
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201
    And a SIM swap is performed on the subscribed mobile line
    And event notification "swapped" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/CloudEvent"
    And type="org.camaraproject.sim-swap-subscriptions.v0.swapped"
    And data.subscriptionId is valued with the subscriptionId

######################### Additional Happy Path Scenarios ##############################

  @sim_swap_subscriptions_12_Create_sim_swap_subscriptions_subscription_sync_with_accesstoken_sink_credential
  Scenario: Create sim-swap-subscriptions subscription (sync creation) with ACCESSTOKEN sinkCredential
  # Some implementations may only support asynchronous subscription creation
  # Some implementations may decide to not return the sinkCredential in the response (data minimization principle)
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request property "$.sinkCredential.credentialType" is set to "ACCESSTOKEN"
    And the request property "$.sinkCredential.accessTokenType" is set to "bearer"
    And the request property "$.sinkCredential.accessToken" is set to a valid access token
    And the request property "$.sinkCredential.accessTokenExpiresUtc" is set to a valid expiry date in the future
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.sinkCredential.credentialType", if present, is set to value "ACCESSTOKEN"
    And the response body property "$.sinkCredential.accessTokenExpiresUtc", if present, is set to the same value of the request property "$.sinkCredential.accessTokenExpiresUtc"

  @sim_swap_subscriptions_13_Create_sim_swap_subscriptions_subscription_sync_with_private_jwt_key_sink_credential_out_of_band_provisioning
  Scenario: Create sim-swap-subscriptions subscription (sync creation) with PRIVATE_JWT_KEY sinkCredential, out-of-band provisioning
  # Some implementations may only support asynchronous subscription creation
  # Some implementations may only support out_of_band provisioning
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request property "$.sinkCredential.credentialType" is set to "PRIVATE_JWT_KEY"
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @sim_swap_subscriptions_14_Create_sim_swap_subscriptions_subscription_sync_with_private_jwt_key_sink_credential_in_band_provisioning
  Scenario: Create sim-swap-subscriptions subscription (sync creation) with PRIVATE_JWT_KEY sinkCredential, in-band provisioning
  # Some implementations may only support asynchronous subscription creation
  # Some implementations may additionally support in_band provisioning
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request property "$.sinkCredential.credentialType" is set to "PRIVATE_JWT_KEY"
    And the request property "$.sinkCredential.clientId" is set to a valid value
    And the request property "$.sinkCredential.tokenUri" is set to a valid value
    When the request "createSimSwapSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.sinkCredential.credentialType" is set to value "PRIVATE_JWT_KEY"
    And the response body property "$.sinkCredential.jwksUri" is set to a valid value

  @sim_swap_subscriptions_15_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id_access_token_sink_credential_returned
  # Some implementations may decide to not return the sinkCredential in the response (data minimization principle)
  Scenario: Get a subscription based on existing subscription-id, with ACCESSTOKEN sinkCredential returned.
    Given the path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.sinkCredential.credentialType", if present, is set to value "ACCESSTOKEN"
    And the response body property "$.sinkCredential.accessTokenExpiresUtc", if present, is set to the same value of the request property "$.sinkCredential.accessTokenExpiresUtc"

  @sim_swap_subscriptions_16_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id_private_jwt_key_sink_credential_returned
  # Some implementations may decide to not return the sinkCredential in the response (data minimization principle)
  # Mainly applicable for in-band provisioning of PRIVATE_JWT_KEY mode for a given subscription
  Scenario: Get a subscription based on existing subscription-id, with PRIVATE_JWT_KEY sinkCredential returned.
    Given the path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.sinkCredential.credentialType" is set to value "PRIVATE_JWT_KEY"
    And the response body property "$.sinkCredential.jwksUri" is set to a valid value

########################### Error response scenarios ############################################
########################### Subscription creation scenarios #####################################

  @sim_swap_subscriptions_20_creation_sim_swap_subscriptions_subscription_with_invalid_parameter
  Scenario: Create sim-swap-subscriptions subscription with invalid parameter
    Given the request body is not compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "createSimSwapSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_21_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid sim-swap-subscriptions subscription request body
    And request body property "$.config.subscriptionExpireTime" in the past
    When the request "createSimSwapSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_subscription_22_creation_with_invalid_eventType
  Scenario: Subscription creation with invalid event type
    Given a valid sim-swap-subscriptions subscription request body
    And the request body property "$.types" is set to invalid value
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_subscription_23_invalid_protocol
  Scenario: Subscription creation with invalid protocol
    Given a valid sim-swap-subscriptions subscription request body
    And the request property "$.protocol" is not set to "HTTP"
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_subscription_24_invalid_credential
  Scenario: Subscription creation with invalid credential
    Given a valid sim-swap-subscriptions subscription request body
    And the request property "$.protocol" is set to "HTTP"
    And the request property "$.sinkCredential.credentialType" is not set to "ACCESSTOKEN" and is not set to "PRIVATE_KEY_JWT"
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_subscription_25_invalid_token
  Scenario: Subscription creation with invalid token
    Given a valid sim-swap-subscriptions subscription request body
    And the request property "$.protocol" is set to "HTTP"
    And the request property "$.sinkCredential.credentialType" is set to "ACCESSTOKEN"
    And the request property "$.sinkCredential.accessTokenType" is not set to "bearer"
    And the request property "$.sinkCredential.accessToken" is valued with a valid value
    And the request property "$.sinkCredential.accessTokenExpiresUtc" is valued with a valid value
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_subscription_26_invalid_url
  Scenario: Subscription creation with invalid url
    Given a valid sim-swap-subscriptions subscription request body
    And the request property "$.protocol" is set to "HTTP"
    And the request property "$.sink" is set to "invalid-url"
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_SINK"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_27_no_authorization_header_for_create_subscription
  Scenario: No Authorization header for create subscription
    Given a valid sim-swap-subscriptions subscription request body
    And the request does not include the "Authorization" header
    When the request "createSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_28_expired_access_token_for_create_subscription
  Scenario: Expired access token for create subscription
    Given a valid sim-swap-subscriptions subscription request body and header "Authorization" is expired
    When the request "createSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_29_invalid_access_token_for_create_subscription
  Scenario: Invalid access token for create subscription
    Given a valid sim-swap-subscriptions subscription request body
    And header "Authorization" set to an invalid access token
    When the request "createSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

########################### Subscription retrieval scenarios #####################################

  @sim_swap_subscriptions_30_no_authorization_header_for_get_subscription
  Scenario: No Authorization header for get subscription
    Given header "Authorization" is not present
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_31_expired_access_token_for_get_subscription
  Scenario: Expired access token for get subscription
    Given the header "Authorization" is set to expired token
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_32_invalid_access_token_for_get_subscription
  Scenario: Invalid access token for get subscription
    Given the header "Authorization" set to an invalid access token
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_33_get_unknown_sim_swap_subscriptions_subscription_for_a_device
  Scenario: Get method for sim-swap-subscriptions subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to a value not corresponding to any existing subscription
    When the request "retrieveSimSwapSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

########################### Subscription list retrieval scenarios #####################################

  @sim_swap_subscriptions_40_no_authorization_header_for_list_subscription
  Scenario: No Authorization header for list subscription
    Given header "Authorization" is not present
    When the request "retrieveSimSwapSubscriptionList" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_41_expired_access_token_for_list_subscription
  Scenario: Expired access token for list subscription
    Given the header "Authorization" is set to expired token
    When the request "retrieveSimSwapSubscriptionList" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_42_invalid_access_token_for_list_subscription
  Scenario: Invalid access token for list subscription
    Given the header "Authorization" set to an invalid access token
    When the request "retrieveSimSwapSubscriptionList" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

########################### Subscription deletion scenarios #####################################

  @sim_swap_subscriptions_50_no_authorization_header_for_delete_subscription
  Scenario: No Authorization header for delete subscription
    Given header "Authorization" is set without a token
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_51_expired_access_token_for_delete_subscription
  Scenario: Expired access token for delete subscription
    Given header "Authorization" is set with an expired token
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_52_invalid_access_token_for_delete_subscription
  Scenario: Invalid access token for delete subscription
    Given header "Authorization" set to an invalid access token
    And path parameter "subscriptionId" is set to the identifier of an existing sim-swap-subscriptions subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_53_delete_invalid_sim_swap_subscriptions_subscription
  Scenario: Delete sim-swap-subscriptions subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to a value not corresponding to any existing subscription
    When the request "deleteSimSwapSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

######## Specific Subscription error scenario if multi-event is not permitted ################

  @sim_swap_subscriptions_60_creation_with_unsupported_multiple_event_type
  Scenario: Multi event subscription not supported
    Given the API provider only allows one event to be subscribed per subscription request
    And a valid subscription request body
    And the request body property "$.types" is set to an array with 2 valid items
    When the request "createSimSwapSubscription" is sent
    Then the response code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text

######## Specific Subscription error scenario if Private JWT Key is not pre-configured ################

  @sim_swap_subscriptions_61_creation_with_private_jwt_key_not_configured
  Scenario: Private JWT Key not configured for subscription creation
    Given the API provider requires the use of a Private JWT key mechanism for subscription creation authentication
    And the Private JWT key mechanism is not pre-configured in the environment
    And a valid subscription request body with the property "$.sinkCredential.credentialType" set to "PRIVATE_KEY_JWT"
    When the request "createSimSwapSubscription" is sent
    Then the response code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "PRIVATE_KEY_JWT_NOT_CONFIGURED"
    And the response property "$.message" contains a user friendly text

######## SIM Swap specific 422 error scenarios ################

  @sim_swap_subscriptions_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the request body property "$.config.subscriptionDetail.phoneNumber" does not comply with the OAS schema at "#/components/schemas/PhoneNumber"
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the request body property "$.config.subscriptionDetail.phoneNumber" is set to a valid but non-existing phone number
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And the request body property "$.config.subscriptionDetail.phoneNumber" is set to a valid phone number
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
    Given the header "Authorization" is set to a valid access token not identifying a phone number
    And the request body property "$.config.subscriptionDetail.phoneNumber" is not included
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @sim_swap_subscriptions_C02.05_phone_number_not_supported
  Scenario: Phone number not supported by the service
    Given the request body property "$.config.subscriptionDetail.phoneNumber" is set to a valid phone number not supported by the service
    When the request "createSimSwapSubscription" is sent
    Then the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

