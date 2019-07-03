GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
ARCHS = arm64 arm64e
TARGET = iphone:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = fkwatermark
fkwatermark_FILES = Tweak.xm 
$(TWEAK_NAME)_CXXFLAGS = -stdlib=libc++ -std=c++11 
$(TWEAK_NAME)_LDFLAGS = -stdlib=libc++ -std=c++11 -F/opt/theos/sdks/iPhoneOS9.3.sdk/System/Library/PrivateFrameworks

SUBPROJECTS += fkwatermarkpref


include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"




