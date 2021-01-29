//
//  DropHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DropHandler.h"

@interface DropHandler() {
    CustomDragOperation _dragOperation;
}

// weak property to make sure for avoid memory leak
@property (weak, nonatomic) id<DropTrackingDelegate> trackingDelegate;

@end

@implementation DropHandler

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)targetDropTrackingDelegate {
    if (self = [super init])
    {
        _trackingDelegate = targetDropTrackingDelegate;
    }
    return self;
}

- (void)handleDraggingExited:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget {
    NSLog(@"handleDraggingExited on target %@", onTarget);
    [DragOperation handleCustomDragOperation:CustomDragOperation_NONE draggingSource:draggingInfo.info.draggingSource]; //enable disableDragTracking on DraggableNSView
}

- (NSDragOperation)handleDraggingUpdated:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget {
    NSLog(@"handleDraggingUpdated on target %@", onTarget);
    
    _dragOperation = CustomDragOperation_NONE;
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragUpdatedOnTarget:withInfo:)])
    {
        _dragOperation = [_trackingDelegate dragUpdatedOnTarget:onTarget withInfo:draggingInfo];
    }
    return [DragOperation handleCustomDragOperation:_dragOperation draggingSource:draggingInfo.info.draggingSource];
}

- (BOOL)handlePerformDraggingOperation:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget
{
    NSLog(@"handlePerformDraggingOperation on target %@", onTarget);
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(performDropOnTarget:draggingInfo:)])
    {
        BOOL result = [_trackingDelegate performDropOnTarget:onTarget draggingInfo:draggingInfo];
        return result;
    }
    return YES;
}

@end
