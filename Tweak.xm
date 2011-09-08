#import <AudioToolbox/AudioToolbox.h>

#define AUDIO_TOOLBOX_PATH \
"/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox"

typedef void (*asss)(SystemSoundID inSystemSoundID);
static asss stop; 
    
%hook UIKeyboard
%new(@@:)
- (void)__AudioServicesStopSystemSound
{
    stop(kSystemSoundID_Vibrate);
}

- (id)hitTest:(CGPoint)test withEvent:(id)event
{
    void *libHandle
    = dlopen(AUDIO_TOOLBOX_PATH, RTLD_LAZY);
    
    *(void **)(&stop)
    = dlsym(libHandle, "AudioServicesStopSystemSound");
    if (!stop) {return %orig; }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    SEL sel = @selector(__AudioServicesStopSystemSound);
    [self performSelector:sel withObject:nil afterDelay:.05f];

    dlclose(libHandle);
    return %orig;
}

%end