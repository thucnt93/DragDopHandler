//
//  NSView+init.h
//  Samples
//
//  Created by Thuc Nguyen on 29/01/2021.
//


#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Init)
- (instancetype)createFromNib;
+ (void)addAutoResizingView:(NSView *)subView toView:(NSView *)containerView;
@end

NS_ASSUME_NONNULL_END
