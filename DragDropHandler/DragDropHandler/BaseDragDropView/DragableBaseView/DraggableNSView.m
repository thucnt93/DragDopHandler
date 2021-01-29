//
//  DraggableNSView.m
//  TestDragDrop
//
//  Created by Trung Nguyen on 12/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

#import "DraggableNSView.h"

@interface DraggableNSView ()<NSPasteboardItemDataProvider, NSDraggingSource>
{
    DragHandler *_dragHandler;
}

@end

@implementation DraggableNSView

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.disableDragTracking = NO;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

#pragma mark - Getter/Setter

- (void)setDragTrackingDelegate:(id<DragTrackingDelegate>)dragTrackingDelegate
{
    _dragHandler = [[DragHandler alloc] initWithDragTrackingDelegate:dragTrackingDelegate];
}

#pragma mark - Mouse events

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSPasteboardType)type
{
    NSString *typeTIFF = (NSString*)kUTTypeTIFF;
    NSImage *image = [NSImage imageNamed:@"cursor-stop"];
    NSImage *finalImage = [self tintImageWithImage:image];
    NSData *tiffData = [finalImage TIFFRepresentation];
    [pasteboard setData:tiffData forType:typeTIFF];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    
    if (self.titleData == nil) {
        self.titleData = @"Need to set data";
    }
    NSData *data = [self.titleData dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [pbItem setData:data forType:NSPasteboardTypeString];
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    NSRect draggingRect = [self visibleRect];

    [dragItem setDraggingFrame:draggingRect contents:[self imageRepresentative]];

    //create a dragging session with our drag item and ourself as the source.
    NSDraggingSession *draggingSession = [self beginDraggingSessionWithItems:[NSArray arrayWithObject:dragItem] event:theEvent source:self];
    
    //causes the dragging item to slide back to the source if the drag fails.
    draggingSession.animatesToStartingPositionsOnCancelOrFail = YES;
    draggingSession.draggingFormation = NSDraggingFormationNone;
}

#pragma mark - Local methods

- (NSImage *)tintImageWithImage:(NSImage *)image
{
    NSImage *newImage = [[NSImage alloc] initWithSize:image.size];
    [newImage lockFocus];
    [image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositingOperationDestinationIn fraction:1.0];
    [newImage unlockFocus];
    return newImage;
}

- (NSImage *)imageRepresentative
{
    NSBitmapImageRep *imageRep = [self bitmapImageRepForCachingDisplayInRect:[self visibleRect]];
    [self cacheDisplayInRect:[self visibleRect] toBitmapImageRep:imageRep];
    NSImage *image = [[NSImage alloc] initWithCGImage:[imageRep CGImage] size:[self visibleRect].size];
    
    return image;
}

#pragma mark - NSDraggingSource

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context
{
    return NSDragOperationEvery;
}

- (void)draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint
{
    self.alphaValue = 0.3;
    
    if (_dragHandler != nil && !self.disableDragTracking)
    {
        [_dragHandler handleDragBeginWithSource:self atPoint:screenPoint];
    }
}

- (void)draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation
{
    self.alphaValue = 1.0;
    
    if (_dragHandler != nil && !self.disableDragTracking)
    {
        [_dragHandler handleDragEndWithSource:self atPoint:screenPoint];
    }
    
    self.disableDragTracking = NO;
}

- (void)draggingSession:(NSDraggingSession *)session movedToPoint:(NSPoint)screenPoint
{
    if (_dragHandler != nil && !self.disableDragTracking)
    {
        [_dragHandler handleDragMoveWithSource:self atPoint:screenPoint];
    }
}

@end
