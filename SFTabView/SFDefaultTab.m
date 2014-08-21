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

    if (!_activeTab)
    {
        _activeTab = [NSImage imageNamed:@"activeTab"];
		_inactiveTab = [NSImage imageNamed:@"inactiveTab"];
    }
    self.frame = CGRectMake(0, 0, _activeTab.size.width, _activeTab.size.height);

    [self setContents:_inactiveTab];

    _tabLabel = [SFLabelLayer layer];
    if (representedObject[@"name"] != nil)
    {
        _tabLabel.string = representedObject[@"name"];
    }
    _tabLabel.fontSize = 13.0f;
    _tabLabel.shadowOpacity = 0.9f;
    _tabLabel.shadowOffset = CGSizeMake(0, -1);
    _tabLabel.shadowRadius = 1.0f;
    _tabLabel.shadowColor = CGColorCreateGenericRGB(1, 1, 1, 1);
    _tabLabel.foregroundColor = CGColorCreateGenericRGB(102.0 / 255.0, 102.0 / 255.0, 102.0 / 255.0, 1);
    _tabLabel.truncationMode = kCATruncationEnd;
    _tabLabel.alignmentMode = kCAAlignmentCenter;
    CAConstraint *constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX
                                                          relativeTo:@"superlayer"
                                                           attribute:kCAConstraintMidX];
    [_tabLabel addConstraint:constraint];

    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMidY
                                                offset:-2.0];
    [_tabLabel addConstraint:constraint];

    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMaxX
                                                offset:-20.0];
    [_tabLabel addConstraint:constraint];

    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMinX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMinX
                                                offset:20.0];
    [_tabLabel addConstraint:constraint];

    [_tabLabel setFont:@"LucidaGrande"];

    [self addSublayer:_tabLabel];
    [self setupCloseButton];
}


- (void)setupCloseButton
{
    _activeCloseHighlight = [NSImage imageNamed:@"tabClose"];

    _closeLayer = [[SFCloseLayer alloc] init];
    _closeLayer.frame = NSMakeRect(self.frame.size.width - _activeCloseHighlight.size.width - 16.0, (self.frame.size.height - _activeCloseHighlight.size.height) / 2, _activeCloseHighlight.size.width, _activeCloseHighlight.size.height);
    _closeLayer.contents = _activeCloseHighlight;
    _closeLayer.hidden = YES;
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
            _closeLayer.hidden = NO;
            _closeLayerHovered = YES;
        }
    }
    else
    {
        if (_closeLayerHovered == YES)
        {
            _closeLayer.hidden = YES;
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
        _tabLabel.foregroundColor = CGColorCreateGenericRGB(51.0 / 255.0, 51.0 / 255.0, 51.0 / 255.0, 1);
    }
    else
    {
        [self setContents:_inactiveTab];
        _tabLabel.foregroundColor = CGColorCreateGenericRGB(102.0 / 255.0, 102.0 / 255.0, 102.0 / 255.0, 1);
    }
    [CATransaction commit];
}

@end
