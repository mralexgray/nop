//========================================================================================
//
//========================================================================================

#import <Cocoa/Cocoa.h>

#import "JsApplication.h"

int JsApplicationMain(int argc, const char **argv)
{
	return 0;
}

@implementation JsApplication

- (void)run
{
	 //	[self finishLaunching];
	 [[NSNotificationCenter defaultCenter] postNotificationName:NSApplicationWillFinishLaunchingNotification object:NSApp];
	 [[NSNotificationCenter defaultCenter] postNotificationName:NSApplicationDidFinishLaunchingNotification object:NSApp];
	 
	 shouldKeepRunning = YES;
	 do
	 {
	 	NSEvent *event = [self nextEventMatchingMask:NSAnyEventMask untilDate:[NSDate distantFuture] inMode:NSDefaultRunLoopMode dequeue:YES];
		[self sendEvent:event];
	 	[self updateWindows];
	 } while (shouldKeepRunning);

}

- (void)terminate:(id)sender
{
	 shouldKeepRunning = NO;
}

@end

