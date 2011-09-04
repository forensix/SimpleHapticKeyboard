include theos/makefiles/common.mk

TWEAK_NAME = SimpleHapticKeyboard
SimpleHapticKeyboard_FILES = Tweak.xm
SimpleHapticKeyboard_FRAMEWORKS = UIKit AudioToolbox

include $(THEOS_MAKE_PATH)/tweak.mk
