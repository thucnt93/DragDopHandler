//
//  DragDropTrackingDelegate.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <AppKit/AppKit.h>
#import "CustomDragOperation.h"

#ifndef DragDropTrackingDelegate_h
#define DragDropTrackingDelegate_h

#endif /* DragDropTrackingDelegate_h */

//=================DROP DELEGATE=================
@protocol DropTrackingDelegate <NSObject>
@optional

#pragma mark - NSView view drop delegate

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo;


#pragma mark - Table view drop delegate
- (NSDragOperation)tableViewValidateDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
- (BOOL)tableViewAcceptDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;

@end

//=================DRAG DELEGATE=================
@protocol DragTrackingDelegate <NSObject>
@optional

#pragma mark - NSView view drag delegate

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

#pragma mark - Table view dragging delegate

- (void)dragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes;
- (void)dragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo;
- (id<NSPasteboardWriting>)pasteboardWriterWithSource:(id)source forRow:(NSInteger)row;

@end
