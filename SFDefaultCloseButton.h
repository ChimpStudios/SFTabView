//
//  SFDefaultCloseButton.h
//  SFTabView
//
//  Created by William Wettersten on 3/11/14.
//
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SFTabView.h"

@interface SFDefaultCloseButton : CALayer {
    id _representedObject;
}

- (void) setRepresentedObject: (id) representedObject;

@end
