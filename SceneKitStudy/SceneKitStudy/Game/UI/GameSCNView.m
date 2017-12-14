//
//  GameSCNView.m
//  SceneKitStudy
//
//  Created by prince on 2017/12/14.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "GameSCNView.h"
#import "GameHeader.h"


@interface GameSCNView()
@property(nonatomic,strong)SCNNode *backgroundPictureNode;
@property(nonatomic,strong)SCNNode *backgroundColorNode;
@property(nonatomic,strong)SCNNode *readyNode;
@property(nonatomic,strong)SCNNode *countDownNode;
@end
@implementation GameSCNView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.scene = [SCNScene scene];
    //self.allowsCameraControl = YES;
    self.backgroundColor = [UIColor clearColor];
    {
        UIImage *backgroundImage = [ImageUtil loadImageWithDir:@"ready" WithName:@"bg.png"];
        CGSize size = backgroundImage.size;
        SCNPlane *plane = [SCNPlane planeWithWidth:size.width*self.width/DESIGN_SCREEN_WIDTH height:size.height*self.height/DESIGN_SCREEN_HEIGHT];
        SCNMaterial *material = [SCNMaterial material];
        material.diffuse.contents = backgroundImage;
        //material.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1,-1, 1), 0, 1, 0);
        plane.firstMaterial = material;
        
        _backgroundPictureNode = [SCNNode node];
        _backgroundPictureNode.geometry = plane;
        _backgroundPictureNode.position = SCNVector3Make(0, 0, 0);
        _backgroundPictureNode.renderingOrder = BACKPIC_NODE_RENDER_ORDER;
        
        [self.scene.rootNode addChildNode:_backgroundPictureNode];
    }
    
    {
        SCNPlane *plane = [SCNPlane planeWithWidth:self.width height:self.height];
        SCNMaterial *material = [SCNMaterial material];
        material.diffuse.contents = [UIColor blackColor];
        plane.firstMaterial = material;
        
        _backgroundColorNode = [[SCNNode alloc]init];
        _backgroundColorNode.geometry = plane;
        _backgroundColorNode.position = SCNVector3Make(0,0,0);
        _backgroundColorNode.renderingOrder = BACKCOLOR_NODE_RENDER_ORDER;
        
    }
    
    [self.scene.rootNode addChildNode:_backgroundColorNode];
    SCNAction *bgPicAction = [SCNAction customActionWithDuration:0.2 actionBlock:^(SCNNode * _Nonnull node, CGFloat elapsedTime) {
        node.opacity = elapsedTime/0.2;
    }];
    
    SCNAction *bgColorAction = [SCNAction customActionWithDuration:0.2 actionBlock:^(SCNNode * _Nonnull node, CGFloat elapsedTime) {
        node.opacity = 0.5* elapsedTime/0.2;
    }];
    
    [_backgroundPictureNode runAction:bgPicAction];
    [_backgroundColorNode runAction:bgColorAction];
    
    {
        UIImage *readyImage = [ImageUtil loadImageWithDir:@"ready" WithName:@"ready.png"];
        CGSize size = readyImage.size;
        SCNPlane *plane = [SCNPlane planeWithWidth:size.width*self.width/DESIGN_SCREEN_WIDTH height:size.height*self.height/DESIGN_SCREEN_HEIGHT];
        SCNMaterial *material = [SCNMaterial material];
        material.diffuse.contents =  readyImage;
        //material.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1,-1, 1), 0, 1, 0);
        //material.blendMode = SCNBlendModeAlpha;
        plane.firstMaterial = material;
        
        SCNAction *action = [SCNAction scaleTo:1 duration:0.2];
        _readyNode = [[SCNNode alloc]init];
        _readyNode.scale = SCNVector3Zero;
        _readyNode.geometry = plane;
        _readyNode.position = SCNVector3Make(0, (self.height/2 - plane.height/2), 0);
        _readyNode.renderingOrder = READY_NODE_RENDER_ORDER;
//        [self.gameDelegate playCountDown:0];
        [_readyNode runAction:action forKey:@"" completionHandler:^{
            SCNAction *delayAction = [SCNAction waitForDuration:0.5];
            [self.scene.rootNode runAction:delayAction completionHandler:^{
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self playCountDownAnimation:3];
                });
                
            }];
//            [self.gameDelegate startGamingRecord];              //ready动画结束后开始录制
        }];
        [self.scene.rootNode addChildNode:_readyNode];
    }
}

//播放倒计时动画
-(void)playCountDownAnimation:(int) number
{
    NSString *imageName =[NSString stringWithFormat:@"ready%d.png",number];
    UIImage *image = [ImageUtil loadImageWithDir:@"ready" WithName:imageName];
    CGSize size = image.size;
    
    SCNAction *action1 = [SCNAction scaleTo:1 duration:0.1];
    SCNAction *action2 = [SCNAction scaleTo:1.1 duration:0.6];
    SCNAction *countDownAlphaAction = [SCNAction customActionWithDuration:0.6 actionBlock:^(SCNNode * _Nonnull node, CGFloat elapsedTime) {
        node.opacity = 1- elapsedTime/0.6;
    }];
    SCNAction *countDownAction = [SCNAction sequence:@[action1,[SCNAction group:@[action2,countDownAlphaAction]]]];
    if(!_countDownNode)
    {
        SCNPlane *plane = [SCNPlane planeWithWidth:size.width*self.width/DESIGN_SCREEN_WIDTH height:size.height*self.height/DESIGN_SCREEN_HEIGHT];
        SCNMaterial *material = [SCNMaterial material];
        //material.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1,-1, 1), 0, 1, 0);
        //material.blendMode = SCNBlendModeAlpha;
        plane.firstMaterial = material;
        _countDownNode = [[SCNNode alloc]init];
        _countDownNode.scale = SCNVector3Zero;
        _countDownNode.geometry = plane;
        _countDownNode.position = SCNVector3Make(0,0,0);
        _countDownNode.renderingOrder = COUNTDOWN_NODE_RENDER_ORDER;
        [self.scene.rootNode addChildNode:_countDownNode];
    }
    _countDownNode.geometry.firstMaterial.diffuse.contents = image;
    _countDownNode.opacity = 1.0;
    [_countDownNode runAction:countDownAction completionHandler:^{
        if(number-1 > 0)
        {
            SCNAction *delayAction = [SCNAction waitForDuration:0.3];
            [self.scene.rootNode runAction:delayAction completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self playCountDownAnimation:number - 1];
                });
            }];
        }
        else if(number-1==0)
        {
            _countDownNode.paused = YES;
            SCNAction *delayAction = [SCNAction waitForDuration:0.3];
            [self.scene.rootNode runAction:delayAction completionHandler:^{
                //self.scene.rootNode.paused = YES;
                //[self changeToGameScene];
            }];
        }
    }];
    
    //1消失的时候ready消失
    if(number-1==0)
    {
        SCNAction *delayAction = [SCNAction waitForDuration:0.2];
        [self.scene.rootNode runAction:delayAction completionHandler:^{
            SCNAction *action = [SCNAction scaleTo:0 duration:0.2];
            [_readyNode runAction:action forKey:@""];
        }];
    }
}

@end
