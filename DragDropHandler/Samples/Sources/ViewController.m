//
//  ViewController.m
//  Samples
//
//  Created by Created by Flo Team on 10/17/19.
//  Copyright © 2020 Floware. All rights reserved.
//

#import "ViewController.h"

@interface ViewController() {
    
}
@property (weak) IBOutlet NSButton *fileDragButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSView *dropView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
}

- (void)addAutoResizingView:(NSView *)subView toView:(NSView *)containerView
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
