//
//  CustomDragOperation.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 25/01/2021.
//

#import "CustomDragOperation.h"
#import "DraggableNSView.h"
#import "DraggableNSButton.h"

@interface DragOperation()



@end

@implementation DragOperation

NSString * const STOP_CURSOR = @"cursor-stop";
NSString * const LINK_CUSOR = @"cursor-linking";
NSString * const MOVE_CURSOR = @"cursor-move";
NSString * const ALLOW_CURSOR = @"cursor-green";
NSString * const RIGHT_CURSOR = @"cursor-right";


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
        cursorIcon = [NSImage imageNamed:STOP_CURSOR];
    }
    else if (operation == CustomDragOperation_LINK)
    {
        cursorIcon = [NSImage imageNamed:LINK_CUSOR];
    }
    else if (operation == CustomDragOperation_MOVE)
    {
        NSLog(@"====THUC====MOVE cursor");
        cursorIcon = [NSImage imageNamed:MOVE_CURSOR];
    }
    else if (operation == CustomDragOperation_ALLOW)
    {
        cursorIcon = [NSImage imageNamed:ALLOW_CURSOR];
    }
    else if (operation == CustomDragOperation_RIGHT)
    {
        cursorIcon = [NSImage imageNamed:RIGHT_CURSOR];
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
