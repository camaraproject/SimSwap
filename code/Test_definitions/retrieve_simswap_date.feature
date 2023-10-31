Feature: Retrieve SIM Swap Date (POST /retrieve-date)

  @Test_Retrieve_Success
  Scenario: Retrieve SIM Swap Date successfully
    Given a valid phone number "<phoneNumber>" whose SIM has been swapped 
    When the SIM Swap Date is retrieved
    Then the response status code should be 200
    And the response body should contain the latest sim change date 

    Examples:
      | phoneNumber   |
      | +346661113334 | 
      | +447748357814 | 

  @Test_Unknown_Phone_Number
  Scenario: Request SIM Swap Date for an unknown phone number
    Given an unknown phone number "<phoneNumber>"
    When the SIM Swap Date is retrieved
    Then the response status code should be 404
    And the response should contain an error message indicating that the phone number is unknown

    Examples:
      | phoneNumber   |
      | +341111111111 |
      | +440000000000 |    

  @Test_Missing_Swap_Date
  Scenario: Request SIM Swap Date for a phone number that has no SIM swap date
    Given a phone number "<phoneNumber>" whose SIM Swap date is unknown/unavailable
    When the SIM Swap Date is retrieved
    Then the response status code should be 200
    And the response should be blank ("")

    Examples:
      | phoneNumber   |
      | +346661113334 | 
      | +447748357814 | 

  @Test_Unauthorized_Request
  Scenario: Perform an unauthorized request
    Given that there has been no access token request 
    And a valid phone number "<phoneNumber>" 
    When the SIM Swap Date is retrieved
    Then the response status code should be 401
    And the response should contain an error message indicating unauthenticated access

  @Test_Invalid_Format
  Scenario: Perform a request with invalid format input
    Given an invalid input format "{abc:xyz}"
    When the SIM Swap retrieve date endpoint is called
    Then the response status code should be 400
    And the response should contain an error message indicating an invalid argument