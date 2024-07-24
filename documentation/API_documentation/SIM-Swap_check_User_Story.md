# SIM Swap Check API User Story


| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an enterprise application developer, I want to check if a SIM swap has occurred within a specified period for a user's mobile number so that I can enhance security measures against account takeover fraud.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User, Customer:BusinessManager, Customer:Administrator<br> **Actors:** Application service providers, hyperscalers, application developers, end users, Communication service Provider (CSP). <br> **Scope:**  <br> - Checks if a SIM Swap has occurred within a specified period for a given phone number. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:BusinessManager and Customer:Administrator have been onboarded to the CSP's API platform.</li><li>The Customer:BusinessManager has successfully subscribed to the SIM Swap API product from the product catalog.</li><li>The Customer:Administrator has onboarded the Customer:User to the platform.</li><li>The Customer:User performs an authorization request to CSP</li><li>The Customer:User has the access token allowing the access of the API and SIM Swap information of the target phoneNumber, if applies|
| ***Activities/Steps*** | **Starts when:** The customer application makes a POST request to the /check endpoint via the SIM Swap API, providing the phone number and the desired period to check for SIM swaps.<br>**Ends when:** The CSP's SIM Swap server responds indicating whether a SIM swap has been performed within the specified period. |
| ***Post-conditions*** | The customer application could continue offering its service to the user with the confirmation of the validity of the SIM based on the SIM Swap information.  |
| ***Exceptions*** | Several exceptions might occur during the SIM Swap API operations<br>- Unauthorized: Not valid credentials (e.g., use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g., improperly formatted phone number).|
