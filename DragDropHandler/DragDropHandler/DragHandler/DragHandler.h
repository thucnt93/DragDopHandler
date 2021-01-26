//
//  DragHandler.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Foundation/Foundation.h>
#import "CustomDragOperation.h"
#import "DragDropHandlerProtocol.h"
#import "DragDropTrackingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DragHandler : NSObject<DraggingSourceHandlerProtocol>

- (instancetype)initWithDragTrackingDelegate:(id<DragTrackingDelegate>)targetDragTrackingDelegate;

@end

NS_ASSUME_NONNULL_END
