//
//  DropHandler.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Foundation/Foundation.h>
#import "DragDropHandlerProtocol.h"
#import "CustomDragOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DropHandler : NSObject<DestinationDropHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
