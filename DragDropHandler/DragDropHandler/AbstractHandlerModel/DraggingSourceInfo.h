//
//  DraggingSourceInfo.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 28/01/2021.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 - (void)tableViewManager:(TableViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *_Nullable)rowIndexes items:(NSArray *_Nullable)items;

 /**
  * Tells the delegate that a dragging session has ended.
  */
// - (void)tableViewManager:(TableViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;
//
// /**
//  * Tells the delegate to allow the table to update dragging items as they are dragged over a view.
//  */
// - (void)tableViewManager:(TableViewManager *_Nullable)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>_Nullable)draggingInfo;
//
// /**
//  * Returns a Boolean value that indicates whether a drag operation is allowed.
//  */
// - (BOOL)tableViewManager:(TableViewManager *_Nullable)manager writeRowsWithIndexes:(NSIndexSet *_Nullable)rowIndexes items:(NSArray *_Nullable)items toPasteboard:(NSPasteboard *_Nullable)pasteboard;
//
// */

//*/
@interface DraggingSourceInfo : NSObject

@property (strong, nonatomic) NSDraggingSession *sessionInfo;

@property (nonatomic) NSPoint beginAtPoint;

@property (nonatomic) NSPoint endAtPoint;

@property (strong, nonatomic) NSIndexSet *_Nullable rowIndexes;

@property (nonatomic) NSDragOperation operation;

- (instancetype)initWithInfo:(id<NSDraggingInfo>)info;

@end

NS_ASSUME_NONNULL_END
