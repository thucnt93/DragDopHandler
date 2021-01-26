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

@protocol DropTrackingDelegate <NSObject>
@optional

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo;

@end

@protocol DragTrackingDelegate <NSObject>
@optional

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

@end
