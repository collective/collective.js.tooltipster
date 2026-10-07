*** Settings ***
Documentation  collective.js.tooltipster keywords, built on the ui_plone${PLONE_MAJOR}.robot keywords.
...            Robot Framework 3.0 syntax (shared with the Plone 4.3 environment).
...            The helper is called in the Plone 4 positional order of every caller:
...            tooltipster_helper(selector, view_name, data_parameters, options).
Resource  ui_plone${PLONE_MAJOR}.robot


*** Variables ***
${DOC_URL}  ${PLONE_URL}/doc
${DOC_TITLE}  My document
# test-only page of testing.zcml: "Hello <name parameter> from <context title>", waits <delay parameter> seconds
${VIEW_NAME}  tooltipster-test-view
${TOOLTIP}  css=.tooltipster-base
${TOOLTIP_XPATH}  //div[contains(concat(" ", @class, " "), " tooltipster-base ")]
${TOOLTIP_VISIBLE_TEXT}  document.querySelector('.tooltipster-content').innerText.replace(/\\s+/g, ' ').trim()


*** Keywords ***
Open a manager browser on a document
    Open test browser
    Enable autologin as  Manager
    Create content  type=Document  id=doc  title=${DOC_TITLE}
    Go to  ${DOC_URL}

Add a tooltip target
    [Documentation]  Span at the top of the content area with a data-name attribute,
    ...              and data-base_url / data-delay (seconds the page waits) when given
    [Arguments]  ${id}  ${name}  ${base_url}=${EMPTY}  ${delay}=${EMPTY}
    Execute javascript
    ...  var target = document.createElement('span');
    ...  target.id = '${id}';
    ...  target.textContent = 'Target ${id}';
    ...  target.style.display = 'inline-block';
    ...  target.style.padding = '5px';
    ...  target.style.marginRight = '300px';
    ...  target.setAttribute('data-name', '${name}');
    ...  if ('${base_url}') {target.setAttribute('data-base_url', '${base_url}');}
    ...  if ('${delay}') {target.setAttribute('data-delay', '${delay}');}
    ...  var content = document.getElementById('${CONTENT_ID}');
    ...  content.insertBefore(target, content.firstChild);

Change the data-name of the target
    [Arguments]  ${id}  ${name}
    Execute javascript  document.getElementById('${id}').setAttribute('data-name', '${name}');

Call the tooltipster helper
    [Documentation]  Plone 4 positional order. data_parameters and options are JS literals.
    [Arguments]  ${id}  ${data_parameters}=['name']  ${options}={}
    Execute javascript  tooltipster_helper('[id="${id}"]', '${VIEW_NAME}', ${data_parameters}, ${options});

Hover the target
    [Arguments]  ${id}
    Mouse over  css=[id="${id}"]

The tooltip shows
    [Documentation]  A visible tooltip shows exactly this text
    [Arguments]  ${text}
    Wait until element is visible  xpath=${TOOLTIP_XPATH}\[normalize-space(.)="${text}"]

The visible text of the tooltip is
    [Documentation]  Text the user sees in the open tooltip, once loaded
    [Arguments]  ${text}
    Wait until keyword succeeds  10s  0.2s  The javascript value is  ${TOOLTIP_VISIBLE_TEXT}  ${text}

The tooltip showing this text is closed
    [Arguments]  ${text}
    Wait until page does not contain element  xpath=${TOOLTIP_XPATH}\[normalize-space(.)="${text}"]

The tooltip still shows after a while
    [Documentation]  Leaves time to a new loading of the content
    [Arguments]  ${text}
    Sleep  1s
    The tooltip shows  ${text}

Every tooltip is closed
    Wait until page does not contain element  ${TOOLTIP}

The tooltip has the class
    [Arguments]  ${class}
    Page should contain element  ${TOOLTIP}.${class}

The tooltip z-index is
    [Arguments]  ${expected}
    ${z_index}=  Execute javascript  return window.getComputedStyle(document.querySelector('.tooltipster-base')).zIndex;
    Should be equal as strings  ${z_index}  ${expected}

The javascript value is
    [Arguments]  ${expression}  ${expected}
    ${value}=  Execute javascript  return ${expression};
    Should be equal as strings  ${value}  ${expected}
