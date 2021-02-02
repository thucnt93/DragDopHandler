//
//  dropableCustomView.m
//  Samples
//
//  Created by Phu Tran on 1/26/21.
//

#import "DropableCustomView.h"
#import "NSView+init.h"
#import "DragableButton.h"

@interface DropableCustomView()<DropTrackingDelegate>

@property (weak) IBOutlet NSTextField *dropDataNotify;

@end

@implementation DropableCustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor grayColor] CGColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dropTrackingDelegate = self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self createFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self createFromNib];
    }
    return self;
}

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo {
    NSLog(@"Validate dragging info");
    NSString *stringFromPasteboard = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
    if ([stringFromPasteboard isEqualToString:@""]) {
        return CustomDragOperation_MOVE;
    }
    return CustomDragOperation_ALLOW;
}

#pragma mark - NSView drop tracking delegate

- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo {
    
    if ([onTarget isKindOfClass: DraggableNSButton.self]) {
        NSLog(@"DraggableNSButton drop");
    }
    
    if ([onTarget isKindOfClass: DroppableNSView.self]) {
        NSLog(@"DroppableNSView drop");
        NSString *stringFromPasteboard = [draggingInfo.draggingPasteboard stringForType:NSPasteboardTypeString];
        self.dropDataNotify.stringValue = stringFromPasteboard;
        if (![stringFromPasteboard  isEqual: @""] && ![draggingInfo.draggingSource isKindOfClass:DragableButton.self]) {
            self.deleteRowCallBack(stringFromPasteboard);
        }
    }
    return YES;
}

@end
