//
//  DraggableNSButton.h
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>
#import "DragHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface DraggableNSButton : NSButton<NSDraggingSource, NSDraggingDestination>

@property (nonatomic) BOOL disableDragTracking;
@property (strong, nonatomic) id<DragTrackingDelegate> dragTrackingDelegate;
@end

NS_ASSUME_NONNULL_END
