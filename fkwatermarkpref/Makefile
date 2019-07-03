include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e

BUNDLE_NAME = fkwatermarkPref
fkwatermarkPref_FILES = XXXRootListController.m
fkwatermarkPref_INSTALL_PATH = /Library/PreferenceBundles
fkwatermarkPref_FRAMEWORKS = UIKit
fkwatermarkPref_PRIVATE_FRAMEWORKS = Preferences


$(BUNDLE_NAME)_LDFLAGS =  -F/opt/theos/sdks/iPhoneOS9.3.sdk/System/Library/PrivateFrameworks

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/fkwatermarkPref.plist$(ECHO_END)
