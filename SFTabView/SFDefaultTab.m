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
        _activeTab = [NSImage imageNamed:@"activeTab"];
		_inactiveTab = [NSImage imageNamed:@"inactiveTab"];
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
    _activeCloseHighlight = [NSImage imageNamed:@"tabClose"];

    _closeLayer = [[SFCloseLayer alloc] init];
    [_closeLayer setFrame:NSMakeRect(self.frame.size.width - _activeCloseHighlight.size.width - 16.0, (self.frame.size.height - _activeCloseHighlight.size.height) / 2, _activeCloseHighlight.size.width, _activeCloseHighlight.size.height)];
    [_closeLayer setContents:_activeCloseHighlight];
    [_closeLayer setOpacity:0.0f];
    _closeLayerHovered = NO;

    [self addSublayer:_closeLayer];
}


- (BOOL)overCloseButton:(NSPoint)point
{
    return point.x < _closeLayer.frame.size.width && point.x > 0 && point.y < _closeLayer.frame.size.height && point.y > 0;
}


- (void)mousemove:(NSPoint)point
{
    CGPoint relative = [_closeLayer convertPoint:point fromLayer:self.superlayer];
    if ([self overCloseButton:relative])
    {
        if (_closeLayerHovered == NO)
        {
            [_closeLayer setOpacity:100.0f];
            _closeLayerHovered = YES;
        }
    }
    else
    {
        if (_closeLayerHovered == YES)
        {
            [_closeLayer setOpacity:0.0f];
            _closeLayerHovered = NO;
        }
    }
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
