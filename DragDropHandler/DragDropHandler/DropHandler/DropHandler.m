//
//  DropHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DropHandler.h"

@interface DropHandler() {
    id<DropTrackingDelegate> _trackingDelegate;
}

@end

@implementation DropHandler

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)targetDropTrackingDelegate {
    if (self = [super init])
    {
        _trackingDelegate = targetDropTrackingDelegate;
    }
    return self;
}

- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget {
    
    NSLog(@"handleDraggingExited on target %@", onTarget);
    
}

- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget {
    
    NSLog(@"handleDraggingUpdated on target %@", onTarget);
    
    return NSDragOperationMove;
    
}

- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget {
    
    NSLog(@"handlePerformDraggingOperation on target %@", onTarget);
    
    return YES;
}

@end
