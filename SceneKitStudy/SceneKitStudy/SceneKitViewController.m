//
//  ViewController.m
//  SceneKitStudy
//
//  Created by prince on 2017/12/13.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "SceneKitViewController.h"
#import <SceneKit/SceneKit.h>

@interface SceneKitViewController ()

@end

@implementation SceneKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"SceneKit";
    [self setupScnView];
}

-(void)setupScnView
{
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.scene = [SCNScene scene];
    scnView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scnView];
    
    SCNNode *textNode = [SCNNode node];
    SCNText *text = [SCNText textWithString:@"酷走天涯" extrusionDepth:0.5];
    textNode.geometry = text;
    
    [scnView.scene.rootNode addChildNode:textNode];
    
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIColor blueColor];
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
//    boxNode.position = SCNVector3Make(self.view.bounds.size.width/2,self.view.bounds.size.height/2,0);
    
    [scnView.scene.rootNode addChildNode:boxNode];
    
    scnView.allowsCameraControl = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
