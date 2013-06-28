//========================================================================================
//
//========================================================================================

#import "JsDirectoryTableViewDelegate.h"
#import "JsCustomTableCellView.h"

@implementation JsDirectoryTableViewDelegate

//@synthesize _tableContents;
@synthesize _tableView;
@synthesize _currentDirectoryPath;
@synthesize folderImage;
@synthesize _files;

// Sample data we will display
static NSString *ATTableData[] =
{
	@"NSQuickLookTemplate",
	@"NSBluetoothTemplate",
	@"NSIChatTheaterTemplate",
	@"NSSlideshowTemplate",
	@"NSActionTemplate",
	@"NSSmartBadgeTemplate",
	@"NSIconViewTemplate",
	@"NSListViewTemplate",
	@"NSColumnViewTemplate",
	@"NSFlowViewTemplate",
	@"NSPathTemplate",
	@"NSInvalidDataFreestandingTemplate",
	@"NSLockLockedTemplate",
	@"NSLockUnlockedTemplate",
	@"NSGoRightTemplate",
	@"NSGoLeftTemplate",
	@"NSRightFacingTriangleTemplate",
	@"NSLeftFacingTriangleTemplate",
	@"NSAddTemplate",
	@"NSRemoveTemplate",
	@"NSRevealFreestandingTemplate",
	@"NSFollowLinkFreestandingTemplate",
	@"NSEnterFullScreenTemplate",
	@"NSExitFullScreenTemplate",
	@"NSStopProgressTemplate",
	@"NSStopProgressFreestandingTemplate",
	@"NSRefreshTemplate",
	@"NSRefreshFreestandingTemplate",
	@"NSBonjour",
	@"NSComputer",
	@"NSFolderBurnable",
	@"NSFolderSmart",
	@"NSFolder",
	@"NSNetwork",
	@"NSMobileMe",
	@"NSMultipleDocuments",
	@"NSUserAccounts",
	@"NSPreferencesGeneral",
	@"NSAdvanced",
	@"NSInfo",
	@"NSFontPanel",
	@"NSColorPanel",
	@"NSUser",
	@"NSUserGroup",
	@"NSEveryone",
	@"NSUserGuest",
	@"NSMenuOnStateTemplate",
	@"NSMenuMixedStateTemplate",
	@"NSApplicationIcon",
	@"NSTrashEmpty",
	@"NSTrashFull",
	@"NSHomeTemplate",
	@"NSBookmarksTemplate",
	@"NSCaution",
	@"NSStatusAvailable",
	@"NSStatusPartiallyAvailable",
	@"NSStatusUnavailable",
	@"NSStatusNone",
	nil };


//- (void)tableViewSelectionDidChange:(NSNotification *)notification
//{
//			[[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewSelectionDidChange" object:self._tableView];
//}

- (void)mouseDown:(NSEvent *)theEvent
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"JsMousedown" object:self._tableView];
}



// ==============================================================================================
// il semble que cette methode n'est jamais appele ...
// ==============================================================================================
- (void)windowDidLoad
{
	[super windowDidLoad];

	// Load up our sample data
//	_tableContents = [NSMutableArray new];
	// Walk each string in the array until we hit the end (nil)
	
//	NSSet * mySetOfStringIDs = [NSSet setWithArray:ATTableData];
//	for(NSString *ATItem in ATTableData)
//	{
//    if([mySetOfStringIDs containsObject:foo.Id])
//		{
//			// Do something
//			break;
//    }
//	}
	
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"=== START INIT ===\n"]];
	printf("=== START INIT ===\n");
	//void *(NSString *data) = &ATTableData[0];
	//while (*data != nil)
	
/*
	for (int i=0; ATTableData[i+1] != nil; i++)
	{
		NSString *name = ATTableData[i];
		NSImage *image = [NSImage imageNamed:name];
		// our model will consist of a dictionary with Name/Image key pairs
		NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"Name", image, @"Image", nil];
		[_tableContents addObject:dictionary];
	}
*/
 


	
	
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:[NSString stringWithFormat:@"=== END INIT ===\n"]];
	printf("=== END INIT ===\n");
}

// ==============================================================================================
//
// ==============================================================================================
/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
}
*/
 
// ==============================================================================================
//
// ==============================================================================================
/*
static void *AngleBindingContext = (void *)@"JoystickAngle";

- (void)bind:(NSString *)binding toObject:(id)observableObject withKeyPath:(NSString *)keyPath options:(NSDictionary *)options
{
	// Observe the observableObject for changes -- note, pass binding identifier as the context, so you get that back in observeValueForKeyPath:...
	// This way you can easily determine what needs to be updated.
	
	if ([binding isEqualToString:@"angle"])
	{
    [observableObject addObserver:self forKeyPath:keyPath options:0 context:AngleBindingContext];
		
    // Register what object and what keypath are associated with this binding
    auto observedObjectForAngle = observableObject;
    auto observedKeyPathForAngle = [keyPath copy];
		
    // Record the value transformer, if there is one
    NSValueTransformer *angleValueTransformer = nil;
    NSString *vtName = [options objectForKey:@"NSValueTransformerName"];
    if (vtName != nil)
    {
			angleValueTransformer = [NSValueTransformer valueTransformerForName:vtName];
    }
	}
}
*/

/*
// ==============================================================================================
//
// ==============================================================================================
- (void)swipeWithEvent:(NSEvent *)event
{
	CGFloat x = [event deltaX];
	
	if (x != 0)
	{
		if (x > 0)
		{
			[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"swipe left"];
		}
		else
		{
			[[NSNotificationCenter defaultCenter] postNotificationName:@"EchoToConsole" object:@"swipe right"];
		}
	}
}
*/

// ==============================================================================================
//
// ==============================================================================================
- (void) setCurrentDirectoryPath:(NSString *)currentDirectoryPath
{

	folderImage = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)];
	
	
//	_tableContents = [NSMutableArray new];
//	for (int i=0; ATTableData[i+1] != nil; i++)
//	{
//		NSString *name = ATTableData[i];
//		NSImage *image = [NSImage imageNamed:name];
//		// our model will consist of a dictionary with Name/Image key pairs
//		NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"Name", image, @"Image", nil];
//		[_tableContents addObject:dictionary];
//	}
//	[_tableView reloadData];

	
	
	_currentDirectoryPath = currentDirectoryPath;
	
	NSFileManager *filemgr;
	NSString *currentpath;
	
	filemgr = [NSFileManager defaultManager];
	//	currentpath = [filemgr currentDirectoryPath];
	//	NSLog (@"Current directory is %@", currentpath);
	//	if ([filemgr changeCurrentDirectoryPath: @"/Volumes/DATA"] == NO)
	//	{
	//		NSLog (@"Cannot change directory.");
	//	}
	//	currentpath = [filemgr currentDirectoryPath];
	//	NSLog (@"Current directory is %@", currentpath);
	
	//NSFileManager * fileMan = [[NSFileManager alloc] init];
//auto *files = [filemgr contentsOfDirectoryAtPath:_currentDirectoryPath error:nil];

/*
NSURLAttributeModificationDateKey
NSURLContentAccessDateKey
NSURLContentAccessDateKey;
NSURLContentModificationDateKey;
NSURLCreationDateKey;
NSURLCustomIconKey;
NSURLEffectiveIconKey;
NSURLFileResourceIdentifierKey;
NSURLFileResourceTypeKey;
NSURLFileSecurityKey;
NSURLHasHiddenExtensionKey;
NSURLIsDirectoryKey;
NSURLIsExcludedFromBackupKey;
NSURLIsExecutableKey;
NSURLIsHiddenKey;
NSURLIsMountTriggerKey;
NSURLIsPackageKey;
NSURLIsReadableKey;
NSURLIsRegularFileKey;
NSURLIsSymbolicLinkKey;
NSURLIsSystemImmutableKey;
NSURLIsUserImmutableKey;
NSURLIsVolumeKey;
NSURLIsWritableKey;
NSURLLabelColorKey;
NSURLLabelNumberKey;
NSURLLinkCountKey;
NSURLLocalizedLabelKey;
NSURLLocalizedNameKey;
NSURLLocalizedTypeDescriptionKey;
NSURLNameKey;
NSURLParentDirectoryURLKey;
NSURLPathKey
NSURLPreferredIOBlockSizeKey;
NSURLTypeIdentifierKey;
NSURLVolumeIdentifierKey;
NSURLVolumeURLKey;
*/


	NSURL *url = [NSURL fileURLWithPath:_currentDirectoryPath];
	NSError *error;// = nil;
	NSArray *properties = [NSArray arrayWithObjects: NSURLLocalizedNameKey, NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey, nil];
	
	//NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:keys options:0 error:&error];
	//NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:properties options:(NSDirectoryEnumerationSkipsHiddenFiles) error:&error];
	NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:properties options:0 error:&error];
	if (files == nil)
	{
			NSAlert *alert = [NSAlert alertWithError:error];
			[alert runModal];
	}
	
	if (files)
	{
		_files = [files mutableCopy] ;
		

		NSMutableArray *unsortedDirectories = [NSMutableArray new];
		NSMutableArray *unsortedFiles = [NSMutableArray new];
		
		// add ".." at the top of the list
		NSURL *fileUrl = [NSURL URLWithString:@"file:///.."];
		[unsortedDirectories addObject:fileUrl];
		
		// add list
    for(int index=0;index<files.count;index++)
    {
			NSURL *fileUrl = [_files objectAtIndex:index];

			auto ws = [NSWorkspace sharedWorkspace];
			//auto fileName = [[fileUrl path] lastPathComponent];
			//auto filePath = [fileUrl path];
			NSString *appName;
			NSString *fileType;
			[ws getInfoForFile: [fileUrl path] application: &appName type: &fileType];

			
			NSNumber *fileSize;
			[fileUrl getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
			
			//if ([fileType isEqualToString:@""])
			if (fileSize != nil)
			{
				[unsortedFiles addObject:fileUrl];
			}
			else
			{
				[unsortedDirectories addObject:fileUrl];
			}
			//NSString *file = [_files objectAtIndex:index];
			//NSLog (@"Current file is %@", file);
			//			if( [[file pathExtension] compare: @"jpg"] == NSOrderedSame )
			//			{
			// do something with files that end with .jpg
			//			}
    }

		//auto sortedDirectories = [_files sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		//auto sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DatesOfJoin" ascending:NO];
		//NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		//[_files sortUsingDescriptors:sortDescriptors];
		
		NSArray * sortedDirectories = [unsortedDirectories sortedArrayUsingComparator:(NSComparator)^(id fileUrl1, id fileUrl2){
			NSString *fileName1 = [[fileUrl1 path] lastPathComponent];
			NSString *fileName2 = [[fileUrl2 path] lastPathComponent];
			return [fileName1 caseInsensitiveCompare:fileName2]; }];

		NSArray * sortedFiles = [unsortedFiles sortedArrayUsingComparator:(NSComparator)^(id fileUrl1, id fileUrl2){
			NSString *fileName1 = [[fileUrl1 path] lastPathComponent];
			NSString *fileName2 = [[fileUrl2 path] lastPathComponent];
			return [fileName1 caseInsensitiveCompare:fileName2]; }];
		
		_files = [sortedDirectories mutableCopy];
		// append one array to another
		[_files addObjectsFromArray:sortedFiles];
		//[_files insertObjects:[NSURL fileURLWithPath:_currentDirectoryPath] atIndexes:1];
		
		
	}
	
}
	
// ==============================================================================================
//
// ==============================================================================================
// The only essential/required tableview dataSource method

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return _files.count;
	//return [_tableContents count];
}


// ==============================================================================================
//
// ==============================================================================================
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	[[NSGraphicsContext currentContext] setShouldAntialias:NO];
	
	NSColor *bgColor = [NSColor colorWithCalibratedRed:49.0f/255.0f green:54.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	
	
	// Group our "model" object, which is a dictionary
//	NSDictionary *dictionary = [_tableContents objectAtIndex:row];
	
	// In IB the tableColumn has the identifier set to the same string as the keys in our dictionary
	NSString *identifier = [tableColumn identifier];
	
  //	NSFontManager *fontManager = [NSFontManager sharedFontManager];
  //	NSFont *sourcesanspro = [fontManager fontWithFamily:@"SourceSansPro-Bold" traits:NSBoldFontMask weight:15 size:26];

	
	//	NSColor *listBgColor = [NSColor colorWithCalibratedRed:0.7f green:0.7f blue:1.0f alpha:0.5f];
	//	NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha: 0.8];

	//	NSFont *regular = [NSFont fontWithName:@"Verdana" size:10];
	//	NSFont *bold = [NSFont fontWithName:@"Verdana-Bold" size:10];
	//	NSFont *italic = [NSFont fontWithName:@"Verdana-Italic" size:10];
	//	NSFont *bolditalic = [NSFont fontWithName:@"Verdana-BoldItalic" size:10];
	
	//	NSFont *verdanaboldItalic = [fontManager fontWithFamily:@"Verdana" traits:NSBoldFontMask|NSItalicFontMask weight:15 size:10];
	NSFontManager *fontManager = [NSFontManager sharedFontManager];
	//auto listFont = [fontManager fontWithFamily:@"Helvetica" traits:0 weight:1 size:12];
	auto listFont = [fontManager fontWithFamily:@"Terminus (TTF)" traits:0 weight:1 size:12];
	
	//  setShouldAntialias: method of NSGraphicsContext.
	
	
	
	//auto listFont = [fontManager fontWithFamily:@"Monaco" traits:0 weight:1 size:12];
	//auto listFont = [listVectorFont screenFontWithRenderingMode:NSFontIntegerAdvancementsRenderingMode];

	//CGContextSetShouldSmoothFonts([[NSGraphicsContext currentContext] graphicsPort], 1);
	
	//CGContextSetShouldAntialias([[NSGraphicsContext currentContext] graphicsPort], 1);
	
	auto ws = [NSWorkspace sharedWorkspace];
	NSURL *fileUrl = [_files objectAtIndex:row];
	auto fileName = [[fileUrl path] lastPathComponent];
	auto filePath = [fileUrl path];

	if ([identifier isEqualToString:@"FileName"])
	{
		NSString *appName;
		NSString *fileType;
		[ws getInfoForFile: [fileUrl path] application: &appName type: &fileType];
		
		auto fileImage = [ws iconForFileType:fileType];
		[fileImage setSize: NSMakeSize(16,16)];

		JsCustomTableCellView *cellView = [JsCustomTableCellView new];
		cellView.identifier = identifier;
		cellView.autoresizesSubviews = YES;
//		cellView.objectValue = dictionary;
		
//		auto imageView = [NSImageView new];
			cellView.imageView.identifier = tableColumn.identifier;
			//cellView.imageView.image = [dictionary objectForKey:@"Image"];
			//cellView.imageView.image = folderImage;
		cellView.imageView.image = fileImage;
//		[imageView setEnabled: YES];;
//		cellView.imageView = imageView;
//		[cellView addSubview:imageView];
		
		//auto textField = [NSTextField new];
		cellView.textField.identifier = tableColumn.identifier;
		cellView.textField.bordered = NO;
		[cellView.textField setBezeled:NO];

		cellView.textField.drawsBackground =  NO;
		//cellView.textField.backgroundColor = bgColor;
		

		
		cellView.textField.stringValue = fileName;
		cellView.textField.toolTip = filePath;
		//cellView.textField.toolTip = fileType;

		// background color 49 54 62
		// directory color 83 159 207
		// file color 185 185 185
		NSColor *symbolicLinkColor = [NSColor colorWithDeviceRed:83.0f/255.0f green:159.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
		NSColor *directoryColor = [NSColor colorWithDeviceRed:83.0f/255.0f green:159.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
		NSColor *fileColor = [NSColor colorWithDeviceRed:185.0f/255.0f green:185.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
		NSNumber *fileSize;
		[fileUrl getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
		//if ([fileType isEqualToString:@"'fdrp'"])	//fdrp => symbolic link
		if (fileSize == nil)
		{
			//[cellView.textField setTextColor:symbolicLinkColor]; // "" => directory
			[cellView.textField setTextColor:directoryColor];
		}
		//else if ([fileType isEqualToString:@""])
		else if (fileSize == nil)
		{
			//[cellView.textField setTextColor:directoryColor];
			cellView.imageView.image = folderImage;
			[cellView.textField setTextColor:directoryColor];
		}
		else
		{
			[cellView.textField setTextColor:fileColor];
		}
			
		[cellView.textField setFont:listFont];

		
	//		cellView.textField.font = sourcesanspro;
	//		cellView.[textField setEnabled: YES];;
	//		cellView.textField = textField;
	//		[cellView addSubview:textField];
		
		return cellView;
	}
	else if ([identifier isEqualToString:@"FileSize"])
	{
		NSText *text = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
		if (text == nil)
		{
			text = [NSText new];
			[text setAlignment:NSRightTextAlignment];
			text.font = listFont;
			text.textColor = [NSColor whiteColor];
		}
	//		NSImage *image = [dictionary objectForKey:@"Image"];
	//		NSSize size = image ? [image size] : NSZeroSize;
	//		NSString *sizeString = [NSString stringWithFormat:@"%.0fx%.0f", size.width, size.height];
	//		textField.objectValue = sizeString;
		text.drawsBackground =  NO;
		//text.backgroundColor = baseColor;
		//text.backgroundColor = baseColor;
		//[textField setBezeled:NO];
		//textField.bordered = NO;
		//textField.objectValue = [fileSize stringValue];
		NSNumber *fileSize;
		[fileUrl getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
		if (fileSize != nil)
		{
			// Create formatter
			NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
			//[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
			[formatter setGroupingSeparator:@"  "];
			[formatter setGroupingSize:3];
			[formatter setUsesGroupingSeparator:YES];
			NSString *formattedOutput = [formatter stringFromNumber:fileSize];
			text.string = formattedOutput;
			//textField.stringValue = [fileSize stringValue];
		}
		else
		{
			text.string = @"<DIR>";
		}
		return text;
	}
	else if ([identifier isEqualToString:@"FileDate"])
	{
		NSText *text = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
		if (text == nil)
		{
			text = [NSText new];
			text.font = listFont;
			text.textColor = [NSColor whiteColor];
			text.drawsBackground =  NO;
		}
		text.string = @"13-08-2012 13H36";
		return text;
	}
	else
	{
		NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
	}
	return nil;
}
// ======================================================================


- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	//NSString *returnValue = Nil;
	auto *fileUrl = [_files objectAtIndex:rowIndex];
	//auto *fileName = @"asdlfkjhlkjsd";
	//auto *filePath = [_currentDirectoryPath stringByAppendingPathComponent:fileName];

	if (aTableColumn == nil)
	{
		return([fileUrl absoluteString]);
	}
	else if ([aTableColumn.identifier isEqualToString:@"FileName"])
	{
		return([[fileUrl path] lastPathComponent]);
	}
	else if ([aTableColumn.identifier isEqualToString:@"FileSize"])
	{
		return(nil);
	}
	else if ([aTableColumn.identifier isEqualToString:@"FileDate"])
	{
		return(nil);
	}
	else
	{
		return(nil);
	}
		
	
	//return returnValue;
	
}




// ==============================================================================================
//
// ==============================================================================================
// This method is optional if you use bindings to provide the data
/*
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
	cellView = nil;
	if (cellView == nil)
	{
		// Create cell view
		//cellView = [[NSTableCellView alloc] initWithFrame:[cellView frame]];
		cellView = [NSTableCellView new];
		cellView.identifier = tableColumn.identifier;

		// Create image view field
//		auto imageView = [[NSImageView alloc] initWithFrame:[cellView frame]];
//		imageView.image = folderImage;
//		cellView.imageView = imageView;
//		[cellView addSubview:imageView];
		
		// Create text field
		//		auto textField = [[NSTextField alloc] initWithFrame:[cellView frame]];

		
		auto textField = [NSTextField new];
		[textField setIdentifier:tableColumn.identifier];
		[textField setBordered:YES];
		[textField setDrawsBackground:YES];
		[textField setStringValue: @"textfield"];
		cellView.textField = textField;
		[cellView addSubview:textField];
		return cellView;
	}
	if ([tableColumn.identifier isEqualToString:@"FileName"])
	{
		// We pass us as the owner so we can setup target/actions into this main controller object
		NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
		if (cellView == nil)
		{
			//cellView = [NSTableCellView new];
  		cellView = [[NSTableCellView alloc] initWithFrame:CGRectMake(0.0, 0.0, 37.0, 37.0)];
			cellView.identifier = tableColumn.identifier;
			NSUInteger resizeAllMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin);
			[cellView setAutoresizingMask:resizeAllMask];
			[cellView setTranslatesAutoresizingMaskIntoConstraints:NO];
			cellView.objectValue = @"la taille du fichier";

			// Create image view field
			auto imageView = [[NSImageView alloc] initWithFrame:[cellView frame]];
			imageView.image = folderImage;
			cellView.imageView = imageView;

			[cellView addSubview:imageView];
			// Create text field
			//auto textField = [NSTextField new];
			auto textField = [[NSTextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 37.0, 37.0)];
			//[textField setIdentifier:tableColumn.identifier];
			[textField setBordered:YES];
			[textField setDrawsBackground:YES];
			[textField setStringValue: @"textfield"];
			cellView.textField = textField;
			[cellView addSubview:textField];
		}
		// Then setup properties on the cellView based on the column
		cellView.textField.stringValue = @"qwertyuiop";
		//cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];
		return cellView;
	}
	else if ([tableColumn.identifier isEqualToString:@"FileSize"])
	{
		NSTextField *textField = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
		if (textField == nil)
		{
			textField = [NSTextField new];
			textField.identifier = tableColumn.identifier;
			[textField setBordered:NO];
			[textField setDrawsBackground:NO];
			[textField setStringValue: @"textfield"];
		}
		textField.objectValue = @"la taille du fichier";
		return textField;
	}
	else
	{
		NSAssert1(NO, @"Unhandled table column identifier %@", tableColumn.identifier);
	}
	return nil;
	
	
}
*/

/*
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	   NSString *identifier = [tableColumn identifier];
		// get a cell if already exist
		//NSTableCellView *selectedCell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
		//NSTextField *selectedCell = [tableView makeViewWithIdentifier:identifier owner:self];
		NSTableCellView *selectedCell = [tableView makeViewWithIdentifier:identifier owner:self];
	// Then setup properties on the cellView based on the column
	
	
	
		//NSTableCellView *selectedCell = [tableView makeViewWithIdentifier:@"MyView" owner:self];

	// There is no existing cell to reuse so we will create a new one
	if (selectedCell == nil)
	{

		//NSURL *imageURL = [NSURL URLWithString:@"http://www.cmf.be/images/button2.jpg"];
		//http://www.techlogica.us/images/stock/icons/free/16_document.png
		//NSData *imageData = [imageURL resourceDataUsingCache:NO];
		//NSImage *image = [[NSImage alloc] initWithData:imageData];
		
		
		// create the new NSTextField with a frame of the {0,0} with the width of the table
		// note that the height of the frame is not really relevant, the row-height will modify the height
		// the new text field is then returned as an autoreleased object
		//selectedCell = [NSTextField new];
		selectedCell = [NSTableCellView new];
		NSColor *myColor = [NSColor colorWithCalibratedRed:0.7f green:0.7f blue:1.0f alpha:0.5f];
//		NSColor *myColor = [NSColor grayColor];

		
		[selectedCell.textField setBackgroundColor:myColor];
		[selectedCell.textField setTextColor:[NSColor blackColor]];

		
		[[selectedCell.textField cell] setControlSize:NSSmallControlSize];
		[selectedCell.textField setBordered:YES];
		[selectedCell.textField setBezeled:NO];
		[selectedCell.textField setSelectable:YES];
		[selectedCell.textField setEditable:NO];
		
		NSFont *regular = [NSFont fontWithName:@"Verdana" size:10];
		NSFont *bold = [NSFont fontWithName:@"Verdana-Bold" size:10];
		NSFont *italic = [NSFont fontWithName:@"Verdana-Italic" size:10];
		NSFont *bolditalic = [NSFont fontWithName:@"Verdana-BoldItalic" size:10];
		
		NSFontManager *fontManager = [NSFontManager sharedFontManager];
		NSFont *verdanaboldItalic = [fontManager fontWithFamily:@"Verdana"
																							traits:NSBoldFontMask|NSItalicFontMask
																							weight:15

																											 size:10];
		NSFont *sourcesanspro = [fontManager fontWithFamily:@"SourceSansPro-Bold"
																										 traits:NSBoldFontMask
																										 weight:15
																											 size:12];
		
		//[selectedCell setFont:[NSFont systemFontOfSize:8.0]];
		[selectedCell.textField setFont:sourcesanspro];
		
//		[selectedCell.cell drawsBackground:NO];

		//[selectedCell setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
		//[selectedCell setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		//selectedCell = [NSTableCellView new];
		// the identifier of the NSTextField instance is set to MyView. This
		// allows it to be re-used
		selectedCell.identifier = identifier;
	}
	
	
	if (row < 10)
	{
		[selectedCell.textField setTextColor:[NSColor blueColor]];
		//selectedCell.imageView.objectValue = folderImage;
//		selectedCell.textField.stringValue = [dictionary objectForKey:@"Name"];
		selectedCell.imageView.objectValue = folderImage;
		
	}
	else
	{
		[selectedCell.textField setTextColor:[NSColor blackColor]];
		selectedCell.imageView.objectValue = folderImage;
	}
	
	
	//int selectedColumn = 0;
		//int selectedRow = 0;
		//NSTableCellView *selectedCell = [tableView viewAtColumn:selectedColumn row:selectedRow makeIfNecessary:NO];
	
		//selectedCell.textField.backgroundColor = myColor;
		auto *fileName = [_files objectAtIndex:row];
		//auto fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[_currentDirectoryPath stringByAppendingString:@"/"] stringByAppendingString:fileName] error:nil] fileSize];
		auto fileSize = 123456;
		//long fileSize = 123456;
		//selectedCell.textField.stringValue = myText;


	

	if ([identifier isEqualToString:@"FileName"])
		{
			//selectedCell.stringValue = fileName;
			selectedCell.textField.stringValue = @"BLURP";
		}
		else if ([identifier isEqualToString:@"FileSize"])
		{
			//selectedCell.textField.stringValue = [[NSNumber numberWithLong:fileSize] stringValue];
			selectedCell.textField.stringValue = @"BLURP";
		}

	selectedCell.textField.stringValue = @"BLURP";

	//cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];

	//return selectedCell;
		return selectedCell;
	
//		NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
//		//NSImage *image = [dictionary objectForKey:@"Image"];
//		//NSSize size = image ? [image size] : NSZeroSize;
//		//NSString *sizeString = [NSString stringWithFormat:@"%.0fx%.0f", size.width, size.height];
//		textField.objectValue = @"Size";
//		return textField;
	 
}
*/


// ==============================================================================================
//
// ==============================================================================================
//- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
//{
//	NSTableCellView *currentCellView = [[_tableView rowViewAtRow:[_tableView selectedRow] makeIfNecessary:YES] viewAtColumn:0];
//	[currentCellView setBackgroundStyle:NSBackgroundStyleLowered];
//
//}

/*
- (void)highlightSelectionInClipRect:(NSRect)theClipRect
{
	
	// this method is asking us to draw the hightlights for
	// all of the selected rows that are visible inside theClipRect
	
	// 1. get the range of row indexes that are currently visible
	// 2. get a list of selected rows
	// 3. iterate over the visible rows and if their index is selected
	// 4. draw our custom highlight in the rect of that row.
	NSRange         aVisibleRowIndexes = [self._tableView rowsInRect:theClipRect];
	NSIndexSet *    aSelectedRowIndexes = [self._tableView selectedRowIndexes];
	long             aRow = aVisibleRowIndexes.location;
	long             anEndRow = aRow + aVisibleRowIndexes.length;
	NSGradient *    gradient;
	NSColor *       pathColor;
	
	// if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
	if (self._tableView == [[self._tableView window] firstResponder] && [[self._tableView window] isMainWindow] && [[self._tableView window] isKeyWindow])
	{
		gradient = [[NSGradient alloc] initWithColorsAndLocations:
								 [NSColor colorWithDeviceRed:(float)62/255 green:(float)133/255 blue:(float)197/255 alpha:1.0], 0.0,
								 [NSColor colorWithDeviceRed:(float)48/255 green:(float)95/255 blue:(float)152/255 alpha:1.0], 1.0, nil]; //160 80
		
		pathColor = [NSColor colorWithDeviceRed:(float)48/255 green:(float)95/255 blue:(float)152/255 alpha:1.0];
	}
	else
	{
		gradient = [[NSGradient alloc] initWithColorsAndLocations:
								 [NSColor colorWithDeviceRed:(float)190/255 green:(float)190/255 blue:(float)190/255 alpha:1.0], 0.0,
								 [NSColor colorWithDeviceRed:(float)150/255 green:(float)150/255 blue:(float)150/255 alpha:1.0], 1.0, nil];
		
		pathColor = [NSColor colorWithDeviceRed:(float)150/255 green:(float)150/255 blue:(float)150/255 alpha:1.0];
	}
	
	// draw highlight for the visible, selected rows
	for (aRow; aRow < anEndRow; aRow++)
	{
		if([aSelectedRowIndexes containsIndex:aRow])
		{
			NSRect aRowRect = NSInsetRect([self._tableView rectOfRow:aRow], 1, 4); //first is horizontal, second is vertical
			NSBezierPath * path = [NSBezierPath bezierPathWithRoundedRect:aRowRect xRadius:4.0 yRadius:4.0]; //6.0
			[path setLineWidth: 2];
			[pathColor set];
			[path stroke];
			
			[gradient drawInBezierPath:path angle:90];
		}
	}
}
*/
 
@end
