//
//  SFDefaultTab.m
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFDefaultTab.h"

static CGImageRef  activeTab;
static CGImageRef  inactiveTab;

static CGImageRef  activeClose;
static CGImageRef  inactiveClose;


@implementation SFLabelLayer
- (BOOL)containsPoint:(CGPoint)p
{
	return FALSE;
}
@end

@implementation SFDefaultTab

- (void) setRepresentedObject: (id) representedObject {
	CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];

    _representedObject = representedObject;
    self.frame = CGRectMake(0, 0, 125, 28);
	if(!activeTab) {
		CFStringRef path = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"activeTab" ofType:@"png"];
		CFURLRef imageURL = CFURLCreateWithFileSystemPath(nil, path, kCFURLPOSIXPathStyle, NO);
		CGImageSourceRef imageSource = CGImageSourceCreateWithURL(imageURL, nil);
		activeTab = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
		CFRelease(imageURL); CFRelease(imageSource);

		
		path = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"inactiveTab" ofType:@"png"];
		imageURL = CFURLCreateWithFileSystemPath(nil, path, kCFURLPOSIXPathStyle, NO);
		imageSource = CGImageSourceCreateWithURL(imageURL, nil);
		inactiveTab = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
		CFRelease(imageURL); CFRelease(imageSource);
	}
	
	[self setContents: (id)inactiveTab];

    SFLabelLayer *tabLabel = [SFLabelLayer layer];
	
	if ([representedObject objectForKey:@"name"] != nil) {
		tabLabel.string = [representedObject objectForKey:@"name"];
	}
	
	[tabLabel setFontSize:13.0f];
	[tabLabel setShadowOpacity:.9f];
	tabLabel.shadowOffset = CGSizeMake(0, -1);
	tabLabel.shadowRadius = 1.0f;
	tabLabel.shadowColor = CGColorCreateGenericRGB(1,1,1, 1);
	tabLabel.foregroundColor = CGColorCreateGenericRGB(0.1,0.1,0.1, 1);
	tabLabel.truncationMode = kCATruncationEnd;
	tabLabel.alignmentMode = kCAAlignmentCenter;
	CAConstraint *constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX
                                                          relativeTo:@"superlayer"
                                                           attribute:kCAConstraintMidX];    
    [tabLabel addConstraint:constraint];
    
    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMidY
												offset:-2.0];
    [tabLabel addConstraint:constraint];

	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMaxX
												offset:-20.0];
    [tabLabel addConstraint:constraint];

	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMinX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMinX
												offset:20.0];
    [tabLabel addConstraint:constraint];
	
	
	[tabLabel setFont:@"LucidaGrande"];
	
	[self addSublayer:tabLabel];
    [self setupCloseButton];
}

- (void) setupCloseButton {
    CFStringRef close = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"tabClose" ofType:@"png"];
    CFURLRef closeURL = CFURLCreateWithFileSystemPath(nil, close, kCFURLPOSIXPathStyle, NO);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL(closeURL, nil);
    activeClose = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
    CFRelease(closeURL); CFRelease(imageSource);

//    close = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"inactiveClose" ofType:@"png"];
//    closeURL = CFURLCreateWithFileSystemPath(nil, close, kCFURLPOSIXPathStyle, NO);
//    imageSource = CGImageSourceCreateWithURL(closeURL, nil);
//    inactiveClose = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
//    CFRelease(closeURL); CFRelease(imageSource);

    CALayer* layer = [[CALayer alloc] init];
    [layer setFrame: CGRectMake(50, 5, 10, 10)];
    [layer setContents:(id)activeClose];
	[self addSublayer:layer];
}

- (void) setSelected: (BOOL) selected {
    [CATransaction begin]; 
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

    if (selected)
        [self setContents: (id)activeTab];
    else
        [self setContents: (id)inactiveTab];
    
    [CATransaction commit];

}

@end
