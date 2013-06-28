//========================================================================================
//
//========================================================================================

#import <Cocoa/Cocoa.h>

@interface JsDirectoryTableViewDelegate : NSWindowController<NSTableViewDelegate, NSTableViewDataSource>
{
//	@private
	// An array of dictionaries that contain the contents to display
//	NSMutableArray *_tableContents;
//	NSTableView *_tableView;
//	NSMutableArray *_files;
	//NSImage *folderImage;
}

//@property NSMutableArray *_tableContents;
@property NSTableView *_tableView;
@property JsDirectoryTableViewDelegate *_targetTableViewDelegate;
@property NSImage *folderImage;
@property NSString *_currentDirectoryPath;
@property NSMutableArray *_files;


- (void) setCurrentDirectoryPath:(NSString *)currentDirectoryPath;

@end
