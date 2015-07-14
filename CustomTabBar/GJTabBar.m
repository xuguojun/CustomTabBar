//
//  GJTabBar.m
//  CustomTabBar
//
//  Created by guojun on 7/12/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "GJTabBar.h"
#import "GJTab.h"

@interface GJTabBar()<GJTabDelegate>


@end

@implementation GJTabBar

- (void)drawShadow {
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-1, 1);
    self.layer.shadowRadius = 1.5;
    self.layer.shadowOpacity = 0.2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self drawShadow];
}

#pragma mark - Private Methods
- (NSArray *)generateTabsWithTitles:(NSArray *)titles{
    
    NSUInteger count = titles.count;
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        GJTab *tab = [GJTab new];
        
        tab.title = titles[i];
        tab.index = i;
        tab.delegate = self;
        
        [tab setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:tab];
        
        [views addObject:tab];
    }
    
    return views;
}

- (void)setConstraintsForTabs:(NSArray *)tabs{
    
    NSUInteger count = tabs.count;
    
    // 1. Height
    for (int i = 0; i < count; i++) {
        UIView *tab = tabs[i];
        NSString *VFLFormat = [NSString stringWithFormat:@"V:[tab(%f)]", self.bounds.size.height];
        NSDictionary *dictionary = NSDictionaryOfVariableBindings(tab);
        NSArray *height = [NSLayoutConstraint constraintsWithVisualFormat:VFLFormat
                                                                  options:0
                                                                  metrics:nil
                                                                    views:dictionary];
        [self addConstraints:height];
    }
    
    // 2. Center Y
    for (int i = 0; i < count; i++) {
        UIView *tab = tabs[i];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:tab
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.f
                                                                    constant:0.f];
        [self addConstraint:centerY];
    }
    
    // 3. Horizontal Spacing
    for (int i = 0; i < count; i++) {
        UIView *tab = tabs[i];
        if (i == 0) {
            NSLayoutConstraint *leadingSpacing = [NSLayoutConstraint constraintWithItem:tab
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeading
                                                                             multiplier:1.f
                                                                               constant:0.f];
            
            [self addConstraint:leadingSpacing];
        } else {
            NSLayoutConstraint *horizontalSpacing = [NSLayoutConstraint constraintWithItem:tab
                                                                                 attribute:NSLayoutAttributeLeading
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:tabs[i - 1]
                                                                                 attribute:NSLayoutAttributeTrailing
                                                                                multiplier:1.f
                                                                                  constant:0.f];
            
            [self addConstraint:horizontalSpacing];
        }
    }
    
    // 4. Width Equal
    for (int i = 0; i < count; i++) {
        UIView *tab = tabs[i];
        if (i > 0) {
            NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:tab
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:tabs[i - 1]
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:1.f
                                                                           constant:0.f];
            
            [self addConstraint:equalWidth];
        }
    }
    
    // 5. Trailing for Last View
    UIView *lastTab = tabs.lastObject;
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:lastTab
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.f
                                                                 constant:0.f];
    [self addConstraint:trailing];
}

- (void)removeAllSubviews{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[GJTab class]]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - KTGuideTabDelegate
- (void)tab:(GJTab *)tab didSelectTabAtIndex:(NSInteger)index{
    
    // deselect others
    NSArray *tabs = self.subviews;
    for (GJTab *oneTab in tabs) {
        if (oneTab != tab) {
            if ([oneTab isKindOfClass:[GJTab class]]) {
                oneTab.isSelected = NO;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectTabAtIndex:)]) {
        [self.delegate tabBar:self didSelectTabAtIndex:index];
    }
}
#pragma mark - Getters & Setters
- (void)setTitles:(NSArray *)titles{
    
    if (!titles || titles.count < 2) {
        NSLog(@"You should specify at least 2 tabs");
        return;
    }
    
    if (_titles != titles) {
        _titles = titles;
        
        [self removeAllSubviews];
        
        NSArray *tabs = [self generateTabsWithTitles:titles];
        [self setConstraintsForTabs:tabs];
        
        self.selectedTabIndex = 0;
    }
}

- (void)setSelectedTabIndex:(NSInteger)selectedTabIndex{
    
    _selectedTabIndex = selectedTabIndex;
    
    GJTab *selectedTab = self.subviews[selectedTabIndex];
    
    if ([selectedTab isKindOfClass:[GJTab class]]) {
        selectedTab.isSelected = YES;
        if ([selectedTab.delegate respondsToSelector:@selector(tab:didSelectTabAtIndex:)]) {
            [selectedTab.delegate tab:selectedTab didSelectTabAtIndex:selectedTabIndex];
        }
    }
}

- (void)setTabSelectedColor:(UIColor *)tabSelectedColor{
    if (_tabSelectedColor != tabSelectedColor) {
        _tabSelectedColor = tabSelectedColor;
        
        for (GJTab *subView in self.subviews) {
            if ([subView isKindOfClass:[GJTab class]]) {
                subView.selectedColor = tabSelectedColor;
            }
        }
    }
}

- (void)setTabUnselectedColor:(UIColor *)tabUnselectedColor{
    if (_tabUnselectedColor != tabUnselectedColor) {
        _tabUnselectedColor = tabUnselectedColor;
        
        for (GJTab *subView in self.subviews) {
            if ([subView isKindOfClass:[GJTab class]]) {
                subView.unselectedColor = tabUnselectedColor;
            }
        }
    }
}

@end
