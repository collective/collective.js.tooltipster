# -*- coding: utf-8 -*-


def isNotCurrentProfile(context, marker="marker"):
    filename = "collectivejstooltipster_{}.txt".format(marker)
    return context.readDataFile(filename) is None


def post_install(context):
    """Post install script"""
    if isNotCurrentProfile(context):
        return
    # Do something during the installation of this package


def test_fixture(context):
    """Test fixture setup"""
    if isNotCurrentProfile(context, "testing"):
        return
    # Do something for test fixture
