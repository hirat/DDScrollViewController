//
//  DDScrollViewController.h
//  
//
//  Created by Hirat on 13-11-8.
//
//

#import <UIKit/UIKit.h>

@protocol DDScrollViewDataSource;

@interface DDScrollViewController : UIViewController
@property (nonatomic, weak) id <DDScrollViewDataSource> dataSource;

- (void)reloadData;
@end


#pragma mark - dataSource
@protocol DDScrollViewDataSource <NSObject>

- (NSUInteger)numberOfViewControllerInDDScrollView:(DDScrollViewController*)DDScrollView;
- (UIViewController *)ddScrollView:(DDScrollViewController*)ddScrollView contentViewControllerAtIndex:(NSUInteger)index;

@end
