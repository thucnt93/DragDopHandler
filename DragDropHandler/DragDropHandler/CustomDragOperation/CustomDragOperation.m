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

@end
