//
//  ViewController.m
//  WYCButton
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//

#import "ViewController.h"
#import "WYCButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	WYCButton * button = [WYCButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(100, 100, 100, 40);
	[button setNormalTitleText:@"点击" selectedString:@"点击"];
	button.backgroundImageCornerRadius = 6;
	[button setNormalBackGroundColor:[UIColor redColor] setlectedColor:[UIColor yellowColor]];
	[button setNormalTitleColor:[UIColor blackColor] selectedColor:[UIColor blackColor]];
	[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)buttonAction:(WYCButton*)sender{
	NSLog(@"点击");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
