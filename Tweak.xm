#import <AudioToolbox/AudioToolbox.h>

%hook UIKeyboard

-(id)hitTest:(CGPoint)test withEvent:(id)event
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    return %orig;
}


%end