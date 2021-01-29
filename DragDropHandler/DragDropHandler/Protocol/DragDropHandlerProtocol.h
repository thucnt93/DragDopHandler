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
#import "DraggingDestinationInfo.h"


//! Project version number for DragDropHandler.
FOUNDATION_EXPORT double DragDropHandlerVersionNumber;

//! Project version string for DragDropHandler.
FOUNDATION_EXPORT const unsigned char DragDropHandlerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DragDropHandler/PublicHeader.h>

@protocol DraggingSourceHandlerProtocol

/*
 NSView draging handler
 */
- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

/*
 table view dragging handler
 */
- (void)handleDragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes;
- (void)handleDragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (void)handleUpdateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (id<NSPasteboardWriting>)handlePasteboardWriterWithSource:(id)source forRow:(NSInteger)row;
@end


@protocol DropDestinationHandlerProtocol

// NSViewDropFunction
#pragma mark - NSView drop handler action
- (NSDragOperation)handleDraggingUpdated:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(DraggingDestinationInfo *)draggingInfo onTarget:(id)onTarget;

@end



/* later
@protocol ItemProtocol

@end
*/


