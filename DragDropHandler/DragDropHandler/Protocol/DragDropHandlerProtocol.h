//
//  DragDropHandler.h
//  DragDropHandler
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "CustomDragOperation.h"


//! Project version number for DragDropHandler.
FOUNDATION_EXPORT double DragDropHandlerVersionNumber;

//! Project version string for DragDropHandler.
FOUNDATION_EXPORT const unsigned char DragDropHandlerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DragDropHandler/PublicHeader.h>

@protocol DraggingSourceHandlerProtocol

- (CustomDragOperation)dragBeginWithSource:(id)source atPoint:(NSPoint)atPoint;
- (CustomDragOperation)dragMoveWithSource:(id)source atPoint:(NSPoint)atPoint;
- (void)dragEndWithSource:(id)source atPoint:(NSPoint)atPoint;

@end


@protocol DropDestinationHandlerProtocol

- (CustomDragOperation)dragUpdatedOnTarget:(id)onTarget withInfo:(id<NSDraggingInfo>)draggingInfo;
- (BOOL)performDropOnTarget:(id)onTarget draggingInfo:(id<NSDraggingInfo>)draggingInfo;

@end



/* later
@protocol ItemProtocol

@end
*/


