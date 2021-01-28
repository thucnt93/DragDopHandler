//
//  CustomDragOperation.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 25/01/2021.
//

#import "CustomDragOperation.h"
#import "DraggableNSView.h"
#import "DraggableNSButton.h"

@implementation DragOperation

+ (void)changeCursorByOperation:(CustomDragOperation)operation
{
    switch (operation) {
        case CustomDragOperation_NONE:
            [[NSCursor arrowCursor] set];
            break;
            
        case CustomDragOperation_STOP:
            [[NSCursor operationNotAllowedCursor] set];
            break;
            
        case CustomDragOperation_MOVE:
            [[NSCursor closedHandCursor] set];
            break;
            
        case CustomDragOperation_LINK:
            [[NSCursor dragLinkCursor] set];
            break;
            
        case CustomDragOperation_ALLOW:
            [[NSCursor dragCopyCursor] set];
            break;
            
        case CustomDragOperation_RIGHT:
            [[NSCursor resizeRightCursor] set];
            break;
            
        default:
            break;
    }
}

+ (NSDragOperation)handleCustomDragOperation:(CustomDragOperation)operation draggingSource:(id)draggingSource
{
    if ([draggingSource isKindOfClass:[DraggableNSView class]])
    {
        ((DraggableNSView *)draggingSource).disableDragTracking = (operation != CustomDragOperation_NONE);
    }
    
    if ([draggingSource isKindOfClass:[DraggableNSButton class]])
    {
        ((DraggableNSButton *)draggingSource).disableDragTracking = (operation != CustomDragOperation_NONE);
    }
    
    NSUInteger allSystemOperations = NSDragOperationCopy
                                    | NSDragOperationLink
                                    | NSDragOperationGeneric
                                    | NSDragOperationPrivate
                                    | NSDragOperationMove
                                    | NSDragOperationDelete
                                    | NSDragOperationNone;
    
    if (operation & allSystemOperations)
    {
        //system operations
        
        return (NSDragOperation) operation;
    }
        
    [DragOperation changeCursorByOperation:operation];
    
    return (operation == CustomDragOperation_NONE || operation == CustomDragOperation_STOP)?NSDragOperationNone:NSDragOperationGeneric;
}

@end
