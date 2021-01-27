//
//  AbtractHandlerModel.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#import <AppKit/NSDragging.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSDraggingInfo;

@interface AbtractHandlerModel : NSObject<NSDraggingInfo>

@end

NS_ASSUME_NONNULL_END
