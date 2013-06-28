//========================================================================================
//
//========================================================================================

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "JsDirectoryTableViewDelegate.h"

int JsApplicationMain(int argc, const char **argv);

@interface JsApplication : NSApplication
{
	bool shouldKeepRunning;
}

@property JsDirectoryTableViewDelegate *_currentSourceTableViewDelegate;

- (void)run;
- (void)terminate:(id)sender;

@end


