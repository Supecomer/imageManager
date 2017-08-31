//
//  CIImageManager.h
//  CIImageManager
//
//  Created by ciome on 2017/8/24.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CIImageType) {
    enum_imageType_normal,
    enum_imageType_highlight
};


@interface CIImageManager : NSObject

/**
 highlight color ,default is  cleanColor
 */
@property (nonatomic,strong) UIColor  *highlightColor;

/**
 blend mode ,default is kCGBlendModeDestinationIn
 */
@property (nonatomic,assign) CGBlendMode  blendMode;

/**
 max cache image  count,default is 100
 */
@property (nonatomic,assign) NSInteger   maxCacheImageCount;

/**
 remove cache image count, defautl is 10
 */
@property (nonatomic,assign) NSInteger   removeCacheImageCount;


+(CIImageManager *)getInstance;

/**
 release cache image  ，in front

 @param count  count
 */
- (void)releaseCacheImage:(NSInteger)count;

/**
 release all cache image
 */
- (void)releaseAllCacheImage;


@end


@interface UIImage (CIDefine)

+(UIImage *)imageNamed:(NSString *)name withImageType:(CIImageType)type;

@end




