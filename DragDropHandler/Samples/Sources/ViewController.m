//
//  ViewController.m
//  Samples
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import "ViewController.h"
#import "DraggableNSButton.h"
#import "TableViewManager.h"
#import "DroppableNSView.h"
#import "DraggableNSView.h"

@interface ViewController()<DragTrackingDelegate, DropTrackingDelegate> {
    
}
@property (weak) IBOutlet DraggableNSButton *fileDragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet DroppableNSView *dropView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setupDragDropTracking];
    [self setupView];
}

- (void)setupView {
    self.dropView.wantsLayer = YES;
    self.dropView.layer.backgroundColor = [[NSColor systemYellowColor] CGColor];
}

- (void)setupDragDropTracking {
    self.fileDragButton.dragTrackingDelegate = self;
    self.dropView.dropTrackingDelegate = self;
    
}

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    return CustomDragOperation_LINK;
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    return CustomDragOperation_LINK;;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(DragDropHandlerInfo *)draggingInfo {
    return CustomDragOperation_MOVE;
}

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(DragDropHandlerInfo *)draggingInfo {
    
    if ([onTarget isKindOfClass: TableViewManager.self]) {
        NSLog(@"TableViewManager drop");
    }
    
    if ([onTarget isKindOfClass: DraggableNSButton.self]) {
        NSLog(@"DraggableNSButton drop");
    }
    
    if ([onTarget isKindOfClass: DroppableNSView.self]) {
        NSLog(@"DroppableNSView drop");
    }
    
    return YES;
}


@end
