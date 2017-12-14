//
//  ViewController.m
//  SceneKitStudy
//
//  Created by prince on 2017/12/13.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "SceneKitViewController.h"
#import "GameSCNView.h"

@interface SceneKitViewController ()<UINavigationControllerDelegate>

@end

@implementation SceneKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"SceneKit";
    // 设置导航控制器的代理为self
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self setupScnView];
}

-(void)setupScnView
{
    GameSCNView *scnView = [[GameSCNView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scnView];
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}


@end
