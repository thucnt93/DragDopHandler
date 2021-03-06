//
//  DropSampleView.h
//  Samples
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Cocoa/Cocoa.h>
#import "DragDropHandlerProtocol.h"
#import "CustomDragOperation.h"
#import "DropHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface DropSampleView : NSView<DropTrackingDelegate>

@end

NS_ASSUME_NONNULL_END
