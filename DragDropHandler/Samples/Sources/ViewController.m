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
#import "TabMenuButtonModel.h"
#import "SystemMenuButtonModel.h"

typedef void(^DeleteRowCallBack)(NSInteger row);

@interface ViewController()<DragTrackingDelegate, DropTrackingDelegate, TableViewManagerProtocols> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
    TabMenuButtonModel* _tabMenuModel;
    SystemMenuButtonModel* _systemMenuModel;
    NSUInteger indexTableViewSource;
    DeleteRowCallBack deleteRowCallBack;
}


@property (weak) IBOutlet DragableButton* filesButton;
@property (weak) IBOutlet DragableButton* emailsButton;
@property (weak) IBOutlet DragableButton* notesButton;
@property (weak) IBOutlet DragableButton* contactsButton;

@property (weak) IBOutlet NSButton* searchButton;
@property (weak) IBOutlet NSButton* youButton;

@property (weak) IBOutlet NSTableView* theTableView;
@property (weak) IBOutlet CustomView* theCustomView;
@property (weak) IBOutlet NSTextField *lableDropNotify;

@property (strong, nonatomic) MockViewModel *mockViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setupView];
    [self setupDragDropTracking];
    [self setupTableViewManagerTracking];
    indexTableViewSource = -1;
}

- (void)setupView {
    
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"CellView" bundle:nil];
    [_theTableView registerNib:nib forIdentifier:@"CellView"];
    self.theCustomView.wantsLayer = YES;
    self.theCustomView.layer.backgroundColor = [[NSColor systemGrayColor] CGColor];
    
    _tabMenuModel = [[TabMenuButtonModel alloc] init];
    _systemMenuModel = [[SystemMenuButtonModel alloc] init];
    self.filesButton.model = _systemMenuModel;
    self.emailsButton.model = _tabMenuModel;
    self.notesButton.model = _tabMenuModel;
    self.contactsButton.model = _systemMenuModel;
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
    
    _theTableView.wantsLayer = YES;
    _theTableView.layer.backgroundColor = [[NSColor brownColor] CGColor];
    self.theTableView.draggingDestinationFeedbackStyle = NSTableViewDraggingDestinationFeedbackStyleGap;
    
    
    __weak typeof(self) weakSelf = self;
    deleteRowCallBack = ^(NSInteger row) {
        [weakSelf.mockViewModel.models removeObjectAtIndex:row];
        [weakSelf.mockViewModel buildDataSource];
        [weakSelf.theTableView reloadData];
    };
    
}

- (CGFloat)tableViewManager:(TableViewManager *)manager heightOfRow:(NSInteger)row byItem:(id)item {
    return 40;
}

- (NSView *)tableViewManager:(TableViewManager *)manager makeViewForRow:(NSInteger)row byItem:(id)item {
    CellView *cell = [manager.tableView makeViewWithIdentifier:@"CellView" owner:self];
    cell.titleLabel.stringValue = _mockViewModel.models[row];
    return cell;
}

- (void) awakeFromNib {
    [self.theCustomView registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]];
}

#pragma mark - NSView view drag delegate

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

- (CustomDragOperation)dragMoveWithSource:(id)source
                                  atPoint:(NSPoint)atPoint {
    return CustomDragOperation_MOVE;
}

- (void)dragEndWithSource:(id)source
                  atPoint:(NSPoint)atPoint {
    
}


#pragma mark - NSView drop tracking delegate

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    
    if ([onTarget isKindOfClass: DraggableNSButton.self]) {
        NSLog(@"DraggableNSButton drop");
    }
    
    if ([onTarget isKindOfClass: DroppableNSView.self]) {
        NSLog(@"DroppableNSView drop");
        NSString *stringFromPasteboard = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
        self.lableDropNotify.stringValue = stringFromPasteboard;
        NSInteger index = [self.mockViewModel.models indexOfObject:stringFromPasteboard];
        if (index != NSNotFound) {
            deleteRowCallBack(index);
        }
    }
    
    return YES;
}

#pragma mark - Table view drag delegate

- (void)dragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes {
    indexTableViewSource = rowIndexes.firstIndex;
}

- (void)dragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    NSLog(@"dragEndTableViewWithSource");
    
    
}

- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)draggingInfo {
//    NSLog(@"updateDraggingItemsForDrag");
}

- (id<NSPasteboardWriting>)pasteboardWriterWithSource:(id)source forRow:(NSInteger)row {
    if (_mockViewModel.models[row] || ![_mockViewModel.models[row] isEqualToString:@""]) {
        return _mockViewModel.models[row];
    }
    return nil;
}

#pragma mark - TableView drop manager

- (CustomDragOperation)tableViewValidateDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)inFilesfo proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    
    if (dropOperation == NSTableViewDropOn) {
        
        return CustomDragOperation_STOP;
    } else {
        return CustomDragOperation_ALLOW;
    }
}

- (BOOL)tableViewAcceptDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    
    if (dropOperation == NSTableViewDropOn) {
        // Donothing
    }
    
    if (dropOperation == NSTableViewDropAbove) {
        if (indexTableViewSource != -1 && indexTableViewSource != NSNotFound) {
            if (indexTableViewSource < row) {
                [_mockViewModel.models insertObject:[info.draggingPasteboard stringForType:NSPasteboardTypeString] atIndex:row];
                [_mockViewModel.models removeObjectAtIndex:indexTableViewSource];
            }
            else {
                [_mockViewModel.models removeObjectAtIndex:indexTableViewSource];
                [_mockViewModel.models insertObject:[info.draggingPasteboard stringForType:NSPasteboardTypeString] atIndex:row];
            }
        }
        else {
            [_mockViewModel.models insertObject:[info.draggingPasteboard stringForType:NSPasteboardTypeString] atIndex:row];
        }
    }
    
    indexTableViewSource = -1;
    [_mockViewModel buildDataSource];
    [_theTableView reloadData];
    return YES;
}

@end
