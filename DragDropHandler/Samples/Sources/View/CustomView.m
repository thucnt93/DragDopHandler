//
//  CustomView.m
//  Samples
//
//  Created by Phu Tran on 1/26/21.
//

#import "CustomView.h"
#import "NSView+init.h"

@implementation CustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor lightGrayColor] CGColor];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self createFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self createFromNib];
    }
    return self;
}

@end
