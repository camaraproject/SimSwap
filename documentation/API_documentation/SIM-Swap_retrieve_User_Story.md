# SIM Swap Retrieve API User Story


| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an enterprise application developer, I want to verify the last SIM Swap date for a user's mobile number so that I can enhance security measures against account takeover fraud.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User, Customer:BusinessManager, Customer:Administrator<br> **Actors:** Application service providers, hyperscalers, application developers, end users. <br> **Scope:**  <br> - Retrieves the timestamp of the last SIM Swap event for a given phone number. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:BusinessManager and Customer:Administrator have been onboarded to the CSP's API platform.</li><li>The Customer:BusinessManager has successfully subscribed to the SIM Swap API product from the product catalog.</li><li>The Customer:Administrator has onboarded the Customer:User to the platform.</li><li>The Customer:User performs an authorization request to CSP</li><li>The Customer:User has the access token allowing a secure access of the API.|
| ***Activities/Steps*** | **Starts when:** The customer application makes a POST request to the /retrieve-date endpoint via the SIM Swap API, including the phone number provided by the user in the application.<br>**Ends when:** The SIM Swap server responds with the timestamp of the last SIM swap event, or the SIM activation date if no swap has occurred. |
| ***Post-conditions*** | The customer application could continue offering its service to the user with the confirmation of the validity of the SIM based on the SIM Swap information.  |
| ***Exceptions*** | Several exceptions might occur during the SIM Swap API operations<br>- Unauthorized: Not valid credentials (e.g., use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g., improperly formatted phone number).<br>- Not able to provide: Legal restrictions or data retention policies preventing the retrieval of the requested information.|
