//
//  DropHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DropHandler.h"
#import "CustomDragOperation.h"

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

- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget {
    NSLog(@"handleDraggingExited on target %@", onTarget);
    [DragOperation handleCustomDragOperation:CustomDragOperation_NONE draggingSource:draggingInfo.draggingSource]; //enable disableDragTracking on DraggableNSView
}

- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget {
    NSLog(@"handleDraggingUpdated on target %@", onTarget);
    
    _dragOperation = CustomDragOperation_NONE;
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(dragUpdatedOnTarget:withInfo:)])
    {
        _dragOperation = [_trackingDelegate dragUpdatedOnTarget:onTarget withInfo:draggingInfo];
    }
    return [DragOperation handleCustomDragOperation:_dragOperation draggingSource:draggingInfo.draggingSource];
}

- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget
{
    NSLog(@"handlePerformDraggingOperation on target %@", onTarget);
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(performDropOnTarget:draggingInfo:)])
    {
        BOOL result = [_trackingDelegate performDropOnTarget:onTarget draggingInfo:draggingInfo];
        return result;
    }
    return YES;
}

- (NSDragOperation)handleTableViewValidateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation onTarget:(id)onTarget {
    
    NSLog(@"handleTableViewValidateDrop on target %@", onTarget);
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(tableViewValidateDropOnTarget:draggingInfo:proposedRow:proposedDropOperation:)])
    {
        CustomDragOperation tableOp = [_trackingDelegate tableViewValidateDropOnTarget:onTarget draggingInfo:info proposedRow:row proposedDropOperation:dropOperation];
        NSDragOperation operation = [DragOperation handleCustomDragOperation:tableOp draggingSource:info.draggingSource];
        return operation;
    }
    return NSDragOperationNone;
}

- (BOOL)handleTableViewAcceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation onTarget:(id)onTarget {
    
    NSLog(@"handleTableViewAcceptDrop on target %@", onTarget);
    
    if (_trackingDelegate != nil && [_trackingDelegate respondsToSelector:@selector(tableViewValidateDropOnTarget:draggingInfo:proposedRow:proposedDropOperation:)])
    {
        BOOL shouldAccept = [_trackingDelegate tableViewAcceptDropOnTarget:onTarget draggingInfo:info row:row dropOperation:dropOperation];
        return shouldAccept;
    }
    return NO;
}

@end
