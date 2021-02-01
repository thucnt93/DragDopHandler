//
//  NSView+init.m
//  Samples
//
//  Created by Thuc Nguyen on 29/01/2021.
//

#import "NSView+init.h"

@implementation NSView (Init)

- (NSString *)nibName {
    return NSStringFromClass(self.class);
}

- (instancetype)createFromNib {
    NSArray *nibs;
    [[NSBundle mainBundle] loadNibNamed:[self nibName] owner:self topLevelObjects:&nibs];
    id view = nil;
    for ( id object in nibs) {
        if ([object isKindOfClass:self.class]) {
            view = object;
            break;
        }
    }
    return view;
}

+ (void)addAutoResizingView:(NSView *)subView toView:(NSView *)containerView
{
    if (subView != nil)
    {
        [containerView addSubview:subView];
        
        [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
        
        // Should force update view constraints for update UI correctly.
        // [FM-1270] Show flashing for Flo app when open with Compact mode.
        [containerView layoutSubtreeIfNeeded];
        [containerView.superview layoutSubtreeIfNeeded];
    }
}

@end
