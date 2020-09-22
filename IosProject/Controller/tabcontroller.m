//
//  tabcontroller.m
//  IosProject
//
//  Created by IlyesTourki on 5/5/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

#import "TabController.h"

@interface TabController ()

@end

@implementation TabController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.tabBar invalidateIntrinsicContentSize];

    CGFloat tabSize = 44.0;
    
  
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].interfaceOrientation ;

    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        tabSize = 32.0;
    }

    CGRect tabFrame = self.tabBar.frame;

    tabFrame.size.height = tabSize;

    tabFrame.origin.y = self.view.frame.origin.y;

    self.tabBar.frame = tabFrame;

    // Set the translucent property to NO then back to YES to
    // force the UITabBar to reblur, otherwise part of the
    // new frame will be completely transparent if we rotate
    // from a landscape orientation to a portrait orientation.

    self.tabBar.translucent = NO;
    self.tabBar.translucent = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
