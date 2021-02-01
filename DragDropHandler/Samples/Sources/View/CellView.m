//
//  CellView.m
//  Samples
//
//  Created by Thuc Nguyen on 29/01/2021.
//

#import "CellView.h"

@implementation CellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor systemIndigoColor] CGColor];
}

@end
