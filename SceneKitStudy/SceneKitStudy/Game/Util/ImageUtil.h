//
//  ImageUtil.h
//  MoneyScrollAnimationKit
//
//  Created by prince on 2017/12/12.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define LoadDefaultImageWithName(imageName) [ImageUtil loadDefaultImageWithName:imageName]
@interface ImageUtil : NSObject
+(UIImage *)loadDefaultImageWithName:(NSString *)name;
+(UIImage *)loadImageWithDir:(NSString *)dir WithName:(NSString *)name;
@end
