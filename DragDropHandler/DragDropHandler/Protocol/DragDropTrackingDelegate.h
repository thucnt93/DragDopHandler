//
//  DragDropTrackingDelegate.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <AppKit/AppKit.h>
#import "CustomDragOperation.h"
#import "DraggingDestinationInfo.h"

#ifndef DragDropTrackingDelegate_h
#define DragDropTrackingDelegate_h

#endif /* DragDropTrackingDelegate_h */

@protocol DropTrackingDelegate <NSObject>
@optional

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(DraggingDestinationInfo *)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(DraggingDestinationInfo *)draggingInfo;

@end

@protocol DragTrackingDelegate <NSObject>
@optional

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

/*
 table view dragging delegate
 */
- (void)dragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes;
- (void)dragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (id<NSPasteboardWriting>)pasteboardWriterWithSource:(id)source forRow:(NSInteger)row;

@end
