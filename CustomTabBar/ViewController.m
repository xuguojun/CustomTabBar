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

@property (nonatomic, weak) IBOutlet GJTabBar *tabBar1;
@property (nonatomic, weak) IBOutlet GJTabBar *tabBar2;
@property (nonatomic, weak) IBOutlet GJTabBar *tabBar3;
@property (nonatomic, weak) IBOutlet GJTabBar *tabBar4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar1.titles = @[@"TAB 1", @"TAB 2"];
    self.tabBar2.titles = @[@"TAB 1", @"TAB 2", @"TAB 3"];
    self.tabBar3.titles = @[@"TAB 1", @"TAB 2", @"TAB 3", @"TAB 4"];
    
    self.tabBar4.titles = @[@"TAB 1", @"TAB 2", @"TAB 3", @"TAB 4"];
    self.tabBar4.tabSelectedColor = [UIColor redColor];
}

#pragma mark - GJTabBarDelegate
- (void)tabBar:(GJTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index{
    NSLog(@"You Select Tab At Index %ld", (long)index);
}

@end
