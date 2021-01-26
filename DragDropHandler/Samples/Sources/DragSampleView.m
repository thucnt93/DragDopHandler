//
//  PresentView.m
//  Samples
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragSampleView.h"

@interface DragSampleView() {
    
    id<DraggingSourceHandlerProtocol> _dragHandler;
    
}

@end

@implementation DragSampleView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dragHandler = [[DragHandler alloc] initWithDragTrackingDelegate:self];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dragHandler = [[DragHandler alloc] initWithDragTrackingDelegate:self];
    }
    return self;
}

@end
