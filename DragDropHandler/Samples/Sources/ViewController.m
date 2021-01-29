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
#import "CellView.h"

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
    if (@available(macOS 11.0, *)) {
        [self.theTableView setStyle:NSTableViewStyleFullWidth];
    } else {
        // Fallback on earlier versions
    }
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"CellView" bundle:nil];
    [_theTableView registerNib:nib forIdentifier:@"CellView"];
    self.theCustomView.wantsLayer = YES;
    self.theCustomView.layer.backgroundColor = [[NSColor systemGrayColor] CGColor];
}

- (void)setupDragDropTracking {
    self.filesButton.dragTrackingDelegate = self;
    self.theCustomView.dropTrackingDelegate = self;
}

- (void)setupTableViewManagerTracking {
    NSArray *initArray = @[@"Test 0", @"Test 1", @"Test 2", @"Test 3", @"Test 4"];
    NSArray *models = [[NSMutableArray alloc] initWithArray:initArray];
    
    _mockViewModel = [[MockViewModel alloc] initWithModel:models];
    [_mockViewModel setupProvider];
    [_mockViewModel buildDataSource];
    
    _tableViewManager = [[TableViewManager alloc] initWithTableView:self.theTableView source:self provider: _mockViewModel.provider];
    
    [_tableViewManager setDropTrackingDelegate:self];
    [_tableViewManager setDragTrackingDelegate:self];
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 50;
}

- (NSView *)tableViewManager:(TableViewManager *)manager makeViewForRow:(NSInteger)row byItem:(id)item {
    CellView *cell = [manager.tableView makeViewWithIdentifier:@"CellView" owner:self];
    cell.titleLabel.stringValue = _mockViewModel.models[row];
    return cell;
}

- (void) awakeFromNib {
    [self.theCustomView registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]];
}

#pragma mark - DragTrackingDelegate

- (CustomDragOperation)dragBeginWithSource:(id)source
                                   atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"Validate dragging info");
    
    if ([onTarget isKindOfClass: TableViewManager.self]) {
        NSLog(@"TableViewManager validate drop");
    }
    
    return CustomDragOperation_MOVE;
}


#pragma mark - NSView drop tracking delegate

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    
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


#pragma mark - TableView drag manager

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

#pragma mark - TableView drop manager

- (NSDragOperation)tableViewValidateDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    return NSDragOperationMove;
}

- (BOOL)tableViewAcceptDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    return YES;
}


@end
