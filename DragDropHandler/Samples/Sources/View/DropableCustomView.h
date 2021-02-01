//
//  dropableCustomView.h
//  Samples
//
//  Created by Phu Tran on 1/26/21.
//

#import <Cocoa/Cocoa.h>

#import "DroppableNSView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeleteRowCallBack)(NSString *string);

@interface DropableCustomView : DroppableNSView
@property (strong, nonatomic) DeleteRowCallBack deleteRowCallBack;
@end

NS_ASSUME_NONNULL_END
