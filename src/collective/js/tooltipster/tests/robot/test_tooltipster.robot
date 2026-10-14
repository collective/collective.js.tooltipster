*** Settings ***
Documentation  Tooltips of tooltipster_helper as its Plone 4 callers use them. Version-independent:
...            Plone selectors are in ui_plone*.robot.
Resource  tooltipster.robot
Test Setup  Open a manager browser on a document
Test Teardown  Close all browsers


*** Test Cases ***
The tooltipster library and the helper are loaded on the pages
    The javascript value is  typeof jQuery.fn.tooltipster  function
    The javascript value is  typeof tooltipster_helper  function

Hovering an element shows the content of the view loaded with its data parameters
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}  delay=1
    Call the tooltipster helper  alice  data_parameters=['name', 'delay']
    Hover the target  alice
    The tooltip shows  \...
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    The tooltip has the class  tooltipster-shadow
    The tooltip has the class  tooltipster-bottom
    The tooltip z-index is  11000

Without data-base_url the view is called on the context of the page
    Add a tooltip target  bob  Bob
    Call the tooltipster helper  bob
    Hover the target  bob
    The tooltip shows  Hello Bob from ${DOC_TITLE}

Without data-base_url on a page opened with its view URL
    Go to  ${DOC_URL}/view
    Add a tooltip target  bob  Bob
    Call the tooltipster helper  bob
    Hover the target  bob
    The tooltip on a page opened with its view URL shows  ${DOC_TITLE}  Hello Bob from ${DOC_TITLE}

A page of the site is loaded without the site layout
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice  view_name=view
    Hover the target  alice
    The tooltip shows the page without the site layout  ${DOC_TITLE}

The content of the view is loaded once per element
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    Move the mouse to the site logo
    Every tooltip is closed
    Change the data-name of the target  alice  Bob
    Hover the target  alice
    The tooltip still shows after a while  Hello Alice from ${DOC_TITLE}

The theme option sets the theme of the tooltip
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice  options={theme: 'tooltipster-light'}
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    The tooltip has the class  tooltipster-light

The functionReady_callback option is called once the content is loaded
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice
    ...  options={functionReady_callback: function () {window.tooltip_ready = document.querySelector('.tooltipster-content').textContent.replace(/\\s+/g, ' ').trim();}}
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    The javascript value is  window.tooltip_ready  Hello Alice from ${DOC_TITLE}

Moving the mouse out of the element closes its tooltip
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Call the tooltipster helper  alice
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    Move the mouse to the site logo
    Every tooltip is closed

With close_other_tips opening a tooltip closes the other ones
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Add a tooltip target  bob  Bob  base_url=${DOC_URL}
    Call the tooltipster helper  alice  options={close_other_tips: true, triggerClose: {originClick: true}}
    Call the tooltipster helper  bob  options={close_other_tips: true, triggerClose: {originClick: true}}
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    Hover the target  bob
    The tooltip shows  Hello Bob from ${DOC_TITLE}
    The tooltip showing this text is closed  Hello Alice from ${DOC_TITLE}

Without close_other_tips the other tooltips stay open
    Add a tooltip target  alice  Alice  base_url=${DOC_URL}
    Add a tooltip target  bob  Bob  base_url=${DOC_URL}
    Call the tooltipster helper  alice  options={triggerClose: {originClick: true}}
    Call the tooltipster helper  bob  options={triggerClose: {originClick: true}}
    Hover the target  alice
    The tooltip shows  Hello Alice from ${DOC_TITLE}
    Hover the target  bob
    The tooltip shows  Hello Bob from ${DOC_TITLE}
    The tooltip still shows after a while  Hello Alice from ${DOC_TITLE}
