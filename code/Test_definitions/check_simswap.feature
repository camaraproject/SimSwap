Feature: Check if SIM Swap has been performed during a past period 

  @Test_Verify_Swap_True
  Scenario: Confirm that a SIM has been swapped
    Given a valid phone number "<phoneNumber>" whose SIM has been swapped in the last "<maxAge>" hours
    When a Check SimSwap request is made with a maxAge parameter of "<maxAge>"
    Then the response status code should be 200
    And the response body should confirm that a SIM swap has been performed 

    Examples:
      | phoneNumber   | maxAge |
      | +346661113334 | 24     |
      | +447748357814 | 48     |      

  @Test_Verify_Swap_True_Default_MaxAge
  Scenario: Confirm that a SIM has been swapped without specifying maxAge (should default to maxAge of 240)
    Given a valid phone number "<phoneNumber>" whose SIM has been swapped within the default max age value of 240
    When a Check SimSwap request is made without a maxAge parameter
    Then the response status code should be 200
    And the response body should confirm that a SIM swap has been performed    

  @Test_Verify_Swap_False
  Scenario: Confirm that a SIM has not been swapped
    Given a valid phone number "<phoneNumber>" whose SIM has NOT been swapped in the last "<maxAge>" hours
    When a Check SimSwap request is made with a maxAge parameter of "<maxAge>" 
    Then the response status code should be 200
    And the response body should confirm that a SIM swap has not been performed 

    Examples:
      | phoneNumber   | maxAge |
      | +346661113334 | 24     |
      | +447748357814 | 48     |       

  @Test_Verify_Swap_False_Default_MaxAge
  Scenario: Confirm that a SIM has NOT been swapped without specifying maxAge (should default to maxAge of 240)
    Given a valid phone number "<phoneNumber>" whose SIM has NOT been swapped within the default max age value (240)
    When a Check SimSwap request is made without a maxAge parameter
    Then the response status code should be 200
    And the response body should confirm that a SIM swap has not been performed  

  @Test_Negative_MaxAge
  Scenario: Input an invalid maxAge value (less than 1)
    Given a valid phone number "<phoneNumber>" whose SIM has been swapped in the last "<maxAge>" hours
    When a Check SimSwap request is made with a maxAge parameter of "-1"
    Then the response status code should be 400
    And the response should contain an error message indicating an invalid argument

    Examples:
      | phoneNumber   | maxAge |
      | +346661113334 | 24     |
      | +447748357814 | 48     |   

  @Test_Missing_Phone_Number
  Scenario: Perform a request without a phone number
    When a Check SimSwap request is made without a phoneNumber and with a "24" maxAge field
    Then the response status code should be 400
    And the response should contain an error message indicating a missing field

  @Test_Unknown_Phone_Number
  Scenario: Input an unknown phone number
    Given an unknown phone number of "<phoneNumber>"
    When a Check SimSwap request is made
    Then the response status code should be 404
    And the response should contain an error message indicating that the phone number is unknown

    Examples:
      | phoneNumber   |
      | +341111111111 |
      | +440000000000 |

  @Test_Unauthorized_Request
  Scenario: Perform an unauthorized request
    Given that there has been no access token request 
    And a valid phone number "<phoneNumber>" whose SIM has been swapped in the last "<maxAge>" hours
    When an unauthenticated Check SimSwap request is made with a maxAge parameter of "24"
    Then the response status code should be 401
    And the response should contain an error message indicating unauthenticated access

    Examples:
      | phoneNumber   | maxAge |
      | +346661113334 | 24     |
      | +447748357814 | 48     |       

  @Test_Invalid_Format
  Scenario: Perform a request with invalid format input
    Given an invalid input format "{abc:xyz}"
    When a Check SimSwap request is made with a maxAge parameter of "24"
    Then the response status code should be 40
    And the response should contain an error message indicating an invalid argument


