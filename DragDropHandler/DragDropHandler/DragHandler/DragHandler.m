//
//  DragHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragHandler.h"

@implementation DragHandler

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"dragBeginWithSource %@", source);
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"dragEndWithSource %@", source);
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    NSLog(@"dragMoveWithSource %@", source);
    return CustomDragOperation_MOVE;
}

@end
