//========================================================================================
//
//========================================================================================

#define INT8		int8_t
#define INT16		int16_t
#define INT32		int32_t
#define UINT8		uint8_t
#define UINT16		uint16_t
#define UINT32		uint32_t
#define BYTE		unsigned char


#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "JsAppDelegate.h"

int main(int argc, char *argv[])
{
	@autoreleasepool
	{
		//NSLog(@"0123456789 .... init OK !");
		[NSApplication sharedApplication];
		[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
		auto *appDelegate = [JsAppDelegate new];
		[NSApp setDelegate:appDelegate];
		[NSApp run];
		return (1);
	}
}

 

