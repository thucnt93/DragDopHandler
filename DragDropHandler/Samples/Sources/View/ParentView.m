//
//  ParentView.m
//  Samples
//
//  Created by Thuc Nguyen on 02/02/2021.
//

#import "ParentView.h"

@implementation ParentView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dropTrackingDelegate = self;
    
    
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    
    
    return CustomDragOperation_MOVE;
}

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    
    
    return NO;
}

@end
