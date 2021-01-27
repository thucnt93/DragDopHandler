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

@interface ViewController()<DragTrackingDelegate, DropTrackingDelegate, TableViewManagerProtocols> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
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
    [self setupTableViewManagerTracking];
}

- (void)setupView {
    self.dropView.wantsLayer = YES;
    self.dropView.layer.backgroundColor = [[NSColor systemYellowColor] CGColor];
}

- (void)setupDragDropTracking {
    self.fileDragButton.dragTrackingDelegate = self;
    self.dropView.dropTrackingDelegate = self;
}

- (void)setupTableViewManagerTracking {
    NSArray *initArray = @[@"TEST", @"TEST1",@"TEST2",@"TEST3",@"TEST4",@"TEST5",@"TEST6", @"TEST7"];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.tableView source:self provider: _mockViewModel.provider];
    [_tableViewManager setDropTrackingDelegate:self];
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 40;
}

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, 40)];
    label.stringValue = _mockViewModel.models[row];
    NSTableRowView *rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, 40)];
    [rowView addSubview:label];
    return rowView;
}

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint {
    return CustomDragOperation_LINK;
}

- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint {
    return CustomDragOperation_LINK;;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(DragDropHandlerInfo *)draggingInfo {
    
    NSLog(@"Validate dragging info");
    
    if ([onTarget isKindOfClass: TableViewManager.self]) {
        NSLog(@"TableViewManager validate drop");
    }
    
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
