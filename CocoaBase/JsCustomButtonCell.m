//========================================================================================
//
//========================================================================================

#import "JsCustomButtonCell.h"

@implementation JsCustomButtonCell



//drawBezelWithFrame:inView:
//drawText:withFrame:inView:
//drawImage:withFrame:inView:

- (NSSize)cellSizeForBounds:(NSRect)aRect
{
	//NSSize size = NSMakeSize(aRect.size.width, aRect.size.height);
	//NSSize size = NSMakeSize(64, 32);
	NSSize size = NSMakeSize(64, 24);
	return size;
}


-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	[self drawTitle:[self attributedTitle] withFrame:cellFrame inView:controlView];

	
/*		
//	controlView.frame = NSMakeRect(controlView.frame.origin.x, controlView.frame.origin.y, controlView.frame.size.width, 32);
	
	//NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha:1.0f];
	//[baseColor set];
	//NSRectFill(cellFrame);
	

	//// Color Declarations
	NSColor* baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha: 1];
	NSColor* lowerColor = [baseColor shadowWithLevel: 0.1];
	NSColor* upperColor = [baseColor highlightWithLevel: 0.2];
	NSColor* lightUpColor = [baseColor highlightWithLevel: 0.5];
	NSColor* lightDownColor = [baseColor shadowWithLevel: 0.2];
	
	//// Gradient Declarations
	NSGradient* buttonGradient = [[NSGradient alloc] initWithStartingColor: upperColor endingColor: lowerColor];
	NSGradient* overlayGradient = [[NSGradient alloc] initWithStartingColor: lightUpColor endingColor: [NSColor clearColor]];
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor: lightUpColor endingColor: lightDownColor];
	
	//// Shadow Declarations
	NSShadow* buttonShadow = [[NSShadow alloc] init];
	[buttonShadow setShadowColor: [NSColor blackColor]];
	[buttonShadow setShadowOffset: NSMakeSize(0, -1)];
	[buttonShadow setShadowBlurRadius: 2];
	NSShadow* textShadow = [[NSShadow alloc] init];
	[textShadow setShadowColor: [NSColor blackColor]];
	[textShadow setShadowOffset: NSMakeSize(0, 0)];
	[textShadow setShadowBlurRadius: 5];
	
	//// Abstracted Graphic Attributes
	NSString* textContent = @"Update";
	//NSString* textContent = title.string;

//	NSString *textContent = nil;
//	if (title.class == NSString.class)
//	{
//		textContent = title.string;
//	}
//	else
//	{
//		textContent = title.string;
//	}
	
	
	
	
	auto frameX1 = cellFrame.origin.x + 2;
	auto frameY1 = cellFrame.origin.y + 2;
	auto frameX2 = cellFrame.origin.x + cellFrame.size.width - 2;
	auto frameY2 = cellFrame.origin.y + cellFrame.size.height - 2;
	
	
	//// Back Rectangle Drawing
	//NSBezierPath* backRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(48, 44, 120, 23) xRadius: 4 yRadius: 4];
	NSBezierPath* backRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frameX1, frameY1, frameX2, frameY2) xRadius: 4 yRadius: 4];
	[NSGraphicsContext saveGraphicsState];
	[buttonShadow set];
	[buttonShadow.shadowColor setFill];
	[backRectanglePath fill];
	[gradient drawInBezierPath: backRectanglePath angle: -90];
	[NSGraphicsContext restoreGraphicsState];
	
	
	
	//// Rounded Rectangle Drawing
	//NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(49, 45, 118, 21) xRadius: 3 yRadius: 3];
	NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frameX1 + 1, frameY1 + 1, frameX2 - 2, frameY2 - 2) xRadius: 3 yRadius: 3];
	[buttonGradient drawInBezierPath: roundedRectanglePath angle: -90];
	
	
	
	//// Overlay Drawing
	//NSBezierPath* overlayPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(48, 44, 120, 23) xRadius: 4 yRadius: 4];
	NSBezierPath* overlayPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frameX1, frameY1, frameX2, frameY2) xRadius: 4 yRadius: 4];
	[NSGraphicsContext saveGraphicsState];
	[overlayPath addClip];
	[overlayGradient drawFromCenter: NSMakePoint(54.72, 81.91) radius: 10
												 toCenter: NSMakePoint(108, 108.54) radius: 102.2
													options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
	[NSGraphicsContext restoreGraphicsState];
	
	
	
	//// Text Drawing
	[NSGraphicsContext saveGraphicsState];
	[textShadow set];
	NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
	[textStyle setAlignment: NSCenterTextAlignment];
	
	NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName: @"(null)" size: 14], NSFontAttributeName,[NSColor whiteColor], NSForegroundColorAttributeName,textStyle, NSParagraphStyleAttributeName, nil];
	
	//NSRect textFrame = NSMakeRect(55, 45, 104, 21);
	NSRect textFrame = NSMakeRect(frameX1 + 7, frameY1 + 1, frameX2 - 16, frameY2 - 2);
	[textContent drawInRect: textFrame withAttributes: textFontAttributes];
	[NSGraphicsContext restoreGraphicsState];
*/
	
}


// ==============================================================================================
// =
// ==============================================================================================

- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView
{
/*
  NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
  CGContextRef contextRef = [ctx graphicsPort];
  
  NSData *data = [image TIFFRepresentation]; // open for suggestions
  CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)CFBridgingRetain(data), NULL);
  if(source) {
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CFRelease(source);
    
    // Draw shadow 1px below image
    
    CGContextSaveGState(contextRef);
    {
      NSRect rect = NSOffsetRect(frame, 0.0f, 1.0f);
      CGFloat white = [self isHighlighted] ? 0.2f : 0.35f;
      CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
      [[NSColor colorWithDeviceWhite:white alpha:1.0f] setFill];
      NSRectFill(rect);
    }
    CGContextRestoreGState(contextRef);
    
    // Draw image
    
    CGContextSaveGState(contextRef);
    {
      NSRect rect = frame;
      CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
      [[NSColor colorWithDeviceWhite:0.1f alpha:1.0f] setFill];
      NSRectFill(rect);
    }
    CGContextRestoreGState(contextRef);
    
    CFRelease(imageRef);
  }
*/
}




// ==============================================================================================
// =
// ==============================================================================================
/*
- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView
{
	return frame;
}
*/	

- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView
{

	NSString *textContent = title.string;
/*
	if (frame.size.height != 32)
	{
		frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 32.0f);
	}
*/
	
	if (YES)
	{
		//NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha:1.0f];
		//[baseColor set];
		//NSRectFill(frame);
		
		
		//// Color Declarations
		NSColor* frameColorTop = [NSColor colorWithCalibratedRed: 0.15 green: 0.15 blue: 0.15 alpha: 1];
		NSColor* frameShadowColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.4];
		//NSColor* buttonColor = [NSColor colorWithCalibratedRed: 0.73 green: 0 blue: 0.09 alpha: 1];
		
		// button color
		//NSColor* buttonColor = [NSColor colorWithCalibratedRed: 0.1 green: 0 blue: 0.1 alpha: 1];
		NSColor* buttonColor = nil;
		if ([textContent isEqualToString:@"Delete"])
		{
			buttonColor = [NSColor colorWithCalibratedRed: 0.45 green: 0.15 blue: 0.15 alpha: 1];
		}
		else if ([textContent isEqualToString:@"Read"])
		{
			buttonColor = [NSColor colorWithCalibratedRed: 0.15 green: 0.15 blue: 0.0 alpha: 1];
		}
		else if ([[controlView identifier] isEqualToString:@"bottomStatusRButton"])
		{
			buttonColor = [NSColor colorWithCalibratedRed: 0.10 green: 0.10 blue: 0.20 alpha: 1];
		}
		else if ([textContent isEqualToString:@"Calc"])
		{
			buttonColor = [NSColor colorWithCalibratedRed: 1.0 green: 0.65 blue: 0.65 alpha: 1];
		}
		else if ([textContent isEqualToString:@"Copy"] || [textContent isEqualToString:@"Move"] || [textContent isEqualToString:@"Rename"])
		{
			buttonColor = [NSColor colorWithCalibratedRed: 0.15 green: 0.45 blue: 0.15 alpha: 1];
		}
		else
		{
			buttonColor = [NSColor colorWithCalibratedRed: 0.05 green: 0 blue: 0.05 alpha: 1];
		}
		
		NSColor* glossyColorBottom = [buttonColor highlightWithLevel: 0.4];
		//NSColor* glossyColorUp = [buttonColor highlightWithLevel: 0.8];
		NSColor* glossyColorUp = [buttonColor highlightWithLevel: 0.7];
		
		//// Gradient Declarations
		NSGradient* glossyGradient = [[NSGradient alloc] initWithStartingColor: glossyColorUp endingColor: glossyColorBottom];
		
		//// Shadow Declarations
		NSShadow* frameInnerShadow = [[NSShadow alloc] init];
		[frameInnerShadow setShadowColor: frameShadowColor];
		[frameInnerShadow setShadowOffset: NSMakeSize(0, 0)];
		[frameInnerShadow setShadowBlurRadius: 3];
		NSShadow* buttonInnerShadow = [[NSShadow alloc] init];
		[buttonInnerShadow setShadowColor: [NSColor blackColor]];
		[buttonInnerShadow setShadowOffset: NSMakeSize(0, 0)];
		[buttonInnerShadow setShadowBlurRadius: 12];
		NSShadow* textShadow = [[NSShadow alloc] init];
		[textShadow setShadowColor: [NSColor blackColor]];
		[textShadow setShadowOffset: NSMakeSize(0, 0)];
		[textShadow setShadowBlurRadius: 3];
		NSShadow* buttonShadow = [[NSShadow alloc] init];
		[buttonShadow setShadowColor: [NSColor blackColor]];
		[buttonShadow setShadowOffset: NSMakeSize(0, -2)];
		[buttonShadow setShadowBlurRadius: 3];
		
		
		
		//// outerFrame Drawing
		//NSBezierPath* outerFramePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(2.5, 1.5, 120, 32) xRadius: 8 yRadius: 8];
		NSBezierPath* outerFramePath = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) xRadius: 8 yRadius: 8];
		[NSGraphicsContext saveGraphicsState];
		[buttonShadow set];
		[frameColorTop setFill];
		[outerFramePath fill];
		[NSGraphicsContext restoreGraphicsState];
		
		[[NSColor blackColor] setStroke];
		[outerFramePath setLineWidth: 1];
		[outerFramePath stroke];
		
		
		//// innerFrame Drawing
		//NSBezierPath* innerFramePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(5.5, 4.5, 114, 26) xRadius: 5 yRadius: 5];
		NSBezierPath* innerFramePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frame.origin.x+3, frame.origin.y+3, frame.size.width-6, frame.size.height-6) xRadius: 5 yRadius: 5];
		[NSGraphicsContext saveGraphicsState];
		[frameInnerShadow set];
		[buttonColor setFill];
		[innerFramePath fill];
		
		////// innerFrame Inner Shadow
		NSRect innerFrameBorderRect = NSInsetRect([innerFramePath bounds], -buttonInnerShadow.shadowBlurRadius, -buttonInnerShadow.shadowBlurRadius);
		innerFrameBorderRect = NSOffsetRect(innerFrameBorderRect, -buttonInnerShadow.shadowOffset.width, buttonInnerShadow.shadowOffset.height);
		innerFrameBorderRect = NSInsetRect(NSUnionRect(innerFrameBorderRect, [innerFramePath bounds]), -1, -1);
		
		NSBezierPath* innerFrameNegativePath = [NSBezierPath bezierPathWithRect: innerFrameBorderRect];
		[innerFrameNegativePath appendBezierPath: innerFramePath];
		[innerFrameNegativePath setWindingRule: NSEvenOddWindingRule];
		
		[NSGraphicsContext saveGraphicsState];
		{
			NSShadow* innerShadow = [buttonInnerShadow copy];
			CGFloat xOffset = innerShadow.shadowOffset.width + round(innerFrameBorderRect.size.width);
			CGFloat yOffset = innerShadow.shadowOffset.height;
			innerShadow.shadowOffset = NSMakeSize(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset));
			[innerShadow set];
			[[NSColor grayColor] setFill];
			[innerFramePath addClip];
			NSAffineTransform* transform = [NSAffineTransform transform];
			[transform translateXBy: -round(innerFrameBorderRect.size.width) yBy: 0];
			[[transform transformBezierPath: innerFrameNegativePath] fill];
		}
		[NSGraphicsContext restoreGraphicsState];
		
		[NSGraphicsContext restoreGraphicsState];
		
		[[NSColor blackColor] setStroke];
		[innerFramePath setLineWidth: 1];
		[innerFramePath stroke];
		
		
		//// Rounded Rectangle Drawing
		//NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(8, 6, 109, 9) xRadius: 4 yRadius: 4];
		NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(frame.origin.x+5.5, frame.origin.y+4.5, frame.size.width-11, frame.size.height/3) xRadius: 4 yRadius: 4];
		[glossyGradient drawInBezierPath: roundedRectanglePath angle: 90];
		
		
		
		//// Text Drawing
		[NSGraphicsContext saveGraphicsState];
		[textShadow set];
		NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
		[textStyle setAlignment: NSCenterTextAlignment];
		
		NSInteger fontSize = 10;
		NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont boldSystemFontOfSize: fontSize], NSFontAttributeName, glossyColorUp, NSForegroundColorAttributeName, textStyle, NSParagraphStyleAttributeName, nil];
		//NSRect textFrame = NSMakeRect(18, 6, 90, 28);
		NSRect textFrame = NSMakeRect(frame.origin.x, frame.origin.y + ((frame.size.height - fontSize)/2), frame.size.width, frame.size.height);
		[textContent drawInRect: textFrame withAttributes: textFontAttributes];
		[NSGraphicsContext restoreGraphicsState];
		
	}
	else if (NO)
	{
		//// Color Declarations
		NSColor* baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha: 1];
		NSColor* lowerColor = [baseColor shadowWithLevel: 0.1];
		NSColor* upperColor = [baseColor highlightWithLevel: 0.2];
		NSColor* lightUpColor = [baseColor highlightWithLevel: 0.5];
		NSColor* lightDownColor = [baseColor shadowWithLevel: 0.2];
		
		//// Gradient Declarations
		NSGradient* buttonGradient = [[NSGradient alloc] initWithStartingColor: upperColor endingColor: lowerColor];
		NSGradient* overlayGradient = [[NSGradient alloc] initWithStartingColor: lightUpColor endingColor: [NSColor clearColor]];
		NSGradient* gradient = [[NSGradient alloc] initWithStartingColor: lightUpColor endingColor: lightDownColor];
		
		//// Shadow Declarations
		NSShadow* buttonShadow = [[NSShadow alloc] init];
		[buttonShadow setShadowColor: [NSColor blackColor]];
		[buttonShadow setShadowOffset: NSMakeSize(0, -1)];
		[buttonShadow setShadowBlurRadius: 2];
		NSShadow* textShadow = [[NSShadow alloc] init];
		[textShadow setShadowColor: [NSColor blackColor]];
		[textShadow setShadowOffset: NSMakeSize(0, 0)];
		[textShadow setShadowBlurRadius: 5];
		
		
		//// Back Rectangle Drawing
		//NSBezierPath* backRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(48, 44, 120, 23) xRadius: 4 yRadius: 4];
		NSBezierPath* backRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) xRadius: 4 yRadius: 4];
		[NSGraphicsContext saveGraphicsState];
		[buttonShadow set];
		[buttonShadow.shadowColor setFill];
		[backRectanglePath fill];
		[gradient drawInBezierPath: backRectanglePath angle: -90];
		[NSGraphicsContext restoreGraphicsState];
		
		
		
		//// Rounded Rectangle Drawing
//		NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(49, 45, 118, 21) xRadius: 3 yRadius: 3];
		NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frame.origin.x+1, frame.origin.y+1, frame.size.width-2, frame.size.height-2) xRadius: 3 yRadius: 3];
		[buttonGradient drawInBezierPath: roundedRectanglePath angle: -90];
		
		
		
		//// Overlay Drawing
//		NSBezierPath* overlayPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(48, 44, 120, 23) xRadius: 4 yRadius: 4];
		NSBezierPath* overlayPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) xRadius: 4 yRadius: 4];
		[NSGraphicsContext saveGraphicsState];
		[overlayPath addClip];
//		[overlayGradient drawFromCenter: NSMakePoint(54.72, 81.91) radius: 10 toCenter: NSMakePoint(108, 108.54) radius: 102.2 options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
		[overlayGradient drawFromCenter: NSMakePoint(54.72, 81.91) radius: 10 toCenter: NSMakePoint(108, 108.54) radius: 102.2 options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
		[NSGraphicsContext restoreGraphicsState];
		
		
		
		//// Text Drawing
		[NSGraphicsContext saveGraphicsState];
		[textShadow set];
		NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
		[textStyle setAlignment: NSCenterTextAlignment];
		
		NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
																				[NSFont fontWithName: @"(null)" size: 14], NSFontAttributeName,
																				[NSColor whiteColor], NSForegroundColorAttributeName,
																				textStyle, NSParagraphStyleAttributeName, nil];
		
//		NSRect textFrame = NSMakeRect(55, 45, 104, 21);
		NSRect textFrame = NSMakeRect(frame.origin.x+7, frame.origin.y+1, frame.size.width-16, frame.size.height-2);
		[textContent drawInRect: textFrame withAttributes: textFontAttributes];
		[NSGraphicsContext restoreGraphicsState];
		
	}
		
		
	return frame;
}


// ==============================================================================================
// =
// ==============================================================================================

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
	//NSColor *baseColor = [NSColor colorWithCalibratedRed: 0.22 green: 0.24 blue: 0.27 alpha:1.0f];
	//[baseColor set];
	//NSRectFill(frame);
}


@end
