//
//  DropHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DropHandler.h"

@interface DropHandler() {
    id<DragTrackingDelegate> _trackingDelegate;
}

@end

@implementation DropHandler


- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate {
    if (self = [super init])
    {
        _trackingDelegate = delegate;
    }
    
    return self;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    
    
    return CustomDragOperation_MOVE;
}

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    
    
    return YES;
}

@end
