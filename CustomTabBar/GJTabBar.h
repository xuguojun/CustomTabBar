//
//  GJTabBar.h
//  CustomTabBar
//
//  Created by guojun on 7/12/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJTabBar;
@protocol GJTabBarDelegate <NSObject>

@required
- (void)tabBar:(GJTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index;

@end
IB_DESIGNABLE
@interface GJTabBar : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedTabIndex;

@property (nonatomic, strong) IBInspectable UIColor *tabSelectedColor;
@property (nonatomic, strong) IBInspectable UIColor *tabUnselectedColor;

@property (nonatomic, weak) IBOutlet id<GJTabBarDelegate> delegate;

@end
