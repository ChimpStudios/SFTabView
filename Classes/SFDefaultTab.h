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

@interface SFLabelLayer : CATextLayer {}
@end

@interface SFCloseLayer : CALayer {}
@end

@interface SFDefaultTab : CALayer {
    id _representedObject;
    SFCloseLayer *layer;
}

@property BOOL hovered;

- (void) mousemove:(NSPoint)point;
- (void) setRepresentedObject: (id) representedObject;
- (void) setSelected: (BOOL) selected;
- (BOOL) hittestCloseButton: (NSEvent*)event;

@end
