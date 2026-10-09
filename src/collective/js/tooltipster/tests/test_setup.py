# -*- coding: utf-8 -*-
"""Setup tests for this package."""
from collective.js.tooltipster.interfaces import ICollectiveJsTooltipsterLayer
from collective.js.tooltipster.testing import COLLECTIVE_JS_TOOLTIPSTER_INTEGRATION_TESTING  # noqa
from plone.base.interfaces import IBundleRegistry
from plone.base.utils import get_installer
from plone.browserlayer import utils
from plone.registry.interfaces import IRegistry
from zope.component import getUtility

import unittest


RESOURCE = "++resource++collective.js.tooltipster/"
THEMES = ("borderless", "light", "noir", "punk", "shadow")


class TestSetup(unittest.TestCase):
    """Test that collective.js.tooltipster is properly installed."""

    layer = COLLECTIVE_JS_TOOLTIPSTER_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer["portal"]
        self.installer = get_installer(self.portal)

    def bundles(self):
        """Bundles of the package, by name"""
        bundles = getUtility(IRegistry).collectionOfInterface(IBundleRegistry, prefix="plone.bundles", check=False)
        return {name: bundle for name, bundle in bundles.items() if name.startswith("collective.js.tooltipster.")}

    def test_product_installed(self):
        """Test if collective.js.tooltipster is installed."""
        self.assertTrue(self.installer.is_product_installed("collective.js.tooltipster"))

    def test_static_files(self):
        """Every static file is published as a resource"""
        names = ["tooltipster.bundle.min.js", "tooltipster.bundle.min.css", "tooltipster_helper.js"]
        names += ["tooltipster-sideTip-{}.min.css".format(theme) for theme in THEMES]
        for name in names:
            self.assertIsNotNone(self.portal.restrictedTraverse(RESOURCE + name), name)

    def test_bundles(self):
        """The tooltipster library (js + css) and the helper are loaded on every page"""
        bundles = self.bundles()
        base = bundles["collective.js.tooltipster.base"]
        self.assertEqual(
            (base.enabled, base.jscompilation, base.csscompilation, base.depends, base.load_async, base.load_defer),
            (True, RESOURCE + "tooltipster.bundle.min.js", RESOURCE + "tooltipster.bundle.min.css", "plone", False,
             False),
        )
        helper = bundles["collective.js.tooltipster.helper"]
        self.assertEqual(
            (helper.enabled, helper.jscompilation, helper.csscompilation, helper.depends, helper.load_async,
             helper.load_defer),
            (True, RESOURCE + "tooltipster_helper.js", None, "plone", False, False),
        )

    def test_theme_bundles(self):
        """The 5 theme stylesheets are loaded on every page"""
        bundles = self.bundles()
        for theme in THEMES:
            bundle = bundles["collective.js.tooltipster.{}theme".format(theme)]
            self.assertEqual(
                (bundle.enabled, bundle.jscompilation, bundle.csscompilation, bundle.depends),
                (True, None, RESOURCE + "tooltipster-sideTip-{}.min.css".format(theme), "plone"),
                theme,
            )

    def test_uninstall(self):
        """Test if collective.js.tooltipster is cleanly uninstalled."""
        self.assertEqual(len(self.bundles()), 7)
        self.installer.uninstall_product("collective.js.tooltipster")
        self.assertFalse(self.installer.is_product_installed("collective.js.tooltipster"))
        self.assertEqual(self.bundles(), {})
        self.assertNotIn(ICollectiveJsTooltipsterLayer, utils.registered_layers())

    def test_browserlayer(self):
        """Test that ICollectiveJsTooltipsterLayer is registered."""
        self.assertIn(ICollectiveJsTooltipsterLayer, utils.registered_layers())
