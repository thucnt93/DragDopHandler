//
//  DroppableNSView.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/25/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "DroppableNSView.h"
#import "DragDropHandlerInfo.h"

@interface DroppableNSView ()<NSDraggingDestination>
{
    DropHandler *_dropHandler;
}

@end

@implementation DroppableNSView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self registerDraggedType];
}

- (void)registerDraggedType
{
    [self registerForDraggedTypes:@[(id)kUTTypeData]];
}

#pragma mark - Getter/Setter

- (void)setDropTrackingDelegate:(id<DropTrackingDelegate>)dropTrackingDelegate
{
    _dropHandler = [[DropHandler alloc] initWithDropTrackingDelegate:dropTrackingDelegate];
}

#pragma mark - NSDraggingDestination Protocol

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)draggingInfo
{
    if (_dropHandler != nil)
    {
        
        DragDropHandlerInfo *info = [[DragDropHandlerInfo alloc] initWithInfo:draggingInfo];
        return [_dropHandler handleDraggingUpdated:info onTarget:self];
    }
    
    return NSDragOperationNone;
}

- (void)draggingExited:(id<NSDraggingInfo>)draggingInfo
{
    if (_dropHandler != nil)
    {
        DragDropHandlerInfo *info = [[DragDropHandlerInfo alloc] initWithInfo:draggingInfo];
        return [_dropHandler handleDraggingExited:info onTarget:self];
    }
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)draggingInfo
{
    if (_dropHandler != nil)
    {
        DragDropHandlerInfo *info = [[DragDropHandlerInfo alloc] initWithInfo:draggingInfo];
        BOOL result = [_dropHandler handlePerformDraggingOperation:info onTarget:self];
        return result;
    }
    
    return NO;
}

/*
- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    NSLog(@"CONCLUDE DRAG OPERATION");
}
 */

/*
- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    NSLog(@"draggingEnded");
}
 */



@end
