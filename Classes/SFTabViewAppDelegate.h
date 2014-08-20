//
//  SFTabViewAppDelegate.h
//  SFTabView
//
//  Created by Matteo Rattotti on 5/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SFTabView.h"


@interface SFTabViewAppDelegate : NSObject <NSApplicationDelegate, SFTabViewDelegate>
{
    int number;

    NSWindow *__weak window;
    IBOutlet SFTabView *tabView;
}

@property (weak) IBOutlet NSWindow *window;

- (IBAction)removeTab:(id)sender;
- (IBAction)addTab:(id)sender;

@end
