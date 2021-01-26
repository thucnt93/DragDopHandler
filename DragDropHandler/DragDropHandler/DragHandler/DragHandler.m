//
//  DragHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragHandler.h"

@implementation DragHandler

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
        
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    return CustomDragOperation_MOVE;
}

@end
