//
//  ViewController.m
//  Samples
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import "ViewController.h"
#import "DraggableNSButton.h"
#import "DroppableNSView.h"
#import "DraggableNSView.h"
#import "TableViewManager.h"
#import "DataProvider.h"
#import "MockViewModel.h"
#import "TableView.h"
#import "CustomView.h"
#import "DragableButton.h"

@interface ViewController()<DragTrackingDelegate, DropTrackingDelegate, TableViewManagerProtocols> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
}

@property (weak) IBOutlet DragableButton* filesButton;
@property (weak) IBOutlet DragableButton* emailsButton;
@property (weak) IBOutlet DragableButton* notesButton;
@property (weak) IBOutlet DragableButton* contactsButton;

@property (weak) IBOutlet NSButton* searchButton;
@property (weak) IBOutlet NSButton* youButton;

@property (weak) IBOutlet NSTableView* theTableView;
@property (weak) IBOutlet CustomView* theCustomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setupView];
    [self setupDragDropTracking];
    [self setupTableViewManagerTracking];
}

- (void)setupView {
    self.theCustomView.wantsLayer = YES;
    self.theCustomView.layer.backgroundColor = [[NSColor systemGrayColor] CGColor];
}

- (void)setupDragDropTracking {
    self.filesButton.dragTrackingDelegate = self;
    self.theCustomView.dropTrackingDelegate = self;
}

- (void)setupTableViewManagerTracking {
    NSArray *initArray = @[@"Test 0", @"Test 1", @"Test 2"];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.theTableView source:self provider: _mockViewModel.provider];
    
    [_tableViewManager setDropTrackingDelegate:self];
    [_tableViewManager setDragTrackingDelegate:self];
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 60;
}

- (NSTableRowView *)tableViewManager:(TableViewManager *)manager rowViewForRow:(NSInteger)row byItem:(id)item {
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 40)];
    label.stringValue = _mockViewModel.models[row];
    NSTableRowView *rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 100, 40)];
    [rowView addSubview:label];
    return rowView;
}

- (NSUserInterfaceItemIdentifier)tableViewManager:(TableViewManager *)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id)item {
    return @"CustomView";
}

- (void) awakeFromNib {
    [self.theCustomView registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]];
}

#pragma mark - DragTrackingDelegate

- (CustomDragOperation)dragBeginWithSource:(id)source
                                   atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(DraggingDestinationInfo *)draggingInfo {
    
    NSLog(@"Validate dragging info");
    
    if ([onTarget isKindOfClass: TableViewManager.self]) {
        NSLog(@"TableViewManager validate drop");
    }
    
    return CustomDragOperation_MOVE;
}

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(DraggingDestinationInfo *)draggingInfo {
    
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
- (CustomDragOperation)dragMoveWithSource:(id)source
                                  atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source
                  atPoint:(NSPoint)atPoint {
    
}


#pragma mark: - TableView drag manager
- (void)dragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes {
    NSLog(@"dragBeginTableViewWithSource");
}

- (void)dragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    NSLog(@"dragEndTableViewWithSource");
}

- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"updateDraggingItemsForDrag");
}

- (id<NSPasteboardWriting>)pasteboardWriterWithSource:(id)source forRow:(NSInteger)row {
    if (_mockViewModel.models[row] || ![_mockViewModel.models[row] isEqualToString:@""]) {
        return _mockViewModel.models[row];
    }
    return nil;
}

#pragma mark - DropTrackingDelegate

//- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget
//                                  withInfo:(id<NSDraggingInfo>)draggingInfo {
//    return CustomDragOperation_ALLOW;
//}
//
//- (BOOL)performDropOnTarget:(id)onTarget
//               draggingInfo:(id<NSDraggingInfo>)draggingInfo {
//    return YES;
//}



#pragma mark - TableViewManagerProtocols

- (CustomDragOperation)validateDropWithTableViewManager:(TableViewManager *)manager
                                           validateDrop:(id<NSDraggingInfo>)draggingInfo
                                           proposedItem:(id)item
                                            proposedRow:(NSInteger)row
                                  proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    return CustomDragOperation_ALLOW;
}

- (BOOL)acceptDropWithTableViewManager:(TableViewManager *)manager
                            acceptDrop:(id<NSDraggingInfo>)draggingInfo
                                  item:(id)item
                                   row:(NSInteger)row
                         dropOperation:(NSTableViewDropOperation)dropOperation{
    
    return YES;
}

@end
