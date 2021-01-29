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

#pragma mark - NSView draging handler
- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint;


#pragma mark - Table view dragging handler
- (void)handleDragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes;
- (void)handleDragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (void)handleUpdateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (id<NSPasteboardWriting>)handlePasteboardWriterWithSource:(id)source forRow:(NSInteger)row;
@end


@protocol DropDestinationHandlerProtocol

// NSViewDropFunction
#pragma mark - NSView drop handler action
- (NSDragOperation)handleDraggingUpdated:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (void)handleDraggingExited:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;
- (BOOL)handlePerformDraggingOperation:(id<NSDraggingInfo>)draggingInfo onTarget:(id)onTarget;


#pragma mark - Table view drop handler action
- (NSDragOperation)handleTableViewValidateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation onTarget:(id)onTarget;
- (BOOL)handleTableViewAcceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation onTarget:(id)onTarget;

@end



/* later
@protocol ItemProtocol

@end
*/


