//
//  CollectionViewManager.h
//  DatasourceDemo
//
//  Created by Lam Nguyen on 1/4/19.
//  Copyright © 2019 Floware Inc. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@class CollectionViewManager;
@class DataProvider;
@protocol ListSupplierProtocol;

@protocol CollectionViewManagerProtocols <NSObject>

@optional
#pragma mark - UI

/**
 * Asks the delegate for the identifier of the specified item at index path.
 */
- (NSUserInterfaceItemIdentifier _Nullable )collectionViewManager:(CollectionViewManager *_Nullable)manager makeItemWithIdentifierForItem:(id _Nullable )item atIndexPath:(NSIndexPath *_Nullable)indexPath;

/**
 * Tells the delegate that an item view at specified index path will load its data.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager itemView:(NSCollectionViewItem *_Nullable)itemView willLoadData:(id<ListSupplierProtocol> _Nonnull)data forIndexPath:(NSIndexPath *_Nullable)indexPath;

/**
 * Asks the delegate to provide the supplementary view at the specified location in a section of the collection view.
 */
- (NSView *_Nullable)collectionViewManager:(CollectionViewManager *_Nullable)manager viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind _Nullable )kind forItem:(id _Nullable )item atIndexPath:(NSIndexPath *_Nullable)indexPath;

/**
 * Asks the delegate for size of the specified item at index path.
 */
- (NSSize)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout sizeForItem:(id _Nullable )item atIndexPath:(NSIndexPath *_Nullable)indexPath;

/**
 * Asks the delegate for the margins to apply to content in the specified section.
 */
- (NSEdgeInsets)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

/**
 * Asks the delegate for the spacing between successive rows or columns of a section.
 */
- (CGFloat)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/**
 * Asks the delegate for the spacing between successive items of a single row or column.
 */
- (CGFloat)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/**
 * Asks the delegate for the size of the header view in the specified section.
 */
- (NSSize)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout referenceSizeForHeaderItem:(id _Nullable )item inSection:(NSInteger)section;

/**
 * Asks the delegate for the size of the footer view in the specified section.
 */
- (NSSize)collectionViewManager:(CollectionViewManager *_Nullable)manager layout:(NSCollectionViewLayout *_Nullable)collectionViewLayout referenceSizeForFooterItem:(id _Nullable )item inSection:(NSInteger)section;

#pragma mark - Selection

/**
 * Asks the delegate to approve the pending highlighting of the specified items
 */
- (NSSet<NSIndexPath *> *_Nullable)collectionViewManager:(CollectionViewManager *_Nullable)manager shouldChangeItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths toHighlightState:(NSCollectionViewItemHighlightState)highlightState;

/**
 * Notifies the delegate that the highlight state of the specified items changed.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager didChangeItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths toHighlightState:(NSCollectionViewItemHighlightState)highlightState;

/**
 * Asks the delegate to approve the pending selection of items.
 */
- (NSSet<NSIndexPath *> *_Nullable)collectionViewManager:(CollectionViewManager *_Nullable)manager shouldSelectItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths;

/**
 * Asks the delegate object to approve the pending deselection of items.
 */
- (NSSet<NSIndexPath *> *_Nullable)collectionViewManager:(CollectionViewManager *_Nullable)manager shouldDeselectItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths;

/**
 * Asks the delegate for the identifier of the specified item at index path.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager didSelectItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths;

/**
 * Notifies the delegate object that one or more items were deselected.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager didDeselectItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths;

#pragma mark - Drag/Drop

/**
 * Asks the delegate whether a drag operation involving the specified items can begin.
 */
- (BOOL)collectionViewManager:(CollectionViewManager *_Nullable)manager canDragItems:(NSArray *_Nullable)draggedItems atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths withEvent:(NSEvent *_Nullable)event;

/**
 * Asks the delegate whether a drag operation can place the data on the pasteboard.
 */
- (BOOL)collectionViewManager:(CollectionViewManager *_Nullable)manager writeItems:(NSArray *_Nullable)draggedItems atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths toPasteboard:(NSPasteboard *_Nullable)pasteboard;

/**
 * Asks the delegate for creating and returning a drag image to represent the specified items during a drag.
 */
- (NSImage *_Nullable)collectionViewManager:(CollectionViewManager *_Nullable)manager draggingImageForItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths withEvent:(NSEvent *_Nullable)event offset:(NSPointPointer _Nullable )dragImageOffset;

/**
 * Asks the delegate whether a drop operation is possible at the specified location.
 */
- (NSDragOperation)collectionViewManager:(CollectionViewManager *_Nullable)manager validateDrop:(id<NSDraggingInfo>_Nullable)draggingInfo proposedItem:(nullable id)item proposedIndexPath:(NSIndexPath * __nonnull * __nonnull)proposedDropIndexPath dropOperation:(NSCollectionViewDropOperation *_Nullable)proposedDropOperation;

/**
 * Asks the delegate to incorporate the dropped content into the collection view.
 */
- (BOOL)collectionViewManager:(CollectionViewManager *_Nullable)manager acceptDrop:(id<NSDraggingInfo>_Nullable)draggingInfo item:(nullable id)item indexPath:(NSIndexPath *_Nullable)indexPath dropOperation:(NSCollectionViewDropOperation)dropOperation;

/**
 * Asks the delegate to provide the pasteboard writer for the item at the specified index path.
 */
//- (nullable id<NSPasteboardWriting>)collectionViewManager:(CollectionViewManager *)manager pasteboardWriterForItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the delegate that a drag session is about to begin.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session willBeginAtPoint:(NSPoint)screenPoint forItems:(NSArray *_Nullable)items atIndexPaths:(NSSet<NSIndexPath *> *_Nullable)indexPaths;

/**
 * Asks the delegate that a drag session ended.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager draggingSession:(NSDraggingSession *_Nullable)session endedAtPoint:(NSPoint)screenPoint dragOperation:(NSDragOperation)operation;

/**
 * Asks the delegate to update the dragging items during a drag operation.
 */
- (void)collectionViewManager:(CollectionViewManager *_Nullable)manager updateDraggingItemsForDrag:(id<NSDraggingInfo>_Nullable)draggingInfo;

@end

@interface CollectionViewManager : NSObject <NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

/// Protocols
///
@property (nonatomic, weak) id<CollectionViewManagerProtocols> _Nullable protocols;

/// @property
///
@property (nonatomic, weak, readonly) NSCollectionView * _Nullable collectionView;

/// Initializes
///
- (instancetype _Nullable )initWithCollectionView:(NSCollectionView *_Nullable)collectionView source:(id<CollectionViewManagerProtocols>_Nullable)source provider:(DataProvider *_Nullable)provider;

/// OutlineViewManager methods
///
- (void)reloadData;

@end
