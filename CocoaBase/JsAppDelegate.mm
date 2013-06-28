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


#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <AppKit/NSLayoutConstraint.h>
#import "WebKit/WebKit.h"
#import <objc/runtime.h>
#include <string>
#include <iostream>

#include <sys/sysctl.h>

#import "Utilities.h"
#import "JsAppDelegate.h"
#import "JsDirectoryTableViewDelegate.h"
#import "JsCustomButtonCell.h"
#import "JsToolbarDelegate.h"

@implementation JsAppDelegate

@synthesize window;

JsDirectoryTableViewDelegate *leftDirectoryTableViewDelegate = nil;
JsDirectoryTableViewDelegate *rightDirectoryTableViewDelegate = nil;
NSTableView *currentDirectoryTableView = nil;
NSTableView *leftDirectoryTableView = nil;
NSTableView *rightDirectoryTableView = nil;
//JsCustomButtonCell *customButtonCell = nil;

int SysctlCallReturnInteger(int Argument1, int Argument2)
{
	int mib[6];
	int DataToBeGathered;
	size_t SizeOfDataToBeGathered = sizeof(DataToBeGathered);
	int Error = 0;
	
	mib[0] = Argument1;
	mib[1] = Argument2;
	
	Error = sysctl(mib, 2, &DataToBeGathered,
								 &SizeOfDataToBeGathered, NULL, 0);
	
	if (Error != 0)
	{
		return(-1);
	}
	
	return(DataToBeGathered);
}

void BindTextFieldToCurrentDirectory(NSTextField* paramTextField, JsDirectoryTableViewDelegate* paramDirectoryTableViewDelegate)
{
	//This synchronises/binds these two together:
	//The `value` key on the object `paramTextField`
	//The `address` key on the object `leftDirectoryTableViewDelegate`
	[paramTextField bind:@"value" toObject:paramDirectoryTableViewDelegate withKeyPath:@"address" options:nil];
}

void runSystemCommand(NSString *cmd)
{
	[[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c", cmd, nil]] waitUntilExit];
}
//------------------------------------------------------
void runScript(NSString *scriptName)
{
	NSTask *task;
	task = [[NSTask alloc] init];
	[task setLaunchPath: @"/bin/sh"];
	
	NSArray *arguments;
	NSString* newpath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] privateFrameworksPath], scriptName];
	NSLog(@"shell script path: %@",newpath);
	arguments = [NSArray arrayWithObjects:newpath, nil];
	[task setArguments: arguments];
	
	NSPipe *pipe;
	pipe = [NSPipe pipe];
	[task setStandardOutput: pipe];
	
	NSFileHandle *file;
	file = [pipe fileHandleForReading];
	
	[task launch];
	
	NSData *data;
	data = [file readDataToEndOfFile];
	
	NSString *string;
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	NSLog (@"script returned:\n%@", string);
}
//------------------------------------------------------

// ==============================================================================================
// 
// ==============================================================================================
- (void) onEventEchoToConsole:(NSNotification *)notification
{
 	//id unObjetOuNil = notification.object;
	if (_consoleView !=Nil)
	{
		[[[_consoleView textStorage] mutableString] appendString:notification.object];
		// go to end of text field
		NSRange range;
    range = NSMakeRange ([[_consoleView string] length], 0);
    [_consoleView scrollRangeToVisible: range];
	}
}



// ==============================================================================================
//
// ==============================================================================================
-(void)windowDidMakeFirstResponder:(id) sender
{
		NSString *notificationName = [sender name];
		if ([notificationName hasPrefix:@"NSTable"])
		{
			NSString *senderIdentifier = [sender identifier];
			//NSString *notificationMessage = [sender message];
			//NSLog(@"\nnotification : %@=>%@",senderIdentifier, notificationName);
			//NSLog(@"\nsender : %@", senderIdentifier);
			NSLog(@"\nnotification : %@", notificationName);
			//NSLog(@"\nmessage : %@", notificationMessage);
		}
		else
		{
			//NSLog(@"\nnotification : %@", notificationName);
		}
}


// ==============================================================================================
//
// ==============================================================================================
-(void)notificationProcessor:(id) sender
{
//	NSString *notificationName = [sender name];
//	if ([notificationName hasPrefix:@"NSTable"])
//	{
//		NSString *senderIdentifier = [sender identifier];
//		//NSString *notificationMessage = [sender message];
//		//NSLog(@"\nnotification : %@=>%@",senderIdentifier, notificationName);
//		//NSLog(@"\nsender : %@", senderIdentifier);
//		NSLog(@"\nnotification : %@", notificationName);
//		//NSLog(@"\nmessage : %@", notificationMessage);
//	}
//	else
//	{
//		//NSLog(@"\nnotification : %@", notificationName);
//	}
}
	
	
	
// ==============================================================================================
//
// ==============================================================================================
-(void)actionProcessor:(id) sender
{
	//NSLog(@"double Clicked : %d", [self clickedRow]);
	const char *className = class_getName([sender class]);
	//NSLog(@"yourObject is a: %s", className);

/*
 –numberOfSelectedRows
 
 –selectedRowIndexes "returns an index set containing the indexes of the selected rows"
*/
 
	NSString *senderIdentifier = [sender identifier];
	NSString *string = [[NSString alloc] initWithCString:className encoding:NSMacOSRomanStringEncoding];

	//if ([senderIdentifier isEqualToString:@"rightDirectoryTableViewDelegate"] || [senderIdentifier isEqualToString:@"leftDirectoryTableViewDelegate"])
	//{
	//	currentDirectoryTableView = leftDirectoryTableView;
	//}
	
	//if ([[sender message] isEqualToString:@"tableViewSelectionDidChange"])
	//{
		//currentDirectoryTableView = [sender object];
		//currentDirectoryTableView = leftDirectoryTableView;
	//}
	
	
	if ([senderIdentifier isEqualToString:@"leftTableButton"] || [senderIdentifier isEqualToString:@"rightTableButton"])
	{
		//if ([senderIdentifier isEqualToString:@"rightTableButton"]) currentDirectoryTableView = rightDirectoryTableView;
		//if ([senderIdentifier isEqualToString:@"leftTableButton"]) currentDirectoryTableView = leftDirectoryTableView;

		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"================================="];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"\ndouble click\n"];
		
		NSTableView *currentTableView = sender;
		
		NSInteger clickedRow = currentTableView.clickedRow;
		NSInteger clickedColumn = currentTableView.clickedColumn ;
		NSTableColumn *tableColumn = [currentTableView tableColumnWithIdentifier:@"FileName"];
		
		NSString *fileName = [currentTableView.dataSource tableView:currentTableView objectValueForTableColumn:tableColumn row:clickedRow];
		
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"ligne numero : %ld : %@\n", clickedRow, fileName]];

		auto dataSource = (JsDirectoryTableViewDelegate *) currentTableView.dataSource;
		auto path = dataSource._currentDirectoryPath;
		auto clickedFilePath = [path stringByAppendingPathComponent:fileName];
		
		BOOL isDir;
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:clickedFilePath isDirectory:&isDir] &&isDir)
		{
			[dataSource setCurrentDirectoryPath:clickedFilePath];
			[currentTableView reloadData];
		}
		else
		{
			std::string command = "open ";
			std::string commandLine = command + [clickedFilePath UTF8String];;
			//[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"commande : %@\n", fileName]];
			//runScript(@"say bonjour");
			//runScript(@"open /Users/tungsten/Desktop/listeLisbOSX.txt");
			//	system("open /Users/tungsten/Desktop/listeLisbOSX.txt");	// execute a command but without return code
			system(commandLine.c_str());	// execute a command but without return code
		}
	}
	else
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"\nclick\n"];

		if ([senderIdentifier isEqualToString:@"parent"])
		{
			//currentDirectoryTableView = leftDirectoryTableView;
			if ([window firstResponder] == leftDirectoryTableView)
			{
				currentDirectoryTableView = leftDirectoryTableView;
			}
			else
			{
				currentDirectoryTableView = rightDirectoryTableView;
			}
				
			
			auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
			[dataSource setCurrentDirectoryPath:[dataSource._currentDirectoryPath stringByDeletingLastPathComponent]];
			[currentDirectoryTableView reloadData];
		}
		else if ([senderIdentifier isEqualToString:@"openWin"])
		{
			//auto numberOfSelectedRows = currentTableView.numberOfSelectedRows ;
			auto indexSet = [currentDirectoryTableView selectedRowIndexes];

			
			
			NSString *selectedFileName = [currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:indexSet.firstIndex];
			
			auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
			auto path = dataSource._currentDirectoryPath;
			NSString *selectedFilePath = [path stringByAppendingPathComponent:selectedFileName];
			BOOL isDir;
			if ([[NSFileManager defaultManager] fileExistsAtPath:selectedFilePath isDirectory:&isDir] &&isDir)
			{
				std::string command = "open '";
				std::string commandLine = command + [selectedFilePath UTF8String] + "'";
				system(commandLine.c_str());	// execute a command but without return code
			}
		}
		else if ([senderIdentifier isEqualToString:@"read"])
		{
			//auto numberOfSelectedRows = currentTableView.numberOfSelectedRows ;
			auto indexSet = [currentDirectoryTableView selectedRowIndexes];
			NSString *selectedFileName = [currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:indexSet.firstIndex];
			auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
			auto path = dataSource._currentDirectoryPath;
			auto filePath = [path stringByAppendingPathComponent:selectedFileName];
			//[[NSTask launchedTaskWithLaunchPath:@"/Applications/Eddie.app/Contents/MacOS/Eddie" arguments:[NSArray arrayWithObjects:filePath, nil]] waitUntilExit];
			[NSTask launchedTaskWithLaunchPath:@"/Applications/Eddie.app/Contents/MacOS/Eddie" arguments:[NSArray arrayWithObjects:filePath, nil]];

		}
		else if ([senderIdentifier isEqualToString:@"edit"])
		{
			//auto numberOfSelectedRows = currentTableView.numberOfSelectedRows ;
			auto indexSet = [currentDirectoryTableView selectedRowIndexes];
			NSString *selectedFileName = [currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:indexSet.firstIndex];
			auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
			auto path = dataSource._currentDirectoryPath;
			auto filePath = [path stringByAppendingPathComponent:selectedFileName];
			//[[NSTask launchedTaskWithLaunchPath:@"/Applications/Eddie.app/Contents/MacOS/Eddie" arguments:[NSArray arrayWithObjects:filePath, nil]] waitUntilExit];
			//[NSTask launchedTaskWithLaunchPath:@"/Applications/TextWrangler.app/Contents/MacOS/TextWrangler" arguments:[NSArray arrayWithObjects:filePath, nil]];
			[NSTask launchedTaskWithLaunchPath:@"/Applications/TextEdit.app/Contents/MacOS/TextEdit" arguments:[NSArray arrayWithObjects:filePath, nil]];
			
		}
		else if ([senderIdentifier isEqualToString:@"show"])
		{
			//auto numberOfSelectedRows = currentTableView.numberOfSelectedRows ;
			auto indexSet = [currentDirectoryTableView selectedRowIndexes];
			NSString *selectedFileName = [currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:indexSet.firstIndex];
			auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
			auto path = dataSource._currentDirectoryPath;
			auto filePath = [path stringByAppendingPathComponent:selectedFileName];
			//[[NSTask launchedTaskWithLaunchPath:@"/Applications/Eddie.app/Contents/MacOS/Eddie" arguments:[NSArray arrayWithObjects:filePath, nil]] waitUntilExit];
			[NSTask launchedTaskWithLaunchPath:@"/Applications/Preview.app/Contents/MacOS/Preview" arguments:[NSArray arrayWithObjects:filePath, nil]];			
		}
		else if ([senderIdentifier isEqualToString:@"calc"])
		{
			[NSTask launchedTaskWithLaunchPath:@"/Applications/Calculator.app/Contents/MacOS/Calculator" arguments:[NSArray arrayWithObjects: nil]];
		}
		else
		{
			//auto numberOfSelectedRows = currentTableView.numberOfSelectedRows ;
			auto indexSet = [currentDirectoryTableView selectedRowIndexes];
			auto numberOfSelectedRows = indexSet.count;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"nb selections : %ld\n", numberOfSelectedRows]];
			[indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop)
			 {
				 NSString *selectedFileName = [currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:index];
				 auto dataSource = (JsDirectoryTableViewDelegate *) currentDirectoryTableView.dataSource;
				 auto path = dataSource._currentDirectoryPath;
				 NSString *selectedFilePath = [path stringByAppendingPathComponent:[currentDirectoryTableView.dataSource tableView:currentDirectoryTableView objectValueForTableColumn:nil row:index]];
				 
				 [[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"Selection : %ld : %@\n", index, selectedFilePath]];
			 }];
		}
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:string];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@" => "];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:senderIdentifier];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"\n"];
	
	
	
}


// ==============================================================================================
// programmatically create Image
// ==============================================================================================
- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView
{
  auto *ctx = [NSGraphicsContext currentContext];
  auto contextRef = [ctx graphicsPort];
  
  NSData *data = [image TIFFRepresentation]; // open for suggestions
  CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)CFBridgingRetain(data), NULL);
  if(source)
	{
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CFRelease(source);
    
    // Draw shadow 1px below image
    
    //CGContextSaveGState(contextRef);
    {
      NSRect rect = NSOffsetRect(frame, 0.0f, 1.0f);
      //CGFloat white = [self isHighlighted] ? 0.2f : 0.35f;
      //CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
      //[[NSColor colorWithDeviceWhite:white alpha:1.0f] setFill];
      NSRectFill(rect);
    }
    //CGContextRestoreGState(contextRef);
    
    // Draw image
    
    //CGContextSaveGState(contextRef);
    {
      NSRect rect = frame;
      //CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
      [[NSColor colorWithDeviceWhite:0.1f alpha:1.0f] setFill];
      NSRectFill(rect);
    }
    //CGContextRestoreGState(contextRef);
    
    CFRelease(imageRef);
  }
}


// ==============================================================================================
// programmatically create button
// ==============================================================================================
- (NSButton *)addPushButtonWithTitle:(NSString *)title identifier:(NSString *)identifier superView:(NSView *)superview
{
	JsCustomButtonCell *customButtonCell = [JsCustomButtonCell new];

	auto *pushButton = [NSButton new];
	[pushButton setIdentifier:identifier];
//	[pushButton setBezelStyle:NSRoundRectBezelStyle];
	//[pushButton setBezelStyle:NSRegularSquareBezelStyle];
	//[pushButton setBezelStyle:NSThickSquareBezelStyle];
//	[pushButton setBezelStyle:NSThickerSquareBezelStyle];
	//[pushButton setShowsBorderOnlyWhileMouseInside:YES];
	//[pushButton setAllowsMixedState:YES];
	//[pushButton setState:NSOffState]; // NSOnState NSOffState NSMixedState
	//[[pushButton cell] setGradientType:NSGradientConcaveWeak];	//	NSGradientNone NSGradientConcaveWeak NSGradientConcaveStrong NSGradientConvexWeak NSGradientConvexStrong
//	[pushButton setFont:[NSFont systemFontOfSize:12.0]];

	[pushButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[pushButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[pushButton setBordered:NO];
	[pushButton setCell:customButtonCell];
	[superview addSubview:pushButton];
	
	//NSAttributedString *attrStr;
	//NSString *htmlString;
	//htmlString=@"<html><head></head><body><u>underlined </u><i>italics</i></body></html>";
	//[attrStr initWithHTML:[htmlString dataUsingEncoding:NSASCIIStringEncoding] documentAttributes:NULL];
	//[pushButton lockFocus];
	//[attrStr drawAtPoint:NSMakePoint(0.0, 0.0)];
	//if (title) [pushButton setAttributedTitle:attrStr];

	
	//if ([title hasPrefix:@"<html>"])
	if ([title hasPrefix:@"<"])
	{
		//NSString *myHTMLString = [NSString initWithContentsOfURL:[NSURL URLWithString:url]] ;
		auto myStringData = [title dataUsingEncoding:NSUTF8StringEncoding];
		auto attributedTitle = [[NSAttributedString alloc] initWithHTML:myStringData documentAttributes:nil];
		[pushButton setAttributedTitle:attributedTitle];
		[pushButton setAttributedStringValue:attributedTitle];
	}
	else
	{
		if (title) [pushButton setTitle:title];
	}
	
	[pushButton setTarget:self];
	//[pushButton setAction:@selector(shuffleTitleOfSender:)];
	[pushButton setAction:@selector(actionProcessor:)];	// action method
	[pushButton setTarget:self];	// target class ??
	
	return pushButton;
}


// ==============================================================================================
// programmatically create button
// ==============================================================================================
NSButton *cppAddPushButtonWithTitle(NSString *title, NSString *identifier, NSView *superview)
{
	auto *pushButton = [NSButton new];
	[pushButton setIdentifier:identifier];
	
	//[pushButton setBezelStyle:NSRoundRectBezelStyle];
	//[pushButton setBezelStyle:NSRegularSquareBezelStyle];
	//[pushButton setBezelStyle:NSThickSquareBezelStyle];
	//[pushButton setBezelStyle:NSThickerSquareBezelStyle];
	[pushButton setFont:[NSFont systemFontOfSize:12.0]];
	[pushButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[pushButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[superview addSubview:pushButton];
	
	//NSAttributedString *attrStr;
	//NSString *htmlString;
	//htmlString=@"<html><head></head><body><u>underlined </u><i>italics</i></body></html>";
	//[attrStr initWithHTML:[htmlString dataUsingEncoding:NSASCIIStringEncoding] documentAttributes:NULL];
	//[pushButton lockFocus];
	//[attrStr drawAtPoint:NSMakePoint(0.0, 0.0)];
	//if (title) [pushButton setAttributedTitle:attrStr];
	if (title) [pushButton setTitle:title];
	
	//[pushButton setTarget:self];
	[pushButton setTarget:superview];
	//[pushButton setAction:@selector(shuffleTitleOfSender:)];
	
	return pushButton;
}





// ==============================================================================================
// programmatically create button
// ==============================================================================================
- (NSButton *)addSizeablePushButtonWithTitle:(NSString *)title identifier:(NSString *)identifier superView:(NSView *)superview
{
	auto *pushButton = [NSButton new];
	[pushButton setIdentifier:identifier];

	//NSURL *imageURL = [NSURL URLWithString:@"http://behance.vo.llnwd.net/profiles4/150107/projects/441177/1501071267763787.png"];
	NSURL *upImageURL = [NSURL URLWithString:@"http://www.techlogica.us/images/stock/icons/free/48_button_blue.png"];
	NSData *upImageData = [upImageURL resourceDataUsingCache:NO];
	NSImage *upImage = [[NSImage alloc] initWithData:upImageData];

	NSURL *downImageURL = [NSURL URLWithString:@"http://www.techlogica.us/images/stock/icons/free/48_button_red.png"];
	NSData *downImageData = [downImageURL resourceDataUsingCache:NO];
	NSImage *downImage = [[NSImage alloc] initWithData:downImageData];
	
	[pushButton setImage:upImage];
	[pushButton setAlternateImage:downImage] ;
	//[pushButton setImagePosition:NSImageOnly];
	[pushButton setBordered:NO];
	//[pushButton.cell setImageScaling:NSImageScaleProportionallyDown];
	//[pushButton.cell setImageScaling:NSImageScaleAxesIndependently];

	
	//[pushButton setBezelStyle:NSRoundRectBezelStyle];
	//[pushButton setBezelStyle:NSRegularSquareBezelStyle];
	//[pushButton setBezelStyle:NSThickSquareBezelStyle];
	//[pushButton setBezelStyle:NSThickerSquareBezelStyle];
	[pushButton setFont:[NSFont systemFontOfSize:12.0]];
	[pushButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	//[pushButton setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
	//[pushButton setAutoresizingMask:NSViewMaxXMargin|NSViewHeightSizable];
	[pushButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[superview addSubview:pushButton];
	
	
	if (title) [pushButton setTitle:title];
	
	[pushButton setTarget:self];
	//[pushButton setAction:@selector(shuffleTitleOfSender:)];
	
	return pushButton;
}

// ==============================================================================================
// programmatically create text field.
// ==============================================================================================
- (NSTextField *)addTextFieldWithContent:(NSString *)content identifier:(NSString *)identifier superView:(NSView *)superview {
	auto *textField = [NSTextField new];
	[textField setIdentifier:identifier];
	[[textField cell] setControlSize:NSSmallControlSize];
	[textField setBordered:YES];
	[textField setBezeled:YES];
	[textField setSelectable:YES];
	[textField setEditable:YES];
	[textField setFont:[NSFont systemFontOfSize:11.0]];
	[textField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[textField setTranslatesAutoresizingMaskIntoConstraints:NO];
	NSColor* baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha: 1];
	[textField setBackgroundColor:baseColor];
	if ([content hasPrefix:@"<"])
	{
		//NSString *myHTMLString = [NSString initWithContentsOfURL:[NSURL URLWithString:url]] ;
		auto myStringData = [content dataUsingEncoding:NSUTF8StringEncoding];
		auto attributedContent = [[NSAttributedString alloc] initWithHTML:myStringData documentAttributes:nil];
		//[textField setAllowsEditingTextAttributes:YES];
		[textField setAttributedStringValue:attributedContent];
	}
	else
	{
		if (content) [textField setStringValue:content];
	}	
	
	[superview addSubview:textField];
	return textField;
}

// ==============================================================================================
// programmatically create text view.
// ==============================================================================================
NSTextView *addTextViewWithidentifier(NSString *identifier, NSView *superview)
{
	NSString *myHTMLString = @"<html><a href=\"http://www.dalloz.fr\">my_label</a> <p><U>Hello</U></p><p><B>World</B></p> !</html>" ;
	
	//NSString *myHTMLString = [NSString initWithContentsOfURL:[NSURL URLWithString:url]] ;
	NSData *myData = [myHTMLString dataUsingEncoding:NSUTF8StringEncoding];
	NSAttributedString *textToBeInserted = [[NSAttributedString alloc] initWithHTML:myData documentAttributes:nil];

	
	auto *textView = [NSTextView new];
	[textView setIdentifier:identifier];
	[textView.textStorage setAttributedString:textToBeInserted];
	
	textView.insertionPointColor = [NSColor redColor];
	textView.textColor = [NSColor whiteColor];
	textView.backgroundColor = [NSColor blackColor];
	
	for (UINT32 i=0; i<5; i++)
	{
		[[[textView textStorage] mutableString] appendString: @"<HTML>VLA MON <B>TEXT</B>\n</HTML>"];
	}
	
//	[textView setMinSize:NSMakeSize(600.0, 600.0)];
//	[textView setMaxSize:NSMakeSize(1000.0, 2000.0)];
	[textView setSelectable:YES];
	[textView setEditable:YES];
	
	//[textView setVerticallyResizable:NO];
	[textView setHorizontallyResizable:NO];
//	[textView setAutoresizingMask:NSViewWidthSizable];
	
	//[textView setFont:[NSFont systemFontOfSize:8.0]];
	[[textView textStorage] setFont:[NSFont fontWithName:@"Monaco" size:9]];
	//[textView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
//	[textView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinYMargin|NSViewMinXMargin];
//	[textView setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	
	//[[textView enclosingScrollView] setHasHorizontalScroller:YES];
	[textView setHorizontallyResizable:YES];
	//[textView setVerticallyResizable:NO];
	//[textView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
//	[[textView textContainer] setContainerSize:NSMakeSize(600.0, 600.0)];
	//[[textView textContainer] setWidthTracksTextView:NO];
	
	
	
	[superview addSubview:textView];
	return textView;
}

// ==============================================================================================
// programmatically create VebView.
// ==============================================================================================
WebView *addWebViewWithidentifier(NSString *identifier, NSView *superview)
{
	NSString *myHTMLString = @"<html><a href=\"http://www.dalloz.fr\">my_label</a> <p><U>Hello</U></p><p><B>World</B></p> !</html>" ;
	
	//NSString *myHTMLString = [NSString initWithContentsOfURL:[NSURL URLWithString:url]] ;
//	NSData *myData = [myHTMLString dataUsingEncoding:NSUTF8StringEncoding];
//	NSAttributedString *textToBeInserted = [[NSAttributedString alloc] initWithHTML:myData documentAttributes:nil];
	
	
	//auto *webView = [WebView new];
	auto webView = [[WebView alloc] initWithFrame:[[[superview window] contentView] bounds] frameName:nil groupName:nil];
	[webView setIdentifier:identifier];
	//auto *webView = [[WebView alloc] initWithFrame: frameName:@"webframe" groupName:@"webgroup"];
	
	//NSString *urlText = @"http://www.apple.com";
	NSString *urlText = @"http://elstatic.weborama.fr/adperf/316585/21475/201208/1344861176_728x90.gif";
	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
	
	
	//[[main_browser mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"file:///Volumes/AA/myfile.txt"]]];
	//[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
	//[self setSource:[[NSString alloc] initWithData:myData encoding:NSISOLatin1StringEncoding]];
	//[[webView mainFrame] loadHTMLString:myHTMLString baseURL:nil];
	
	//DOMDocument* d = [[webView mainFrame] DOMDocument];
	//[[[d getElementsByTagName:@"a"] item:0] click];
	
	//NSRect frame = NSMakeRect(0.0, 0.0, pageSize.width, pageSize.height);
	//NSWindow *window = [[NSWindow alloc] initWithContentRect:frame styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	
//	WebView *webView = [[WebView alloc] initWithFrame:frame frameName:@"Test Frame" groupName:nil];
//	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jenstechs.net/test/testpage.html"]]];
	
//	[superview setContentView:webView];
	

	while ([webView isLoading])
	{
		[webView setNeedsDisplay:NO];
		[NSApp nextEventMatchingMask:NSAnyEventMask untilDate:[NSDate dateWithTimeIntervalSinceNow:1.0] inMode:NSDefaultRunLoopMode dequeue:YES];
	}
	[webView setNeedsDisplay:YES];
	
	[webView setEditable:YES];
	[superview addSubview:webView];


  return webView;
}


// ==============================================================================================
// programmatically create TabItem.
// ==============================================================================================
- (NSTabViewItem *)addTabViewItemWithidentifier:(NSString *)identifier superView:(NSTabView *)superview
{
	auto *tabViewItem = [NSTabViewItem new];
	[tabViewItem setIdentifier:identifier];
	[tabViewItem setLabel:identifier];
	[superview addTabViewItem:tabViewItem];
	return tabViewItem;
}

// ==============================================================================================
// programmatically create TabView.
// ==============================================================================================
- (NSTabView *)addTabViewWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	
	NSUInteger resizeAllMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin);
	
	auto *tabView = [NSTabView new];
	[tabView setIdentifier:identifier];
	[tabView setAutoresizingMask:resizeAllMask];
	[tabView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[tabView needsDisplay];
	[tabView setTabViewType:NSBottomTabsBezelBorder];
	[tabView setControlTint:NSGraphiteControlTint];
	[superview addSubview:tabView];
	return tabView;
}

// ==============================================================================================
// programmatically create text field.
// ==============================================================================================
- (NSBox *)addBoxWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	
	NSUInteger resizeAllMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin);
	
	auto *box = [NSBox new];
	//auto *box = [[NSBox alloc] initWithFrame:[superview bounds]];
	[box setIdentifier:identifier];
	[box setAutoresizingMask:resizeAllMask];
	[box setTranslatesAutoresizingMaskIntoConstraints:NO];
	[box setBoxType:NSBoxPrimary];
	[box setBorderType:NSBezelBorder];
	[box setFillColor:[NSColor greenColor]];
	[box setBorderType:NSLineBorder];
	[box setBorderColor:[NSColor redColor]];
	[box setTitle:@"BBB"];
	
	//NSView *boxContentView = [[NSView alloc] initWithFrame:NSZeroRect];
	
	[superview addSubview:box];
	return box;
}

// ==============================================================================================
// programmatically create text field.
// ==============================================================================================
- (NSView *)addViewWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	auto *view = [NSView new];
	[view setIdentifier:identifier];
	[view setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	//CALayer *viewLayer = [CALayer layer];
	//[viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
	//[view setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
	//[view setLayer:viewLayer];
	
	[superview addSubview:view];
	return view;
}


// ==============================================================================================
// programmatically create table view.
// ==============================================================================================
- (NSTableView *)addTableViewWithidentifier:(NSString *)identifier superView:(NSView *)superview directoryTableViewDelegate:(JsDirectoryTableViewDelegate *)directoryTableViewDelegate
{
	NSColor *baseColor = [NSColor colorWithDeviceRed: 0.22 green: 0.24 blue: 0.27 alpha:1.0f];
	//NSColor *bgColor = [NSColor colorWithDeviceRed:49.0f/255.0f green:54.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	NSColor *bgColor = [NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
	
	
	//NSTableView *tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 320, 200)];
	NSTableView *tableView = [NSTableView new];
	[tableView setIdentifier:identifier];

	//NSColor *myColor = [NSColor colorWithCalibratedRed:0.7f green:0.7f blue:1.0f alpha:1.0f];
	//[tableView setBackgroundColor:myColor];
	//[tableView setGridStyleMask:NSTableViewGridNone];
	[tableView setGridStyleMask:NSTableViewGridNone];
	[tableView setAllowsTypeSelect:YES];
	[tableView setAllowsEmptySelection:NO];
	tableView.rowHeight = 16;
	
	
	// create columns for our table
	NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"FileName"];
	[[column1 headerCell] setStringValue:@"Name"];
	[column1 setEditable:YES];	// to allow double click
	[column1 setWidth:400];
	[tableView addTableColumn:column1];
	NSTableColumn * column2 = [[NSTableColumn alloc] initWithIdentifier:@"FileSize"];
	[[column2 headerCell] setStringValue:@"Size"];
	[column2 setEditable:NO];	// to allow double click
	[column2 setWidth:100];
	[tableView addTableColumn:column2];
	NSTableColumn * column3 = [[NSTableColumn alloc] initWithIdentifier:@"FileDate"];
	[[column3 headerCell] setStringValue:@"Date"];
	[column3 setEditable:NO];	// to allow double click
	[column3 setWidth:200];
	[tableView addTableColumn:column3];
	
	[tableView setAllowsMultipleSelection:YES];
	[tableView setDoubleAction:@selector(actionProcessor:)];
	//[tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
//	[tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
	
//	NSTableColumn * column3 = [[NSTableColumn alloc] initWithIdentifier:@"SizeCell"];
//	[[column3 headerCell] setStringValue:@"Date"];
//	[column3 setWidth:50];
//	[tableView addTableColumn:column3];
//	NSTableColumn * column4 = [[NSTableColumn alloc] initWithIdentifier:@"SizeCell"];
//	[[column4 headerCell] setStringValue:@"Attr"];
//	[column4 setWidth:50];
//	[tableView addTableColumn:column4];

	
	//JsDirectoryTableViewDelegate *directoryTableViewDelegate = [JsDirectoryTableViewDelegate new];
	//directoryTableViewDelegate = [JsDirectoryTableViewDelegate new];
	//[directoryTableViewDelegate setCurrentDirectoryPath:@"/Users/tungsten/Downloads"];
	[tableView setDelegate:directoryTableViewDelegate];
	[tableView setDataSource:directoryTableViewDelegate];
	//[tableView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinYMargin|NSViewMinXMargin];
	[tableView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[tableView setTranslatesAutoresizingMaskIntoConstraints:YES];
	[tableView setBackgroundColor:bgColor];
//	[tableView setGridColor:[NSColor yellowColor]];
	[tableView reloadData];
	[superview addSubview:tableView];
	//[leftScrollView setDocumentView:leftTableButton];
	return tableView;
}


// ==============================================================================================
// programmatically create table view.
// ==============================================================================================
- (NSToolbar *)addToolBarWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	auto toolbar = [[NSToolbar alloc] initWithIdentifier:identifier];
	return toolbar;
}

// ==============================================================================================
// programmatically create table view.
// ==============================================================================================
- (NSToolbarItem *)addToolBarItemWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	auto toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:identifier];
	return toolbarItem;
}


// ==============================================================================================
// programmatically create table view.
// ==============================================================================================
- (NSScrollView *)addScrollViewWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	NSUInteger resizeAllMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin);
	
	NSScrollView *scrollView = [NSScrollView new];
	[scrollView setIdentifier:identifier];
	//[scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinYMargin|NSViewMinXMargin];
	//[scrollView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[scrollView setAutoresizingMask:resizeAllMask];
	[scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[scrollView setHasVerticalScroller:YES];
	[scrollView setHasHorizontalScroller:YES];
	[scrollView setAutohidesScrollers:NO];
	[scrollView setBorderType:NSLineBorder];

	//	 NSLineBorder   = 1,
	//  NSBezelBorder  = 2,
	//   NSGrooveBorder = 3
	[scrollView setDrawsBackground:YES];
	[scrollView setBackgroundColor:[NSColor redColor]];
	
//	CALayer *viewLayer = [CALayer layer];
//	[viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
//	[scrollView setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
//	[scrollView setLayer:viewLayer];
	
	
	[superview addSubview:scrollView];
	return scrollView;
}



// ==============================================================================================
// programmatically create table view.
// ==============================================================================================
- (NSScrollView *)addScrollableTableViewWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
	
//	[[textField cell] setControlSize:NSSmallControlSize];
//	[textField setBordered:YES];
//	[textField setBezeled:YES];
//	[textField setSelectable:YES];
//	[textField setEditable:YES];
//	[textField setFont:[NSFont systemFontOfSize:11.0]];
//	[textField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
//	[textField setTranslatesAutoresizingMaskIntoConstraints:NO];
//	[superview addSubview:textField];
	

	// create a table view and a scroll view
	//NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 200, 300, 200)];
	NSScrollView *scrollView = [NSScrollView new];
	[scrollView setIdentifier:identifier];
	//NSTableView *tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 320, 200)];
	NSTableView *tableView = [NSTableView new];
	// create columns for our table
	NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"MainCell"];
		[[column1 headerCell] setStringValue:@"Name"];
		[column1 setWidth:252];
		[tableView addTableColumn:column1];
	NSTableColumn * column2 = [[NSTableColumn alloc] initWithIdentifier:@"SizeCell"];
		[[column2 headerCell] setStringValue:@"Size"];
		[column2 setWidth:100];
		[tableView addTableColumn:column2];
	NSTableColumn * column3 = [[NSTableColumn alloc] initWithIdentifier:@"SizeCell"];
		[[column3 headerCell] setStringValue:@"Date"];
		[column3 setWidth:50];
		[tableView addTableColumn:column3];
	NSTableColumn * column4 = [[NSTableColumn alloc] initWithIdentifier:@"SizeCell"];
		[[column4 headerCell] setStringValue:@"Attr"];
		[column4 setWidth:50];
		[tableView addTableColumn:column4];
	//[basicTableViewWindowController setCurrentDirectoryPath:@"/Users/tungsten/Downloads"];
	JsDirectoryTableViewDelegate *directoryTableViewDelegate = [JsDirectoryTableViewDelegate new];
	[tableView setDelegate:directoryTableViewDelegate];
	[tableView setDataSource:directoryTableViewDelegate];
	//[tableView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	//[tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[tableView reloadData];
	[scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinYMargin|NSViewMinXMargin];
	//[scrollView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	[scrollView setTranslatesAutoresizingMaskIntoConstraints:YES];
	[scrollView setDocumentView:tableView];
	[scrollView setHasVerticalScroller:YES];
	[superview addSubview:scrollView];


/*
	basicTableViewWindowController = [JsBasicTableViewWindowController new];
	NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(30, 30, 300, 300)];
	//NSScrollView *scrollView = [NSScrollView new];
	[scrollView setIdentifier:identifier];
	//NSScrollView *scrollView = [NSScrollView new];
	//NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:[superview.window.contentView bounds]];
	NSTableView *tableView = [[NSTableView alloc] initWithFrame:[scrollView bounds]];
	tableView.delegate = basicTableViewWindowController;
	tableView.dataSource = basicTableViewWindowController;
	
	NSTableColumn *columnOne = [[NSTableColumn alloc] initWithIdentifier:@"MainCell"];
	
	[columnOne setWidth:300];
	[tableView addTableColumn:columnOne];
	[tableView reloadData];
	[scrollView setDocumentView:tableView];
	[scrollView setHasVerticalScroller:YES];
	//[superview.window.contentView addSubview:scrollView];
	[superview addSubview:scrollView];
*/
		
	return scrollView;
}


/*
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	auto menu = [NSMenu new];
	[menu addItemWithTitle: @"Info" action: NULL keyEquivalent: @""];
	[menu addItemWithTitle: @"Hide" action: @selector(hide:) keyEquivalent: @"h"];
	[menu addItemWithTitle: @"Quit" action: @selector(terminate:) keyEquivalent: @"q"];
	auto info = [NSMenu new];
	[info addItemWithTitle: @"Info Panel..." action: @selector(orderFrontStandardInfoPanel:) keyEquivalent: @""];
	[info addItemWithTitle: @"Preferences" action: NULL keyEquivalent: @""];
	[info addItemWithTitle: @"Help" action: @selector (orderFrontHelpPanel:) keyEquivalent: @"?"];
	[menu setSubmenu: info forItem: [menu itemWithTitle:@"Info"]];
	[NSApp setMainMenu:menu];
		
	auto window = [[NSWindow alloc] initWithContentRect: NSMakeRect(300, 300, 200, 100) styleMask: (NSTitledWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask) backing: NSBackingStoreBuffered defer: YES];
	[window setTitle: @"Hello World"];
	
	auto label = [[NSTextField alloc] initWithFrame: NSMakeRect(30, 30, 80, 30)];
	[label setSelectable: NO];
	[label setBezeled: NO];
	[label setDrawsBackground: NO];
	[label setStringValue: @"Hello World"];
	
 [[window contentView] addSubview: label];
}
*/
- (NSMenu*) applicationDockMenu: (id) sender;
{
	/* allocate menu */
	NSMenu* result = [[NSMenu alloc] initWithTitle: @""];
	id item;
	
	/* add first sample item */
	item = [[NSMenuItem alloc] initWithTitle: @"First Sample Item" action: @selector(whatever:) keyEquivalent: @""];
	[item setImage: [NSImage imageNamed: @"PlayList"]];
	[result addItem: item];
	
	/* add separator */
	[result addItem: [NSMenuItem separatorItem]];
	
	/* add second sample item */
	item = [[NSMenuItem alloc] initWithTitle: @"Second Sample Item" action: @selector(whatever:) keyEquivalent: @""];
	[item setImage: [NSImage imageNamed: @"PlayList"]];
	[result addItem: item];
					 
	return result;
}



// ==============================================================================================
// =
// ==============================================================================================
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationProcessor:) name:nil object:nil];
	
	// Code to initialize application

//	customButtonCell = [JsCustomButtonCell new];
	
	auto highFloatComponent = 168.0 / 255.0;
	auto lowFloatComponent = (168.0-16.0) / 255.0;
	
	//[[NSApplication sharedApplication] setPresentationOptions:NSFullScreenWindowMask];
	
	NSColor *pastelCyan = [NSColor colorWithCalibratedRed:lowFloatComponent green:highFloatComponent blue:highFloatComponent alpha:1.0f];
	NSColor *pastelViolet = [NSColor colorWithCalibratedRed:highFloatComponent green:lowFloatComponent blue:highFloatComponent alpha:1.0f];
	NSColor *pastelMarron = [NSColor colorWithCalibratedRed:highFloatComponent green:highFloatComponent blue:lowFloatComponent alpha:1.0f];
	NSColor *pastelrouge = [NSColor colorWithCalibratedRed:highFloatComponent green:lowFloatComponent blue:lowFloatComponent alpha:1.0f];
	NSColor *pastelVert = [NSColor colorWithCalibratedRed:lowFloatComponent green:highFloatComponent blue:lowFloatComponent alpha:1.0f];
	//	MakeTabColor( &(TabColor[5]),BaseY-16,BaseY-16,BaseY);          // bleu
	//	MakeTabColor( &(TabColor[6]),BaseY-32,BaseY-16,BaseY);          // bleu
	//NSColor *bgColor = [NSColor colorWithCalibratedRed:49.0f/255.0f green:54.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	NSColor *bgColor = [NSColor colorWithCalibratedRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
	
	
	NSDockTile *dockTile = [NSApp dockTile];
	[dockTile setBadgeLabel:@"1"];
	[dockTile display];
	
	
	_consoleView = Nil;
	// suscribe a listener
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEventEchoToConsole:) name:nil object:nil];
	
	
	
	// ==== MENU START ====
	auto appName = [[NSProcessInfo processInfo] processName];
	auto menubar = [NSMenu new];
	{
 		{
			auto appMenuItem = [NSMenuItem new];//[[NSMenu alloc] initWithTitle:@"File"];
			{
				auto appMenu = [NSMenu new];
				  [appMenu addItem:[[NSMenuItem alloc] initWithTitle:@"info" action:@selector(terminate:) keyEquivalent:@""]];
				  [appMenu addItem:[[NSMenuItem alloc] initWithTitle:[@"Quit " stringByAppendingString:appName] action:@selector(terminate:) keyEquivalent:@"q"]];
				[appMenuItem setSubmenu:appMenu];
			}
			[menubar addItem:appMenuItem];
 		}

	
	}
	[NSApp setMainMenu:menubar];
	// File
	{
		auto menu = [[NSMenu alloc] initWithTitle:@"File"];
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"wqwerty" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"asdfg" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		auto menuItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
		[menuItem setSubmenu:menu];
		[[NSApp mainMenu] addItem:menuItem];
	}
	// Select
	{
		auto menu = [[NSMenu alloc] initWithTitle:@"Select"];
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"wqwerty" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"asdfg" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		auto menuItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
		[menuItem setSubmenu:menu];
		[[NSApp mainMenu] addItem:menuItem];
	}
	// Config
	{
		auto menu = [[NSMenu alloc] initWithTitle:@"Config"];
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"wqwerty" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"asdfg" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		auto menuItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
		[menuItem setSubmenu:menu];
		[[NSApp mainMenu] addItem:menuItem];
	}
	// Help
	{
		auto menu = [[NSMenu alloc] initWithTitle:@"Help"];
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"NOP Help" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		[menu addItem:[[NSMenuItem alloc] initWithTitle:@"qwertyu" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
		auto menuItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
		[menuItem setSubmenu:menu];
		[[NSApp mainMenu] addItem:menuItem];
	}
	
	
	
//	// blurps menu
//	auto menu2 = [[NSMenu alloc] initWithTitle:@"blurps"];
//	[menu2 addItem:[[NSMenuItem alloc] initWithTitle:@"Tarantula blurps" action:@selector(showHelp:) keyEquivalent:@"?"]]; // Help
//	auto menuItem2 = [[NSMenuItem alloc] initWithTitle:@"Windowblurps" action:nil keyEquivalent:@""];
//	[menuItem2 setSubmenu:menu2];
//	[[NSApp mainMenu] addItem:menuItem2];
	// ==== MENU END ====

	
	
	//// Color Declarations
	//NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha: 1];
	NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.0 green: 0.0 blue: 0.0 alpha: 1];
	NSColor *lowerColor = [baseColor shadowWithLevel: 0.1];
	NSColor *upperColor = [baseColor highlightWithLevel: 0.2];
	NSColor *lightUpColor = [baseColor highlightWithLevel: 0.5];
	NSColor *lightDownColor = [baseColor shadowWithLevel: 0.2];
	
	// ==== WINDOW START ====
	//auto appName = [[NSProcessInfo processInfo] processName];
	//window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 640, 400) styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO];
	window = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 800, 600) styleMask: (NSTitledWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask) backing: NSBackingStoreBuffered defer: YES];
	{
		NSRect window_frame = [window frame];
		NSView *contentView = [[NSView alloc] initWithFrame:window_frame];
		[contentView setAutoresizesSubviews:YES];
		[window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
		[window setTitle:appName];
		[window setBackgroundColor:bgColor];
		[window makeKeyAndOrderFront:NSApp];
		[window setContentView:contentView];
		[window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
	
		if (false)
		{
			//		auto toolbar = [self addToolBarWithidentifier:@"toolbar" superView:contentView];
			auto toolbar = [self addToolBarWithidentifier:@"toolbar" superView:contentView];
			auto toolbarItem1 = [self addToolBarItemWithidentifier:@"toolbarItem1" superView:contentView];
			[toolbarItem1 setLabel:@"MonItem"];
			auto folderImage = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)];
			[toolbarItem1 setImage:folderImage];
			[toolbar insertItemWithItemIdentifier:@"toolbarItem1" atIndex:0];
			JsToolbarDelegate *ToolbarDelegate = [JsToolbarDelegate new];
			[toolbar setDelegate:ToolbarDelegate];
			[toolbar setDisplayMode:NSToolbarDisplayModeIconAndLabel];
		
			//NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"PreferencesToolbar"];
			[toolbar setAllowsUserCustomization:NO];
			[toolbar setAutosavesConfiguration:NO];
			[self.window setToolbar:toolbar];
		
			[window setToolbar:toolbar];
	//		[window toggleFullScreen:self];
			//[window toggleToolbarShown:self];
		}
		

		rightDirectoryTableViewDelegate = [JsDirectoryTableViewDelegate new];
		[rightDirectoryTableViewDelegate setCurrentDirectoryPath:@"///Users/tungsten/Downloads"];
//		[rightDirectoryTableViewDelegate setCurrentDirectoryPath:@"file://Users/tungsten/Downloads"];

		leftDirectoryTableViewDelegate = [JsDirectoryTableViewDelegate new];
		[leftDirectoryTableViewDelegate setCurrentDirectoryPath:@"///Users/tungsten/Desktop"];
		//		[leftDirectoryTableViewDelegate setCurrentDirectoryPath:@"file://Users/tungsten/Desktop"];

		
		/*
		 NSRect windowRect = NSMakeRect( 200.0, 200.0, 400.0, 300.0 );
		 NSWindow *window = [ [ NSWindow alloc ] initWithContentRect:windowRect styleMask:(NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask) backing:NSBackingStoreBuffered defer:NO];
		 NSButton *button = [ [ NSButton alloc ] initWithFrame:NSMakeRect( 300.0, 20.0, 80.0, 50.0 ) ];
		 [ button setBezelStyle:NSRoundedBezelStyle];
		 [ button setTitle: @"Click" ];
		 [ [ window contentView ] addSubview: button ];
		 [window makeKeyAndOrderFront:nil];
		 */	
		
/*
		id textWiew = [NSTextView alloc];
		
		NSScrollView *scrollview = [[NSScrollView alloc] initWithFrame:[[window contentView] frame]];
		NSSize contentSize = [scrollview contentSize];
		[scrollview setBorderType:NSNoBorder];
		[scrollview setHasVerticalScroller:YES];
		[scrollview setHasHorizontalScroller:NO];
		[scrollview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
		
		NSTextView *theTextView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, contentSize.width, contentSize.height)];
		[theTextView setMinSize:NSMakeSize(0.0, contentSize.height)];
		[theTextView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
		[theTextView setVerticallyResizable:YES];
		[theTextView setHorizontallyResizable:NO];
		[theTextView setAutoresizingMask:NSViewWidthSizable];
		[[theTextView textContainer] setContainerSize:NSMakeSize(contentSize.width, FLT_MAX)];
		[[theTextView textContainer] setWidthTracksTextView:YES];
		
		[scrollview setDocumentView:theTextView];
		NSSplitView *splitView = [[NSSplitView alloc] initWithFrame:[[window contentView] bounds]];
		NSTextView *textView1 = [NSTextView new];
		NSView *view2 = [NSView new];
		
		[splitView addSubview:textView1];
		[splitView addSubview:view2];
		[splitView addSubview:scrollview];
		[splitView adjustSubviews];
		[[window contentView] addSubview:splitView];
		[window makeKeyAndOrderFront:nil];
		[window makeFirstResponder:theTextView];
		
		[[theTextView enclosingScrollView] setHasHorizontalScroller:YES];
		[theTextView setHorizontallyResizable:YES];
		[theTextView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		[[theTextView textContainer] setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
		[[theTextView textContainer] setWidthTracksTextView:NO];
		
		for (UINT32 i=10; i<100; i++)
		{
			[[[theTextView textStorage] mutableString] appendString: @"<HTML>VLA MON <B>TEXT</B>\n</HTML>"];
		}
		
		NSString *myHTMLString = @"<html><a href=\"http://www.dalloz.fr\">my_label</a> <U>Hello</U> <B>World</B> !</html>" ;
		NSData *myData = [myHTMLString dataUsingEncoding:NSUTF8StringEncoding];
		NSAttributedString *textToBeInserted = [[NSAttributedString alloc] initWithHTML:myData documentAttributes:nil];
		[[theTextView textStorage] setAttributedString:textToBeInserted];
*/
		
		
//    auto findButton = [self addPushButtonWithTitle:NSLocalizedString(@"Find", nil) identifier:@"find" superView:contentView];
//    auto findNextButton = [self addPushButtonWithTitle:NSLocalizedString(@"Find Next", nil) identifier:@"findNext" superView:contentView];
//    auto findField = [self addTextFieldWithidentifier:@"findField" superView:contentView];
//    auto replaceButton = [self addPushButtonWithTitle:NSLocalizedString(@"Replace", nil) identifier:@"replace" superView:contentView];
//    auto replaceAndFindButton = [self addPushButtonWithTitle:NSLocalizedString(@"Replace & Find", nil) identifier:@"replaceAndFind" superView:contentView];
//    auto replaceField = [self addTextFieldWithidentifier:@"replaceField" superView:contentView];

		//auto testButton = [self addPushButtonWithTitle:NSLocalizedString(@"Test", nil) identifier:@"test" superView:contentView];

//		auto testButton = [self addBoxWithidentifier:@"testButton" superView:contentView];
//		auto blurpsButton = cppAddPushButtonWithTitle(NSLocalizedString(@"Blurps", nil), @"blurps", testButton);
//		auto blurps2Button = cppAddPushButtonWithTitle(NSLocalizedString(@"Blurps2", nil), @"blurps2", testButton);

		

		auto topView = [self addViewWithidentifier:@"topView" superView:contentView];
		//auto topStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(@"62.3Gb free / 160Gb                 125 Files 23 Dirs", nil) identifier:@"topStatusRButton" superView:topView];
		auto topStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(@"62.3Gb free / 160Gb                 125 Files 23 Dirs", nil) identifier:@"topStatusRButton" superView:contentView];
		
		auto rightView = [self addViewWithidentifier:@"rightView" superView:contentView];
		auto middleView = [self addViewWithidentifier:@"middleView" superView:contentView];
		auto lefttView = [self addViewWithidentifier:@"lefttView" superView:contentView];
		auto bottomView = [self addViewWithidentifier:@"bottomView" superView:contentView];
		
		if (false)
		{
		auto consoleScrollView = [self addScrollViewWithidentifier:@"consoleScrollView" superView:contentView];
		auto consoleView = addTextViewWithidentifier(@"consoleView", consoleScrollView);
		_consoleView = consoleView;
		[(NSScrollView *)consoleScrollView setDocumentView:consoleView];

//		auto webScrollView = [self addScrollViewWithidentifier:@"webScrollView" superView:contentView];
//		auto webView = addWebViewWithidentifier(@"webView", consoleScrollView);
//		[(NSScrollView *)webScrollView setDocumentView:webView];
				
		auto bottomTabView = [self addTabViewWithidentifier:@"bottomTabView" superView:contentView];

//		auto webTabViewItem = [self addTabViewItemWithidentifier:@"webTabViewItem" superView:bottomTabView];
//		[webTabViewItem setView:webScrollView];

		auto consoleTabViewItem = [self addTabViewItemWithidentifier:@"consoleTabViewItem" superView:bottomTabView];
		[consoleTabViewItem setView:consoleScrollView];
		}
		
		

		auto rightScrollView = [self addScrollViewWithidentifier:@"rightScrollView" superView:contentView];
		auto rightTableButton = [self addTableViewWithidentifier:@"rightTableButton" superView:rightScrollView directoryTableViewDelegate:rightDirectoryTableViewDelegate];
		[(NSScrollView *)rightScrollView setDocumentView:rightTableButton];
		rightDirectoryTableView = rightTableButton;
		currentDirectoryTableView = rightTableButton;
		//[testButton sizeToFit];

		auto leftScrollView = [self addScrollViewWithidentifier:@"leftScrollView" superView:contentView];
		auto leftTableButton = [self addTableViewWithidentifier:@"leftTableButton" superView:leftScrollView directoryTableViewDelegate:leftDirectoryTableViewDelegate];
		[(NSScrollView *)leftScrollView setDocumentView:leftTableButton];
		leftDirectoryTableView = leftTableButton;
		//currentDirectoryTableView = leftTableButton;

		
		//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidMakeFirstResponder:) name:@"WindowDidMakeFirstResponder" object:nil];
				
		// [status bar] [time]
	  // [about button] [left occupied/free] [right occupied/free]
	  // [left parent button] [left listview] [right listview] [right parent button]
		// [left selection button] [current left path] [current right path] [right selection button]
	  // [Copy] [Move] [Rename] [Delete] [Makedir] [Clone] [Move as] [Copy as]

		//auto copyButton = cppAddPushButtonWithTitle(NSLocalizedString(@"Copy", nil), @"copy", contentView);
		auto copyButton = [self addPushButtonWithTitle:NSLocalizedString(@"Copy", nil) identifier:@"copy" superView:contentView];
//		[copyButton.cell setBackgroundColor:pastelViolet];
		auto moveButton = [self addPushButtonWithTitle:NSLocalizedString(@"Move", nil) identifier:@"move" superView:contentView];
//		[moveButton.cell setBackgroundColor:pastelViolet];
		auto renameButton = [self addPushButtonWithTitle:NSLocalizedString(@"Rename", nil) identifier:@"rename" superView:contentView];
//		[renameButton.cell setBackgroundColor:pastelViolet];
		auto deleteButton = [self addPushButtonWithTitle:NSLocalizedString(@"Delete", nil) identifier:@"delete" superView:contentView];
//		[deleteButton.cell setBackgroundColor:[NSColor redColor]];
		auto makedirButton = [self addPushButtonWithTitle:NSLocalizedString(@"Makedir", nil) identifier:@"makedir" superView:contentView];
//		[makedirButton.cell setBackgroundColor:[NSColor orangeColor]];
		auto cloneButton = [self addPushButtonWithTitle:NSLocalizedString(@"Clone", nil) identifier:@"clone" superView:contentView];
		auto moveasButton = [self addPushButtonWithTitle:NSLocalizedString(@"Move as", nil) identifier:@"moveas" superView:contentView];
		auto copyasButton = [self addPushButtonWithTitle:NSLocalizedString(@"Copy as", nil) identifier:@"copyas" superView:contentView];
		// [Volume] [Parent] [Read] [Calc] [Get size] [Protect] [Edit] [Add path]
		auto volumeButton = [self addPushButtonWithTitle:NSLocalizedString(@"volume", nil) identifier:@"volume" superView:contentView];
		auto parentButton = [self addPushButtonWithTitle:NSLocalizedString(@"Parent", nil) identifier:@"parent" superView:contentView];
//		[parentButton.cell setBackgroundColor:[NSColor blueColor]];
		auto readButton = [self addPushButtonWithTitle:NSLocalizedString(@"Read", nil) identifier:@"read" superView:contentView];
		auto calcButton = [self addPushButtonWithTitle:NSLocalizedString(@"Calc", nil) identifier:@"calc" superView:contentView];
		auto getSizeButton = [self addPushButtonWithTitle:NSLocalizedString(@"Get size", nil) identifier:@"getSize" superView:contentView];
		auto protectButton = [self addPushButtonWithTitle:NSLocalizedString(@"Protect", nil) identifier:@"protect" superView:contentView];
		auto editButton = [self addPushButtonWithTitle:NSLocalizedString(@"Edit", nil) identifier:@"edit" superView:contentView];
		auto addPathButton = [self addPushButtonWithTitle:NSLocalizedString(@"Add path", nil) identifier:@"addPath" superView:contentView];
		// [Pattern] [Search] [Show] [Split] [Join] [All] [None] [Toggle]
		auto patternButton = [self addPushButtonWithTitle:NSLocalizedString(@"Pattern", nil) identifier:@"pattern" superView:contentView];
		auto searchButton = [self addPushButtonWithTitle:NSLocalizedString(@"Search", nil) identifier:@"search" superView:contentView];
		auto showButton = [self addPushButtonWithTitle:NSLocalizedString(@"Show", nil) identifier:@"show" superView:contentView];
		auto splitButton = [self addPushButtonWithTitle:NSLocalizedString(@"Split", nil) identifier:@"split" superView:contentView];
		auto joinButton = [self addPushButtonWithTitle:NSLocalizedString(@"Join", nil) identifier:@"join" superView:contentView];
		auto allButton = [self addPushButtonWithTitle:NSLocalizedString(@"All", nil) identifier:@"all" superView:contentView];
//		[allButton.cell setBackgroundColor:[NSColor blueColor]];
		auto noneButton = [self addPushButtonWithTitle:NSLocalizedString(@"None", nil) identifier:@"none" superView:contentView];
//		[noneButton.cell setBackgroundColor:[NSColor blueColor]];
		auto toggleButton = [self addPushButtonWithTitle:NSLocalizedString(@"Toggle", nil) identifier:@"toggle" superView:contentView];
//		[toggleButton.cell setBackgroundColor:[NSColor blueColor]];
		// [Open win] [Drive list] [Run] [File info] [Root] [L <- R] [ L -> R] [L <-> R]
		auto openWinButton = [self addPushButtonWithTitle:NSLocalizedString(@"Open win", nil) identifier:@"openWin" superView:contentView];
		auto driveListButton = [self addPushButtonWithTitle:NSLocalizedString(@"Drive list", nil) identifier:@"driveList" superView:contentView];
		auto runButton = [self addPushButtonWithTitle:NSLocalizedString(@"Run", nil) identifier:@"run" superView:contentView];
//		[runButton.cell setBackgroundColor:[NSColor greenColor]];
		auto fileInfoButton = [self addPushButtonWithTitle:NSLocalizedString(@"File info", nil) identifier:@"fileInfo" superView:contentView];
		auto rootButton = [self addPushButtonWithTitle:NSLocalizedString(@"Root", nil) identifier:@"root" superView:contentView];
//		[rootButton.cell setBackgroundColor:[NSColor blueColor]];
		auto rToLButton = [self addPushButtonWithTitle:NSLocalizedString(@"L <- R", nil) identifier:@"rToL" superView:contentView];
		auto lToRButton = [self addPushButtonWithTitle:NSLocalizedString(@"L -> R", nil) identifier:@"lToR" superView:contentView];
		auto swapLRButton = [self addPushButtonWithTitle:NSLocalizedString(@"L <-> R", nil) identifier:@"swapLR" superView:contentView];

		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSDictionary *attributesDict = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:NULL];
		//auto bottomStatusText = [NSString stringWithFormat:@"System disk size: %lld /  : System disk free space: %lld", [[attributesDict objectForKey:NSFileSystemSize] longLongValue], [[attributesDict objectForKey:NSFileSystemFreeSize] longLongValue]];
		//auto bottomStatusText = [NSString stringWithFormat:@"RAM size: %lld /  : RAM free space: %lld", SysctlCallReturnInteger(CTL_HW, HW_PHYSMEM), SysctlCallReturnInteger(CTL_HW, HW_USERMEM)];
		//auto bottomStatusText = getFreeMemory();
		//NSString *formattedDate = [[NSDate date] descriptionWithCalendarFormat:@"%Y-%m-%d %H:%M:%S"];	// MARCHE PAS !!!
		NSProcessInfo *processInfo = [NSProcessInfo processInfo];	// http://quickies.seriot.ch/index.php?id=288
		auto bottomStatusText = [NSString stringWithFormat:@"RAM : %qu GB,  CPU : %d,  OS : %@", [processInfo physicalMemory]>>30, [processInfo processorCount], [processInfo operatingSystemVersionString] ];
		
		//		auto bottomStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(@"<U>Hello</U><B>World</B> <i>31-07-2012 23H32   2.3Gb free / 6Gb</i> !", nil) identifier:@"bottomStatusRButton" superView:contentView];
		auto bottomStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(bottomStatusText, nil) identifier:@"bottomStatusRButton" superView:contentView];

		auto leftTopStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(@"Work                 62.3Gb", nil) identifier:@"leftTopStatusRButton" superView:contentView];

		//auto popOverButton = [self addPushButtonWithTitle:NSLocalizedString(@"PopOver", nil) identifier:@"popOverButton" superView:contentView];
//		NSViewController *controller = [[NSViewController alloc] initWithNibName:@"View"     bundle:nil];
//		NSPopover *popover = [NSPopover new];
//		[popover setContentSize:NSMakeSize(100.0f, 100.0f)];
		//[popover setContentViewController:(NSViewController *) popOverButton];
//		[popover setContentViewController:controller];
//		[popover setAnimates:YES];
//		[popover showRelativeToRect:[contentView bounds] ofView:contentView preferredEdge:NSMaxXEdge];
		
		
		auto rightTopStatusRButton = [self addPushButtonWithTitle:NSLocalizedString(@"Work                 62.3Gb", nil) identifier:@"rightTopStatusRButton" superView:contentView];

		auto leftBottomStatusRButton = [self addTextFieldWithContent:NSLocalizedString(@"/Volumes/DATA/Download/", nil) identifier:@"leftBottomStatusRButton" superView:contentView];
		auto rightBottomStatusRButton = [self addTextFieldWithContent:NSLocalizedString(@"/Volumes/DATA/Download/", nil) identifier:@"rightBottomStatusRButton" superView:contentView];

		
		
		/*
		auto leftListButton = [self addSizeablePushButtonWithTitle:NSLocalizedString(@"aaaaaa\nbbbbbbb", nil) identifier:@"leftListButton" superView:contentView];
		auto rightListButton = [self addSizeablePushButtonWithTitle:NSLocalizedString(@"ccccc\nddddddddddd", nil) identifier:@"rightListButton" superView:contentView];
*/
		
		NSDictionary *views = NSDictionaryOfVariableBindings(leftScrollView, leftTableButton, rightView, rightScrollView, rightTableButton, bottomStatusRButton, topStatusRButton, topView,
																												 /*leftListButton, rightListButton, */
																												 //consoleView, /*consoleScrollView,*/
																												 //bottomTabView,
																												 leftTopStatusRButton, rightTopStatusRButton, leftBottomStatusRButton, rightBottomStatusRButton,
																												 copyButton, moveButton, renameButton, deleteButton, makedirButton, cloneButton, moveasButton, copyasButton,
																												 volumeButton, parentButton, readButton, calcButton, getSizeButton, protectButton, editButton, addPathButton,
																												 patternButton, searchButton, showButton, splitButton, joinButton, allButton, noneButton, toggleButton,
																												 openWinButton, driveListButton, runButton, fileInfoButton, rootButton, rToLButton, lToRButton, swapLRButton
																												/*findButton, findNextButton, findField, replaceButton, replaceAndFindButton, replaceField,*/ );
		
 		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topStatusRButton(36)]-0-[leftTopStatusRButton(36)]-0-[leftScrollView(>=100)]-0-[leftBottomStatusRButton(36)]-0-[copyButton(36)]-0-[volumeButton(36)]-0-[patternButton(36)]-0-[openWinButton(36)]-0-[bottomStatusRButton(36)]-0-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightTopStatusRButton(36)]-0-[rightScrollView(>=100)]-0-[rightBottomStatusRButton(36)]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topStatusRButton]-0-[leftTopStatusRButton]-0-[leftScrollView(>=100)]-0-[leftBottomStatusRButton]-0-[copyButton]-0-[volumeButton]-0-[patternButton]-0-[openWinButton]-0-[bottomStatusRButton]-0-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightTopStatusRButton]-0-[rightScrollView(>=100)]-0-[rightBottomStatusRButton]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topStatusRButton]-0-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftScrollView]-0-[rightScrollView(==leftScrollView)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftTopStatusRButton]-0-[rightTopStatusRButton(==leftTopStatusRButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBottomStatusRButton]-0-[rightBottomStatusRButton(==leftBottomStatusRButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[copyButton]-0-[moveButton(==copyButton)]-0-[renameButton(==copyButton)]-0-[deleteButton(==copyButton)]-0-[makedirButton(==copyButton)]-0-[cloneButton(==copyButton)]-0-[moveasButton(==copyButton)]-0-[copyasButton(==copyButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[volumeButton]-0-[parentButton(==volumeButton)]-0-[readButton(==volumeButton)]-0-[calcButton(==volumeButton)]-0-[getSizeButton(==volumeButton)]-0-[protectButton(==volumeButton)]-0-[editButton(==volumeButton)]-0-[addPathButton(==volumeButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[patternButton]-0-[searchButton(==patternButton)]-0-[showButton(==patternButton)]-0-[splitButton(==patternButton)]-0-[joinButton(==patternButton)]-0-[allButton(==patternButton)]-0-[noneButton(==patternButton)]-0-[toggleButton(==patternButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[openWinButton]-0-[driveListButton(==openWinButton)]-0-[runButton(==openWinButton)]-0-[fileInfoButton(==openWinButton)]-0-[rootButton(==openWinButton)]-0-[rToLButton(==openWinButton)]-0-[lToRButton(==openWinButton)]-0-[swapLRButton(==openWinButton)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
 		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomStatusRButton]-0-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
// 		[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomTabView]-0-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];

	  // Give the text fields a hard minimum width, because it looks good.
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[findButton]-0-[findNextButton]-0-[findField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[replaceButton]-0-[replaceAndFindButton]-0-[replaceField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    // Vertical layout.  We just need to specify what happens to one thing in each row, since everything within a row is already top aligned.  We'll use the text fields, since then we can align their leading edges as well in one step.
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[findField]-0-[replaceField]-(>=20)-|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		
    // lower the content hugging priority of the text fields from NSLayoutPriorityDefaultLow, so that they expand to fill extra space rather than the buttons.
//    for (NSView *view in [NSArray arrayWithObjects:findField, replaceField, nil])
//		{
//			[view setContentHuggingPriority:NSLayoutPriorityDefaultLow - 1 forOrientation:NSLayoutConstraintOrientationHorizontal];
//   }
		
    // In the row in which the buttons are smaller (whichever that is), it is still ambiguous how the buttons expand from their preferred widths to fill the extra space between the window edge and the text field.
    // They should prefer to be equal width, more weakly than our other constraints.
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[findButton(==findNextButton@25)]" options:0 metrics:nil views:views]];
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[replaceButton(==replaceAndFindButton@25)]" options:0 metrics:nil views:views]];
		

//DEBUG MODE
		//see what it looks like if you visualize some of the constraints.
		//[[contentView window] visualizeConstraints:[copyButton constraintsAffectingLayoutForOrientation:NSLayoutConstraintOrientationHorizontal]];
		
    // after you see that, try removing the calls to set content hugging priority above, and see what visualization looks like in that case.  This demonstrates an ambiguous situation.
    
    // now, see what it looks like in German and Arabic!
 
		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[testButton]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[testButton]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[testButton]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		//[contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[testButton]-0-[copyButton]" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
 
 
	}
	// ==== WINDOW END ====
}

@end