//
//  SFDefaultTab.m
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFDefaultTab.h"


@implementation SFLabelLayer
- (BOOL)containsPoint:(CGPoint)p
{
    return FALSE;
}
@end



@implementation SFCloseLayer
- (BOOL)containsPoint:(CGPoint)p
{
    return FALSE;
}
@end



@implementation SFDefaultTab

- (void)setRepresentedObject:(id)representedObject
{
    CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];

    _representedObject = representedObject;
    self.frame = CGRectMake(0, 0, 125, 28);
    if (!_activeTab)
    {
        _activeTab = [NSImage imageNamed:@"activeTab.png"];
		_inactiveTab = [NSImage imageNamed:@"inactiveTab.png"];
    }

    [self setContents:_inactiveTab];

    SFLabelLayer *tabLabel = [SFLabelLayer layer];
    if (representedObject[@"name"] != nil)
    {
        tabLabel.string = representedObject[@"name"];
    }
    tabLabel.fontSize = 13.0f;
    tabLabel.shadowOpacity = 0.9f;
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


- (void)setupCloseButton
{
    _activeCloseHighlight = [NSImage imageNamed:@"tabClose.png"];

    layer = [[SFCloseLayer alloc] init];
    [layer setFrame:CGRectMake(81, 2, 30, 24)];
    [layer setContents:_activeCloseHighlight];
    [layer setOpacity:0.0f];
    [self setHovered:false];

    [self addSublayer:layer];
}


- (BOOL)overCloseButton:(NSPoint)point
{
    return point.x < 25.0f && point.x > 0 && point.y < 25.0f && point.y > 0;
}


- (void)mousemove:(NSPoint)point
{
    CGPoint relative = [layer convertPoint:point fromLayer:nil];
    if ([self overCloseButton:relative])
    {
        if (!self.hovered)
        {
            [layer setOpacity:100.0f];
            [self setHovered:true];
        }
    }
    else
    {
        if (self.hovered)
        {
            [layer setOpacity:0.0f];
            [self setHovered:false];
        }
    }
}


- (BOOL)hittestCloseButton:(NSEvent*)event
{
    return [layer hitTest:[event locationInWindow]];
}


- (void)setSelected:(BOOL)selected
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    if (selected)
    {
        [self setContents:_activeTab];
    }
    else
    {
        [self setContents:_inactiveTab];
    }
    [CATransaction commit];
}

@end
