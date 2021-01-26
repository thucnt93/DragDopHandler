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
- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;


@end



/* later
@protocol ItemProtocol

@end
*/


