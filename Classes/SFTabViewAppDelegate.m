//
//  SFTabViewAppDelegate.m
//  SFTabView
//
//  Created by Matteo Rattotti on 5/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import "SFTabViewAppDelegate.h"


@implementation SFTabViewAppDelegate

@synthesize window;


#pragma mark - Application stuff

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	tabView.delegate = self;
    [tabView addTabWithRepresentedObject:@{@"name": @"One"}];
	number = 1;
}



#pragma mark - IBAction

- (void)removeTab:(id)sender
{
    if ([tabView numberOfTabs] > 0)
    {
        --number;
        [tabView removeTab:[tabView selectedTab]];
    }
}


- (void)addTab:(id)sender
{
	++number;
	[tabView addTabWithRepresentedObject:@{@"name": [NSString stringWithFormat:@"%d", number]}];
	[tabView selectTab:[tabView lastTab]];
}



#pragma mark - SFTabViewDelegate

- (void)tabView:(SFTabView *)tabView didAddTab:(CALayer *)tab
{
    NSLog(@"didAddTab");
}


- (void)tabView:(SFTabView *)tabView didRemovedTab:(CALayer *)tab
{
    NSLog(@"didRemovedTab");
}


- (BOOL)tabView:(SFTabView *)tabView shouldSelectTab:(CALayer *)tab
{
    NSLog(@"shouldSelectTab");
    return YES;
}


- (void)tabView:(SFTabView *)tabView didSelectTab:(CALayer *)tab
{
    NSLog(@"didSelectTab");
}


- (void)tabView:(SFTabView *)tabView willSelectTab:(CALayer *)tab
{
    NSLog(@"willSelectTab");
}

@end
