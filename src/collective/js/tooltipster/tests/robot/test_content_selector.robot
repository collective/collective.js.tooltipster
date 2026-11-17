*** Settings ***
Documentation  Plone 6 only: view_content_selector was added by the Plone 6 branch (not in the Plone 4 helper).
Resource  tooltipster.robot
Test Setup  Open a manager browser on a document
Test Teardown  Close all browsers


*** Test Cases ***
The view_content_selector option shows only the matching part of the view
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice  options={view_content_selector: '.tt-name'}
    Hover the target  alice
    The tooltip shows  Alice
