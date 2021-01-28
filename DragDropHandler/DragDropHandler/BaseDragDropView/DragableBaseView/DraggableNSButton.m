//
//  DraggableNSButton.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//


#import "DraggableNSButton.h"


@interface DraggableNSButton() {
    DragHandler *_dragHandler;
}

@end

@implementation DraggableNSButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.disableDragTracking = NO;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor brownColor] CGColor];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:(id)kUTTypeData, NSPasteboardTypeFileURL, nil]];
}

- (void)setDragTrackingDelegate:(id)dragTrackingDelegate {
    _dragHandler = [[DragHandler alloc] initWithDragTrackingDelegate:dragTrackingDelegate];
}

- (NSImage *)imageRepresentative
{
    NSBitmapImageRep *imageRep = [self bitmapImageRepForCachingDisplayInRect:[self visibleRect]];
    [self cacheDisplayInRect:[self visibleRect] toBitmapImageRep:imageRep];
    NSImage *image = [[NSImage alloc] initWithCGImage:[imageRep CGImage] size:[self visibleRect].size];
    
    return image;
}

- (void)setDraggingSessionWithEvent:(NSEvent *)event
{
    //    if (self.draggingEnabled && _dragEnabled) {
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    [pbItem setDataProvider:self forTypes:[NSArray arrayWithObjects:(id)kUTTypeData, nil]];
    
    NSString *titleStringButton;
    if (self.title == nil) {
        titleStringButton = self.stringValue;
    } else {
        titleStringButton = self.title;
    }
    NSData *data = [titleStringButton dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [pbItem setData:data forType:NSPasteboardTypeString];
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    NSRect draggingRect = [self visibleRect];
    
    [dragItem setDraggingFrame:draggingRect contents:[self imageRepresentative]];
    
    //create a dragging session with our drag item and ourself as the source.
    NSDraggingSession *draggingSession = [self beginDraggingSessionWithItems:[NSArray arrayWithObject:dragItem] event:event source:self];
    
    //causes the dragging item to slide back to the source if the drag fails.
    draggingSession.animatesToStartingPositionsOnCancelOrFail = YES;
    draggingSession.draggingFormation = NSDraggingFormationNone;
    //    }
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
    return YES;
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)mouseUp:(NSEvent *)event {
    // Do nothing but it need to catch event mouseDragged
}

- (void)mouseDown:(NSEvent *)event {
    
}

- (void)mouseDragged:(NSEvent *)event
{
    self.disableDragTracking = NO;
    [self setDraggingSessionWithEvent:event];
    [super mouseDragged:event];
}

- (void)draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint {
    if (_dragHandler != nil && !self.disableDragTracking) {
        [_dragHandler handleDragBeginWithSource:self atPoint:screenPoint];
    }
}

- (void)draggingSession:(NSDraggingSession *)session movedToPoint:(NSPoint)screenPoint {
    if (_dragHandler != nil && !self.disableDragTracking) {
        [_dragHandler handleDragMoveWithSource:self atPoint:screenPoint];
    }
    
    NSLog(@"Session location x: %f", session.draggingLocation.x);
    
    NSLog(@"screenPoint x: %f", screenPoint.x);
}

- (void)draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    if (_dragHandler != nil && !self.disableDragTracking) {
        [_dragHandler handleDragEndWithSource:self atPoint:screenPoint];
    }
}


@end
