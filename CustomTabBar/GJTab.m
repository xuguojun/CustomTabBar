//
//  GJTab.m
//  CustomTabBar
//
//  Created by guojun on 7/12/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "GJTab.h"
#import "UIColor+GJColor.h"

@interface GJTab()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIView *bottomBar;
@property (nonatomic, strong) UIGestureRecognizer *gesture;

@end

@implementation GJTab

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
        [self addAction];
        [self configureView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
        [self addAction];
        [self configureView];
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)loadView{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"GJTab"
                                                                   owner:self
                                                                 options:nil] firstObject];
    view.backgroundColor = [UIColor clearColor];
    view.frame = self.bounds;
    
    [self addSubview:view];
}

- (void)addAction{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.gesture];
}

- (void)tabBarDidSelect:(id)sender{
    
    self.isSelected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tab:didSelectTabAtIndex:)]) {
        [self.delegate tab:self didSelectTabAtIndex:self.index];
    }
}

- (void)configureView{
    [self configureUnselectedView];
}

- (void)configureSelectedView{
    self.titleLabel.textColor = self.selectedColor ? self.selectedColor : UIColorFromRGB(0x259CDB);
    self.bottomBar.backgroundColor = self.selectedColor ? self.selectedColor : UIColorFromRGB(0x259CDB);
}

- (void)configureUnselectedView{
    self.titleLabel.textColor = self.unselectedColor ? self.unselectedColor : [UIColor grayColor];
    self.bottomBar.backgroundColor = [UIColor clearColor];
}

#pragma mark - Getters & Setters
- (UIGestureRecognizer *)gesture{
    if (!_gesture) {
        _gesture = [UITapGestureRecognizer new];
        [_gesture addTarget:self action:@selector(tabBarDidSelect:)];
    }
    
    return _gesture;
}

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        self.titleLabel.text = title;
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        
        if (isSelected) {
            [self configureSelectedView];
        } else {
            [self configureUnselectedView];
        }
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;
        
        if (self.isSelected) {
            [self configureSelectedView];
        }
    }
}

- (void)setUnselectedColor:(UIColor *)unselectedColor{
    if (_unselectedColor != unselectedColor) {
        _unselectedColor = unselectedColor;
        
        if (!self.isSelected) {
            [self configureUnselectedView];
        }
    }
}
@end
