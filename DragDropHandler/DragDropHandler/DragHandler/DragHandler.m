//
//  DragHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragHandler.h"

@interface DragHandler() {
    id<DragTrackingDelegate> _dragTrackingDelegate;
}

@end


@implementation DragHandler

- (instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)targetDragTrackingDelegate {
    if (self = [super init])
    {
        _dragTrackingDelegate = targetDragTrackingDelegate;
    }
    return self;
}

- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"handleDragBeginWithSource %@", source);
    
}

- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"handleDragEndWithSource %@", source);
    
}

- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
   
    NSLog(@"handleDragMoveWithSource %@", source);
    
}

@end
