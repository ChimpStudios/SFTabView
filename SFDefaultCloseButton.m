//
//  SFDefaultCloseButton.m
//  SFTabView
//
//  Created by William Wettersten on 3/11/14.
//
//

#import "SFDefaultCloseButton.h"

static CGImageRef button;

@implementation SFDefaultCloseButton

- (void) setRepresentedObject: (id) representedObject {
    CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];
    
    _representedObject = representedObject;
    self.frame = CGRectMake(0, 0, 200, 200);
    
    CFStringRef path = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"tabClose" ofType:@"png"];
    CFURLRef imageURL = CFURLCreateWithFileSystemPath(nil, path, kCFURLPOSIXPathStyle, NO);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL(imageURL, nil);
    button = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
    CFRelease(imageURL); CFRelease(imageSource);
    
    [self setContents: (id)button];
}

@end
