//
//  DragHandler.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Foundation/Foundation.h>
#import "CustomDragOperation.h"
#import "DragDropHandlerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DragHandler : NSObject<SourceDragHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
