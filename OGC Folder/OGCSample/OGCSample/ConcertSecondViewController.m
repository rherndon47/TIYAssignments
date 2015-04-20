//
//  ConcertSecondViewController.m
//  OGCSample
//
//  Created by Richard Herndon on 4/14/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ConcertSecondViewController.h"

@interface ConcertSecondViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *imageURL;

- (IBAction)showMapPlazaLive:(UIButton *)sender;

@end

@implementation ConcertSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.imageView];
    self.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.orlandogaychorus.org/images/One-Voice-poster-format--345.jpg"]];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)showMapPlazaLive:(UIButton *)sender
{

}

#pragma mark - UIScrollView methods

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    self.scrollView.contentSize = self.image ? self.image.size :CGSizeZero;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
