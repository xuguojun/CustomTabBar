//
//  GJTab.h
//  CustomTabBar
//
//  Created by guojun on 7/12/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJTab;
@protocol GJTabDelegate <NSObject>

@optional
- (void)tab:(GJTab *)tab didSelectTabAtIndex:(NSInteger)index;

@end
IB_DESIGNABLE
@interface GJTab : UIView

@property (nonatomic, copy) IBInspectable NSString *title;
@property (nonatomic, assign) IBInspectable NSInteger index;
@property (nonatomic, assign) IBInspectable BOOL isSelected;

@property (nonatomic, strong) IBInspectable UIColor *selectedColor;
@property (nonatomic, strong) IBInspectable UIColor *unselectedColor;

@property (nonatomic, weak) IBOutlet id<GJTabDelegate> delegate;

@end
