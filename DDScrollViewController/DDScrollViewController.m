//
//  DDScrollViewController.m
//  
//
//  Created by Hirat on 13-11-8.
//
//

#import "DDScrollViewController.h"

@interface DDScrollViewController () <UIScrollViewDelegate>
@property UIScrollView *scrollView;
@property NSMutableArray *contents;
@property (nonatomic) CGFloat offsetRatio;
@property (nonatomic) NSInteger activeIndex;
@end

@implementation DDScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initControl];
    
    [self reloadData];
}

- (void)initControl
{
    self.contents = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i ++)
    {
        [self.contents addObject:[NSNull null]];
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame: self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 3, CGRectGetHeight(self.view.frame));
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview: self.scrollView];
}

#pragma mark -

- (void)reloadData
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < 3; i ++)
    {
        NSInteger thisPage = [self validIndexValue: self.activeIndex - 1 + i];
        [self.contents replaceObjectAtIndex: i withObject:[self.dataSource ddScrollView:self contentViewControllerAtIndex:thisPage]];
    }

    for (int i = 0; i < 3; i++)
    {
        UIViewController* viewController = [self.contents objectAtIndex:i];
        UIView* view = viewController.view;
        view.userInteractionEnabled = YES;
        view.frame = self.view.bounds;
        view.frame = CGRectOffset(self.scrollView.frame, view.frame.size.width * i, 0);
        [self.scrollView addSubview: view];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width + self.scrollView.frame.size.width * self.offsetRatio, 0)];
}

- (NSInteger)validIndexValue:(NSInteger)value
{
    if(value == -1)
    {
        value = self.numberOfControllers - 1;
    }
    
    if(value == self.numberOfControllers)
    {
        value = 0;
    }
    
    return value;
}

- (void)setActiveIndex:(NSInteger)activeIndex
{
    if (_activeIndex != activeIndex)
    {
        _activeIndex = activeIndex;
        [self reloadData];
    }
}

- (NSInteger)numberOfControllers
{
    return [self.dataSource numberOfViewControllerInDDScrollView:self];
}

- (void)setOffsetRatio:(CGFloat)offsetRatio
{
    if (_offsetRatio != offsetRatio)
    {
        _offsetRatio = offsetRatio;
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width + self.scrollView.frame.size.width * offsetRatio, 0)];
        if (offsetRatio > 0.5)
        {
            _offsetRatio = offsetRatio - 1;
            self.activeIndex = [self validIndexValue: self.activeIndex + 1];
        }
        
        if (offsetRatio < -0.5)
        {
            _offsetRatio = offsetRatio + 1;
            self.activeIndex = [self validIndexValue: self.activeIndex - 1];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.offsetRatio = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame) - 1;
}

@end
