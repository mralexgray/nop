//========================================================================================
//
//========================================================================================

#import "JsCustomTableCellView.h"

@implementation JsCustomTableCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
		{
			// Initialization code here.
			NSImageView *customImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 16.0, 16.0)];
			[self addSubview:customImageView];
			[self setImageView:customImageView];

			NSTextField *customTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(18.0, 0.0, 320.0, 16.0)];
			[self addSubview:customTextField];
			[self setTextField:customTextField];
    }
    
    return self;
}




- (void)drawRect:(NSRect)dirtyRect
{


	
	NSGraphicsContext *gc = [NSGraphicsContext currentContext];
//	NSColor *listBgColor = [NSColor colorWithCalibratedRed:0.7f green:0.7f blue:1.0f alpha:1.0f];
//	NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha:1.0f];

//	[baseColor set];
	//NSRectFill(dirtyRect);
//	NSRectFill(NSMakeRect(0.0, 0.0, 16.0, 16.0));
	//[self.imageView.image drawAtPoint:NSMakePoint(0.0, 0.0) fromRect: NSMakeRect(0.0, 0.0, 32.0, 32.0) operation: NSCompositeSourceOver fraction: 1.0];
	

	
	
	
	
	
	
	
//	[[[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)] drawAtPoint:NSMakePoint(0.0, 0.0)
//							fromRect: NSMakeRect(0.0, 0.0, 16.0, 16.0)
//						 operation: NSCompositeSourceOver
//							fraction: 1.0];
	
	
	
	// set up #define constants and fonts here ...
	// set up text colors for main and secondary text in normal and highlighted cell states...
/*
	CGRect contentRect = self.bounds;
		CGFloat boundsX = contentRect.origin.x;
		CGPoint point;
		CGFloat actualFontSize;
		CGSize size;
		
		// draw main text
		[mainTextColor set];
		
		// draw time-zone locale string
		point = CGPointMake(boundsX + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP);
		[timeZoneWrapper.timeZoneLocaleName drawAtPoint:point forWidth:LEFT_COLUMN_WIDTH withFont:mainFont minFontSize:MIN_MAIN_FONT_SIZE actualFontSize:NULL lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
		
		// ... other strings drawn here...
		
		// draw secondary text
		[secondaryTextColor set];
		
		// draw the time-zone abbreviation
		point = CGPointMake(boundsX + LEFT_COLUMN_OFFSET, LOWER_ROW_TOP);
		[abbreviation drawAtPoint:point forWidth:LEFT_COLUMN_WIDTH withFont:secondaryFont minFontSize:MIN_SECONDARY_FONT_SIZE actualFontSize:NULL lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
		
		// ... other strings drawn here...
		
		// Draw the quarter image.
		CGFloat imageY = (contentRect.size.height - timeZoneWrapper.image.size.height) / 2;
		point = CGPointMake(boundsX + RIGHT_COLUMN_OFFSET, imageY);
		[timeZoneWrapper.image drawAtPoint:point];
*/	
	
}

@end
