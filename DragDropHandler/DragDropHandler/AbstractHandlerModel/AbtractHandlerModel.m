//
//  AbtractHandlerModel.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "AbtractHandlerModel.h"

@implementation AbtractHandlerModel

@synthesize animatesToDestination;

@synthesize draggedImage;

@synthesize draggedImageLocation;

@synthesize draggingDestinationWindow;

@synthesize draggingFormation;

@synthesize draggingLocation;

@synthesize draggingPasteboard;

@synthesize draggingSequenceNumber;

@synthesize draggingSource;

@synthesize draggingSourceOperationMask;

@synthesize numberOfValidItemsForDrop;

@synthesize springLoadingHighlight;

//- (void)enumerateDraggingItemsWithOptions:(NSDraggingItemEnumerationOptions)enumOpts forView:(nullable NSView *)view classes:(nonnull NSArray<Class> *)classArray searchOptions:(nonnull NSDictionary<NSPasteboardReadingOptionKey,id> *)searchOptions usingBlock:(nonnull void (^)(NSDraggingItem * _Nonnull, NSInteger, BOOL * _Nonnull))block {
//    <#code#>
//}
//
//- (nullable NSArray<NSString *> *)namesOfPromisedFilesDroppedAtDestination:(nonnull NSURL *)dropDestination {
//    <#code#>
//}
//
//- (void)resetSpringLoading {
//    <#code#>
//}
//
//- (void)slideDraggedImageTo:(NSPoint)screenPoint {
//    <#code#>
//}

@end
