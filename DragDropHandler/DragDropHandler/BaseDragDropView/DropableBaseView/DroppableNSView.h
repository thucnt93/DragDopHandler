//
//  DroppableNSView.h
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DropHandler.h"

//NS_ASSUME_NONNULL_BEGIN

@interface DroppableNSView : NSView

@property (nonatomic, assign) id<DropTrackingDelegate> dropTrackingDelegate;

@end

//NS_ASSUME_NONNULL_END
