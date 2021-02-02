//
//  DragHandler.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragHandler.h"

@interface DragHandler()

// weak property to make sure for avoid memory leak
@property (weak, nonatomic) id<DragTrackingDelegate> dragTrackingDelegate;

@end


@implementation DragHandler

- (instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)targetDragTrackingDelegate {
    if (self = [super init])
    {
        _dragTrackingDelegate = targetDragTrackingDelegate;
    }
    return self;
}

- (void)handleDragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"handleDragBeginWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(dragBeginWithSource:atPoint:)])
    {
        CustomDragOperation op = [_dragTrackingDelegate dragBeginWithSource:source atPoint:atPoint];
        [DragOperation changeCursorByOperation:op];
    }
    
}

- (void)handleDragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"handleDragMoveWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(dragMoveWithSource:atPoint:)])
    {
        CustomDragOperation op = [_dragTrackingDelegate dragMoveWithSource:source atPoint:atPoint];
        [DragOperation changeCursorByOperation:op];
    }
}

- (void)handleDragEndWithSource:(id)source atPoint:(NSPoint)atPoint {
    
    NSLog(@"handleDragEndWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(dragEndWithSource:atPoint:)])
    {
        [_dragTrackingDelegate dragEndWithSource:source atPoint:atPoint];
    }
}

- (void)handleDragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes {
    NSLog(@"handleDragBeginTableViewWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(dragBeginTableViewWithSource:willBeginAtPoint:forRowIndexes:)])
    {
        CustomDragOperation op = [_dragTrackingDelegate dragBeginTableViewWithSource:source willBeginAtPoint:screenPoint forRowIndexes:rowIndexes];
        [DragOperation changeCursorByOperation:op];
    }
}

- (void)handleDragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    
    NSLog(@"handleDragEndTableViewWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(dragEndTableViewWithSource:endedAtPoint:operation:)])
    {
        CustomDragOperation op = [_dragTrackingDelegate dragEndTableViewWithSource:source endedAtPoint:screenPoint operation:operation];
        [DragOperation changeCursorByOperation:op];
    }
}

- (id<NSPasteboardWriting>)handlePasteboardWriterWithSource:(id)source forRow:(NSInteger)row {
    
    NSLog(@"handlePasteboardWriterWithSource %@", source);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(pasteboardWriterWithSource:forRow:)])
    {
        return [_dragTrackingDelegate pasteboardWriterWithSource:source forRow:row];
    }
    return nil;
}

- (void)handleUpdateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
    
    NSLog(@"handleUpdateDraggingItemsForDrag %@", draggingInfo);
    
    if (_dragTrackingDelegate != nil && [_dragTrackingDelegate respondsToSelector:@selector(updateDraggingItemsForDrag:)])
    {
        return [_dragTrackingDelegate updateDraggingItemsForDrag:draggingInfo];
    }
}




@end
