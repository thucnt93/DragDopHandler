//
//  ViewController.m
//  Samples
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import "ViewController.h"
#import "DroppableNSView.h"
#import "DraggableNSView.h"
#import "TableViewManager.h"
#import "DataProvider.h"
#import "MockViewModel.h"
#import "DropableCustomView.h"
#import "DragableButton.h"
#import "CellView.h"
#import "TabMenuButtonModel.h"
#import "SystemMenuButtonModel.h"
#import "NSView+init.h"

//typedef void(^DeleteRowCallBack)(NSInteger row);

@interface ViewController()<DragTrackingDelegate, DropTrackingDelegate, TableViewManagerProtocols> {
    TableViewManager *_tableViewManager;
    MockViewModel *_mockViewModel;
    TabMenuButtonModel* _tabMenuModel;
    SystemMenuButtonModel* _systemMenuModel;
    NSUInteger indexTableViewSource;
}


@property (weak) IBOutlet DragableButton* filesButton;
@property (weak) IBOutlet DragableButton* emailsButton;
@property (weak) IBOutlet DragableButton* notesButton;
@property (weak) IBOutlet DragableButton* contactsButton;

@property (weak) IBOutlet NSButton* searchButton;
@property (weak) IBOutlet NSButton* youButton;

@property (weak) IBOutlet NSTableView* theTableView;
@property (weak) IBOutlet NSView* theDropableCustomView;
@property (strong, nonatomic) MockViewModel *mockViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
    [self setupView];
    [self setupTableViewManagerTracking];
    indexTableViewSource = -1;
}

- (void)viewWillAppear {
    [super viewWillAppear];
    DropableCustomView *dropView = [[DropableCustomView alloc] init];
    __weak typeof(self) weakSelf = self;
    dropView.deleteRowCallBack = ^(NSString *string) {
        [weakSelf.mockViewModel.models removeObject:string];
        [weakSelf.mockViewModel buildDataSource];
        [weakSelf.theTableView reloadData];
    };
    [NSView addAutoResizingView:dropView toView:self.theDropableCustomView];
}

- (void)setupView {
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"CellView" bundle:nil];
    [_theTableView registerNib:nib forIdentifier:@"CellView"];
    _tabMenuModel = [[TabMenuButtonModel alloc] init];
    _systemMenuModel = [[SystemMenuButtonModel alloc] init];
    self.filesButton.model = _systemMenuModel;
    self.emailsButton.model = _tabMenuModel;
    self.notesButton.model = _tabMenuModel;
    self.contactsButton.model = _systemMenuModel;
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
    [self.theDropableCustomView registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]];
}

#pragma mark - Table view drag delegate

- (CustomDragOperation)dragBeginTableViewWithSource:(id)source willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes {
    indexTableViewSource = rowIndexes.firstIndex;
    
    return CustomDragOperation_MOVE;
}

- (CustomDragOperation)dragEndTableViewWithSource:(id)source endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    NSLog(@"dragEndTableViewWithSource");
    return CustomDragOperation_MOVE;
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
- (CustomDragOperation)tableViewValidateDropOnTarget:(id)onTarget
                                        draggingInfo:(id<NSDraggingInfo>)info
                                         proposedRow:(NSInteger)row
                               proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    if ([info.draggingSource isKindOfClass:[DragableButton class]]) {
        if ([((DragableButton*)info.draggingSource).model isKindOfClass:[SystemMenuButtonModel class]]) {
            return CustomDragOperation_STOP;
        }
    }
    if (dropOperation == NSTableViewDropOn) {
        return CustomDragOperation_LINK;
    }
    else {
        return CustomDragOperation_ALLOW;
    }
    return CustomDragOperation_STOP;
}

- (BOOL)tableViewAcceptDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    
    if ([info.draggingSource isKindOfClass:[DragableButton class]]) {
        if ([((DragableButton*)info.draggingSource).model isKindOfClass:[SystemMenuButtonModel class]]) {
            return NO;
        }
    }
    
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
