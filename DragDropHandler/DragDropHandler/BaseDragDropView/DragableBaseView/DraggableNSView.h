//
//  DraggableNSView.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DragHandler.h"

//NS_ASSUME_NONNULL_BEGIN

@interface DraggableNSView : NSView

@property (nonatomic, assign) id<DragTrackingDelegate> dragTrackingDelegate;

@property (nonatomic) BOOL disableDragTracking;
@property (strong, nonatomic) NSString *titleData;
           
@end

//NS_ASSUME_NONNULL_END
