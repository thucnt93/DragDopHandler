//
//  DropHandler.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Foundation/Foundation.h>
#import "DragDropHandlerProtocol.h"
#import "CustomDragOperation.h"
#import "DragDropTrackingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DropHandler : NSObject<DestinationDropHandlerProtocol>

- (instancetype)initWithDropTrackingDelegate:(id<DropTrackingDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
