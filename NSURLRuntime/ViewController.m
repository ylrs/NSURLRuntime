//
//  ViewController.m
//  NSURLRuntime
//
//  Created by YLRS on 2017/11/14.
//  Copyright © 2017年 YLRS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://www.baidu.com/@#$%^&*(哈哈.jpg ";
    
    NSURL *URL = [NSURL URLWithString:url];
    
    NSLog(@"url:%@",URL);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
