# CustomTabBar

Click the image to view video on YouTube.com


[![ScreenShot](https://github.com/xuguojun/CustomTabBar/blob/master/CustomTabBar/Portrait.png)](http://youtu.be/NIDZ87v2yXk)
[![ScreenShot](https://github.com/xuguojun/CustomTabBar/blob/master/CustomTabBar/Landscape.png)](https://youtu.be/NIDZ87v2yXk)

#Using

self.tabBar.titles = @[@"TAB 1", @"TAB 2", @"TAB 3", @"TAB 4"];

implement the folowing delegate method to handle tab selection action:

#pragma mark - GJTabBarDelegate
- (void)tabBar:(GJTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index{
    NSLog(@"You Select Tab At Index %ld", (long)index);
}
