//
//  CustomDragOperation.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 25/01/2021.
//

#import "CustomDragOperation.h"

@implementation DragOperation

+ (void)changeCursorByOperation:(CustomDragOperation)operation
{
    if (operation == CustomDragOperation_NONE)
    {
        [[NSCursor arrowCursor] set];
        
        return;
    }

    NSImage *cursorIcon = nil;
    
    if (operation == CustomDragOperation_STOP)
    {
        NSLog(@"====THUC====Stop cursor");
        cursorIcon = [NSImage imageNamed:@"cursor-stop"];
    }
    else if (operation == CustomDragOperation_LINK)
    {
        cursorIcon = [NSImage imageNamed:@"cursor-linking"];
    }
    else if (operation == CustomDragOperation_MOVE)
    {
        NSLog(@"====THUC====MOVE cursor");
        cursorIcon = [NSImage imageNamed:@"cursor-move"];
    }
    else if (operation == CustomDragOperation_ALLOW)
    {
        cursorIcon = [NSImage imageNamed:@"cursor-green"];
    }
    else if (operation == CustomDragOperation_RIGHT)
    {
        cursorIcon = [NSImage imageNamed:@"cursor-right"];
    }

    if (cursorIcon != nil)
    {
        [cursorIcon setSize:NSMakeSize(35, 35)];
        
        NSCursor *mCustomCursor = [[NSCursor alloc] initWithImage:cursorIcon hotSpot:NSZeroPoint];
        
        [mCustomCursor set];
    }
}

+ (NSDragOperation)handleCustomDragOperation:(CustomDragOperation)operation draggingSource:(id)draggingSource
{
//    if ([draggingSource isKindOfClass:[DraggableNSView class]])
//    {
//        ((DraggableNSView *)draggingSource).disableDragTracking = (operation != CustomDragOperation_NONE);
//    }
    
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
