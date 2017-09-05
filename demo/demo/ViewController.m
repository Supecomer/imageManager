//
//  ViewController.m
//  demo
//
//  Created by ciome on 2017/8/24.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "ViewController.h"
#import <CIImageManager/CIImageManagerHeader.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [CIImageManager getInstance].highlightColor = [UIColor orangeColor];
    [CIImageManager getInstance].blendMode = kCGBlendModeDestinationIn;
    UIButton  *bt = [UIButton  buttonWithType:UIButtonTypeCustom];
    UIImage  *im = [UIImage imageNamed:@"image.png"];
    UIImage  *im_h = [UIImage imageNamed:@"image.png" withImageType:enum_imageType_highlight];
    bt.frame = CGRectMake(100, 50, im.size.width, im.size.width);
    [bt setImage:im forState:UIControlStateNormal];
    [bt setImage:im_h forState:UIControlStateSelected];
    [bt  addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];
    bt.tag = 10;
    [self.view addSubview:bt];
    
    { UIButton  *bt = [UIButton  buttonWithType:UIButtonTypeCustom];
    UIImage  *im = [UIImage imageNamed:@"people.png"];
    UIImage  *im_h = [UIImage imageNamed:@"people.png" withImageType:enum_imageType_highlight];
    bt.frame = CGRectMake(100, 250, im.size.width, im.size.width);
    [bt setImage:im forState:UIControlStateNormal];
    [bt setImage:im_h forState:UIControlStateSelected];
    bt.tag = 11;
    [bt  addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];}
    
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(100, 500, 100, 50)];
    sw.on = false;
    [self.view addSubview:sw];
    [sw addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
}


- (void)changeValue:(id)sender
{
    UISwitch  *sw = sender;
    if (sw.on) {
       [CIImageManager getInstance].blendMode = kCGBlendModeDestinationIn;
       [CIImageManager getInstance].highlightColor = [UIColor purpleColor];
    }
    else
    {
      [CIImageManager getInstance].blendMode = kCGBlendModeOverlay;
      [CIImageManager getInstance].highlightColor = [UIColor orangeColor];
    }
    UIButton  *bt = [self.view viewWithTag:10];
    UIImage  *im_h = [UIImage imageNamed:@"image.png" withImageType:enum_imageType_highlight];
    [bt setImage:im_h forState:UIControlStateSelected];
    
    UIButton  *bt1 = [self.view viewWithTag:11];
    UIImage  *im_h_1 = [UIImage imageNamed:@"people.png" withImageType:enum_imageType_highlight];
    [bt1 setImage:im_h_1 forState:UIControlStateSelected];

    sw.on = !sw.on;
    
}


- (void)testButton:(id)sender
{
    UIButton  *bt = sender;
    bt.selected = !bt.selected;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
