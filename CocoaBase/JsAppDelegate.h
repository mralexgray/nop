//========================================================================================
//
//========================================================================================

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface JsAppDelegate : NSObject <NSApplicationDelegate>
{
@private
	NSTextView *_consoleView;
}

@property (strong) NSWindow *window;
@end
