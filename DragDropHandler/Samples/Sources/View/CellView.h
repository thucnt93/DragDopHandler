//
//  CellView.h
//  Samples
//
//  Created by Thuc Nguyen on 29/01/2021.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellView : NSTableCellView
@property (weak) IBOutlet NSTextField *titleLabel;
@end

NS_ASSUME_NONNULL_END
