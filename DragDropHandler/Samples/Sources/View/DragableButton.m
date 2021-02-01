//
//  DragableButton.m
//  Samples
//
//  Created by Phu Tran on 1/26/21.
//

#import "DragableButton.h"

@implementation DragableButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype) initWithModel: (id) model {
    self.model = model;
    return self;
}

@end
