//
//  CustomDragOperation.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 25/01/2021.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CustomDragOperation)
{
    CustomDragOperation_STOP        = 128,
    CustomDragOperation_MOVE        = 128 << 1,
    CustomDragOperation_LINK        = 128 << 2,
    CustomDragOperation_ALLOW       = 128 << 3,
    CustomDragOperation_RIGHT       = 128 << 4,
    CustomDragOperation_NONE        = 128 << 10,
};

@interface DragOperation : NSObject

+ (void)changeCursorByOperation:(CustomDragOperation)operation;

@end
NS_ASSUME_NONNULL_END
