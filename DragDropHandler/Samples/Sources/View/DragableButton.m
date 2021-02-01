//
//  DragableButton.m
//  Samples
//
//  Created by Phu Tran on 1/26/21.
//

#import "DragableButton.h"

@interface DragableButton()<DragTrackingDelegate>

@end

@implementation DragableButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    self.dragTrackingDelegate = self;
}

- (instancetype) initWithModel: (id) model {
    self.model = model;
    return self;
}

#pragma mark - NSView view drag delegate

- (CustomDragOperation)dragBeginWithSource:(id)source
                                   atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"Validate dragging info");
    return CustomDragOperation_MOVE;
}

- (CustomDragOperation)dragMoveWithSource:(id)source
                                  atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source
                  atPoint:(NSPoint)atPoint {
    
}



@end
