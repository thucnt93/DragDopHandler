//
//  TableViewManager.h
//  DatasourceDemo
//
//  Created by Lam Nguyen on 1/4/19.
//  Copyright © 2019 Floware Inc. All rights reserved.
//
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@class TableViewManager;
@class DataProvider;
@protocol ListSupplierProtocol;
@protocol DropTrackingDelegate;
@protocol DragTrackingDelegate;

#import "DragHandler.h"
#import "DropHandler.h"

/*
 tableViewManager -> include tableView delegate and datasource
 
 
 Nsview -> using drop handler -> call tracking delegate -> implement delegate in presentating view
 NstableView -> using drop/drop handler in view that have manager > Manager call tracking delegate -> implement in view that using manager(presenting View)
 
 ==> conclude: drag drop handler is many same function
 ==> what will in drag drop handler
 */

@protocol TableViewManagerProtocols <NSObject>

@optional
#pragma mark - UI

/**
 * Asks the delegate for the item identifier of the specified row.
 */
- (NSUserInterfaceItemIdentifier _Nullable )tableViewManager:(TableViewManager *_Nullable)manager makeViewWithIdentifierForRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Tells the delegate that a specified cell of row will load its data.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager itemView:(NSTableCellView *_Nullable)itemView willLoadData:(id<ListSupplierProtocol> _Nonnull)data forRow:(NSInteger)row;

/**
 * Asks the delegate for a view to display the specified row.
 */
- (NSTableRowView *_Nullable)tableViewManager:(TableViewManager *_Nullable)manager rowViewForRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Tells the delegate that a row view was removed from the table at the specified row.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didRemoveView:(NSTableCellView *_Nullable)view forRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Asks the delegate for the estimated height of item at the specified row.
 */
- (CGFloat)tableViewManager:(TableViewManager *_Nullable)manager heightOfRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Asks the delegate for the height of view with item at the specified row.
 */
- (CGFloat)tableViewManager:(TableViewManager *_Nullable)manager heightOfView:(NSTableCellView *_Nullable)view forRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Asks the delegate whether the specified item at row is in group.
 */
- (BOOL)tableViewManager:(TableViewManager *_Nullable)manager isGroupRow:(NSInteger)row byItem:(id _Nullable )item;

#pragma mark - Selection

/**
 * Asks the delegate if the user is allowed to change the selection.
 */
- (BOOL)tableViewManager:(TableViewManager *_Nullable)manager selectionShouldChangeInTableView:(NSTableView *_Nullable)tableView;

/**
 * Tells the delegate that the mouse button was clicked in the specified table column’s header.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager mouseDownInHeaderOfTableColumn:(NSTableColumn *_Nullable)tableColumn;

/**
 * Asks the delegate whether the specified table column can be selected.
 */
- (BOOL)tableViewManager:(TableViewManager *_Nullable)manager shouldSelectTableColumn:(nullable NSTableColumn *)tableColumn;

/**
 * Tells the delegate that the mouse button was clicked in the specified table column, but the column was not dragged.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didClickTableColumn:(NSTableColumn *_Nullable)tableColumn;

/**
 * Asks the delegate if the table view should allow selection of the specified row.
 */
- (BOOL)tableViewManager:(TableViewManager *_Nullable)manager shouldSelectRow:(NSInteger)row byItem:(id _Nullable )item;

/**
 * Asks the delegate to accept or reject the proposed selection.
 */
//- (void)tableViewManager:(TableViewManager *)manager selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes;

/**
 * Tells the delegate that an item is selected at the specified row.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didSelectItem:(id _Nullable )item forRow:(NSInteger)row;

/**
 * Tells the delegate that an unselectable item is selected at the specified row.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didSelectUnselectableItem:(id _Nullable )item forRow:(NSInteger)row;

/**
 * Tells the delegate that an item is selected at the specified row by double click action.
 * @note The [-tableViewManager:didSelectItem:forRow:] protocol will be called before this delegate implemented.
 * To avoid the call of [-tableViewManager:didSelectItem:forRow:], we should perform that protocol with delay.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didDoubleSelectItem:(id _Nullable )item forRow:(NSInteger)row;

/**
 * Tells the delegate that an unselectable item is selected at the specified row by double click action.
 * @note The [-tableViewManager:didSelectUnselectableItem:forRow:] protocol will be called before this delegate implemented.
 * To avoid the call of [-tableViewManager:didSelectUnselectableItem:forRow:], we should perform that protocol with delay.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didDoubleSelectUnselectableItem:(id _Nullable )item forRow:(NSInteger)row;

#pragma mark - Drag/Drop

/**
 * Tells the delegate that the specified table column was dragged.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager didDragTableColumn:(NSTableColumn *_Nullable)tableColumn;

/**
 * Called to allow the table to support multiple item dragging.
 If this method is implemented, then tableView:writeRowsWithIndexes:toPasteboard: will not be called.
 */
//- (nullable id<NSPasteboardWriting>)tableViewManager:(TableViewManager *)manager pasteboardWriterForRow:(NSInteger)row byItem:(id)item;

/**
 * Tells the delegate that a dragging session will begin.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *_Nullable)rowIndexes items:(NSArray *_Nullable)items;

/**
 * Tells the delegate that a dragging session has ended.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation;

/**
 * Tells the delegate to allow the table to update dragging items as they are dragged over a view.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>_Nullable)draggingInfo;

/*
 * Dragging Source Support - Required for multi-image dragging. Implement this method to allow the table to be an NSDraggingSource that supports multiple item dragging. Return a custom object that implements NSPasteboardWriting (or simply use NSPasteboardItem). If this method is implemented, then tableView:writeRowsWithIndexes:toPasteboard: will not be called.
 */
- (id<NSPasteboardWriting>_Nullable)tableViewManager:(TableViewManager *_Nullable)manager pasteboardWriterForRow:(NSInteger)row;
/**
 * Ask the delegate for a valid drop target.
 */
- (NSDragOperation)tableViewManager:(TableViewManager *_Nullable)manager validateDrop:(id<NSDraggingInfo>_Nullable)draggingInfo proposedItem:(nullable id)item proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;

/**
 * This method is called when the mouse is released over an NSTableView that previously decided to allow a drop via the validateDrop method.
 */
- (BOOL)tableViewManager:(TableViewManager *_Nullable)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;

#pragma mark - Notifications

/**
 * Tells the delegate that the table view’s selection has changed.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager selectionDidChange:(NSNotification *_Nullable)notification;

/**
 * Tells the delegate that a table column was moved by user action.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager columnDidMove:(NSNotification *_Nullable)notification;

/**
 * Tells the delegate that a table column was resized.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager columnDidResize:(NSNotification *_Nullable)notification;

/**
 * Tells the delegate that the table view’s selection is in the process of changing.
 */
- (void)tableViewManager:(TableViewManager *_Nullable)manager selectionIsChanging:(NSNotification *_Nullable)notification;

@end

@interface TableViewManager : NSObject <NSTableViewDataSource, NSTableViewDelegate>

/// Protocols
///
@property (nonatomic, weak) id<TableViewManagerProtocols> _Nullable protocols;

/// @property
///
@property (nonatomic, weak, readonly) NSTableView * _Nullable tableView;

/// Initializes
///
- (instancetype _Nullable )initWithTableView:(NSTableView * _Nonnull)tableView
                                      source:(id<TableViewManagerProtocols>_Nullable)source
                         provider:(DataProvider * _Nonnull)provider;

/// TableViewManager methods
///
- (void)reloadData;

@property (strong, nonatomic) id<DragTrackingDelegate> _Nullable dragTrackingDelegate;
@property (strong, nonatomic) id<DropTrackingDelegate> _Nullable dropTrackingDelegate;

@end
