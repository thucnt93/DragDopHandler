//
//  AbtractHandlerModel.m
//  DragDropHandler
//
//  Created by Thuc Nguyen on 26/01/2021.
//

#import "DragDropHandlerInfo.h"

@implementation DragDropHandlerInfo

- (instancetype)initWithInfo:(id<NSDraggingInfo>)info {
    self = [super init];
    if (self) {
        self.info = info;
    }
    return self;
}

@end
