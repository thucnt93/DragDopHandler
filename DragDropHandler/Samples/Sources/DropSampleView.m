//
//  DropSampleView.m
//  Samples
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DropSampleView.h"

@interface DropSampleView() {
    id<DestinationDropHandlerProtocol> _dropHandler;
}

@end

@implementation DropSampleView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dropHandler = [[DropHandler alloc] init];
    }
    return self;
}

@end
