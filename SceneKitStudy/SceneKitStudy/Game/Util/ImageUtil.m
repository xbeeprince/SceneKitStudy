//
//  ImageUtil.m
//  MoneyScrollAnimationKit
//
//  Created by prince on 2017/12/12.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "ImageUtil.h"
#include <sys/stat.h>

@implementation ImageUtil

+(UIImage *)loadImageWithDir:(NSString *)dir WithName:(NSString *)name
{
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [NSString stringWithFormat: @"resource/%@/%@",dir,name];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent: path];
    return [self loadImageWithPath:imagePath];
}

+(UIImage *)loadDefaultImageWithName:(NSString *)name
{
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [NSString stringWithFormat: @"resource/default/%@",name];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent: path];
    return [self loadImageWithPath:imagePath];
}

+(UIImage *)loadImageWithPath:(NSString *)imagePath
{
    NSArray* replaceStr = @[@"@3x",@"@2x"];
    int scale = 3;
    NSMutableString *tStr = [NSMutableString stringWithString:imagePath];
    [tStr insertString: [replaceStr objectAtIndex:0] atIndex:tStr.length - 4];
    if ([self canReadImage: tStr] == NO) {
        scale = 2;
        tStr = [NSMutableString stringWithString:imagePath];
        [tStr insertString: [replaceStr objectAtIndex:1] atIndex:tStr.length - 4];
        if ([self canReadImage: tStr] == NO) {
            scale = 1;
            tStr = [NSMutableString stringWithString:imagePath];
        }
    }
    NSData* data = [NSData dataWithContentsOfFile:tStr];
    UIImage *image = nil;
    if(data){
        image = [UIImage imageWithData:data scale:scale];
    }
    
    return image;
}

+(BOOL)canReadImage:(NSString*)path
{
    struct stat st;
    if(lstat([path cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return 0 != st.st_size;
    }
    return NO;
}

@end
