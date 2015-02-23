//
//  SFDefaultTab.h
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SFTabView.h"



@interface SFLabelLayer : CATextLayer
@end



@interface SFCloseLayer : CALayer
@end



@interface SFDefaultTab : CALayer
{
    id _representedObject;

    SFLabelLayer *_tabLabel;

    // Close layer
    SFCloseLayer *_closeLayer;
}

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL closeLayerHovered;
@property (nonatomic, retain) NSFont *tabLabelFont;
@property (nonatomic, assign) CGColorRef tabLabelActiveColor;
@property (nonatomic, assign) CGColorRef tabLabelInactiveColor;

@property (nonatomic, assign) BOOL showCloseButton;

- (void)mouseDown;
- (void)mouseMoved:(NSPoint)point;
- (void)setRepresentedObject:(id)representedObject;
- (void)setLabelName:(NSString *)name;

@end
