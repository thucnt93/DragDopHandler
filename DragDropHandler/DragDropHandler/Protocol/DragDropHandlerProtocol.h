//
//  DragDropHandler.h
//  DragDropHandler
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "CustomDragOperation.h"
#import "DragDropHandlerInfo.h"


//! Project version number for DragDropHandler.
FOUNDATION_EXPORT double DragDropHandlerVersionNumber;

//! Project version string for DragDropHandler.
FOUNDATION_EXPORT const unsigned char DragDropHandlerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DragDropHandler/PublicHeader.h>

@protocol DraggingSourceHandlerProtocol

- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

@end


@protocol DropDestinationHandlerProtocol

// NSViewDropFunction
#pragma mark - NSView drop handler action
- (NSDragOperation)handleDraggingUpdated:(DragDropHandlerInfo *)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(DragDropHandlerInfo *)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(DragDropHandlerInfo *)draggingInfo onTarget:(id)onTarget;


@end



/* later
@protocol ItemProtocol

@end
*/


