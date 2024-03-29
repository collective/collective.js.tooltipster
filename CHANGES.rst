Changelog
=========


1.9 (unreleased)
----------------

- Nothing changed yet.


1.8 (2024-02-08)
----------------

- Added `arrow` option in `tooltipster_helper`.
  [sgeulette]

1.7 (2022-03-22)
----------------

- Added new optional parameters for `tooltipster_helper` : `functionPosition_callback`,
  this let's manage tooltipster position manually.
  [gbastien]

1.6 (2022-02-14)
----------------

- Added `passInstanceToCallback` option to be able to pass the tooltipster
  instance to the `functionReady` callback.
  [gbastien]

1.5 (2022-01-03)
----------------

- Fixed default `zIndex` from `9995` to `11000` so it works correctly
  when displayed in an overlay.
  [gbastien]

1.4 (2019-09-12)
----------------

- Set `async:true` for ajax request when no `functionReady_callback` provided.
  [gbastien]
- By default, make `click/tap/mouseenter` open a `tooltipster` and
  `click/tap/mouseleave` close it. This makes it useable on mobile devices.
  [gbastien]

1.3 (2019-05-16)
----------------

- Set `async: false` for the JS ajax query so we are sure that content is loaded
  when `functionReady` is called.
  [gbastien]
- Set default `zIndex` to `9995` so it behaves correctly with
  `jQuery Tools` overlays.
  [gbastien]
- Take into account options `minWidth` and `maxWidth` when initializing
  the tooltipster.
  [gbastien]

1.2 (2018-04-20)
----------------

- Added new optional parameters for `tooltipster_helper` : `zIndex` and
  `functionReady_callback`, this last parameter is a JS function that will be
  called in the `tooltipster.functionReady` function.
  [gbastien]
- Display `...` instead `Loading...` when loading the tooltipster so it is
  compatible with every languages.
  [gbastien]
- Added new optional parameters for `tooltipster_helper` : `triggerOpen` and
  `triggerClose` to use together with `trigger: 'custom'`.  Added also
  optional parameter `close_other_tips` that if set to `true` will close every
  other opened tooltips.
  [gbastien]

1.1 (2018-02-20)
----------------

- In `tooltipster_helper`, set `updateAnimation` to `fade` by default,
  moreover parameter `speed` does not exist anymore, it is replaced by
  `animationDuration`.
  [gbastien]
- Bugfix upgrade to 2000 by re-applying the `cssregistry` step.
  [gbastien]


1.0 (2018-02-14)
----------------

- Moved to `tooltipster` 4.2.6.
  [gbastien]
- Added `tooltipster_helper` method to ease use of `tooltipster`.
  [gbastien]


0.1 (2016-09-22)
----------------

- Initial release.
  [gbastien]

