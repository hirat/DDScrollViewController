//
//  HomeViewController.m
//  DDScrollViewController Example
//
//  Created by Hirat on 13-11-8.
//  Copyright (c) 2013年 Hirat. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray* viewControllerArray;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    self.dataSource = self;
    
    [super viewDidLoad];
}

- (void)awakeFromNib
{
    NSUInteger numberOfPages = 4;
    self.viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k)
    {
        [self.viewControllerArray addObject:[NSNull null]];
    }
    
    [self.viewControllerArray replaceObjectAtIndex: 0 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"Top1"]];
    [self.viewControllerArray replaceObjectAtIndex: 1 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"Top2"]];
    [self.viewControllerArray replaceObjectAtIndex: 2 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"Top3"]];
    [self.viewControllerArray replaceObjectAtIndex: 3 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"Top4"]];
}

#pragma mark - DDScrollViewDataSource

- (NSUInteger)numberOfViewControllerInDDScrollView:(DDScrollViewController *)DDScrollView
{
    return [self.viewControllerArray count];
}

- (UIViewController*)ddScrollView:(DDScrollViewController *)ddScrollView contentViewControllerAtIndex:(NSUInteger)index
{
    return [self.viewControllerArray objectAtIndex:index];
}

@end
