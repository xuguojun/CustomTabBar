//
//  ViewController.m
//  CustomTabBar
//
//  Created by guojun on 7/12/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "ViewController.h"
#import "GJTabBar.h"

@interface ViewController ()<GJTabBarDelegate>

@property (nonatomic, weak) IBOutlet GJTabBar *tabBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.titles = @[@"TAB 1", @"TAB 2", @"TAB 3", @"TAB 4"];
}

#pragma mark - GJTabBarDelegate
- (void)tabBar:(GJTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index{
    NSLog(@"You Select Tab At Index %ld", (long)index);
}

@end
