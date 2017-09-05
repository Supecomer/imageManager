//
//  CIImageManager.m
//  CIImageManager
//
//  Created by ciome on 2017/8/24.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "CIImageManager.h"


@interface CIImageUnit : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) CIImageType type;
@property (nonatomic,strong) UIColor  *color;
@property (nonatomic,assign) CGBlendMode  blendMode;
@property (nonatomic,strong) UIImage *image;

- (BOOL)isEqual:(id)object;


@end


@implementation CIImageUnit
@synthesize name = _name;
@synthesize type = _type;
@synthesize image = _image;
@synthesize color = _color;
@synthesize blendMode = _blendMode;

- (instancetype)init
{
    if (self = [super init])
    {
        _image = nil;
        _type = enum_imageType_normal;
        _name = nil;
        _blendMode = -1;
        _color = nil;
        
    }
    return self;
}


- (BOOL)isEqual:(id)object
{
    CIImageUnit  *unit = object;
    BOOL isEqual = true;
    if (![self.name isEqualToString:unit.name] || (self.type != self.type) || (self.color !=_color)|| (self.blendMode !=_blendMode))
    {
        isEqual = false;
    }
    
    return isEqual;
}



@end





@interface CIImageManager ()

@property (nonatomic,strong) NSMutableArray<CIImageUnit *>  *imageCacheAry;
- (UIImage *)getImageByName:(NSString *)name withImageType:(CIImageType)type;

@end


@implementation CIImageManager
@synthesize highlightColor = _highlightColor;
@synthesize maxCacheImageCount = _maxCacheImageCount;
@synthesize removeCacheImageCount = _removeCacheImageCount;
@synthesize blendMode = _blendMode;


+(CIImageManager *)getInstance
{
    static CIImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CIImageManager alloc] init];
    });
    return manager;
}


- (instancetype)init
{
    if (self = [super init]) {
        _imageCacheAry = [[NSMutableArray alloc] initWithCapacity:1];
        _highlightColor = [UIColor clearColor];
        _blendMode = kCGBlendModeDestinationIn;
        _maxCacheImageCount = 100;
        _removeCacheImageCount = 10;
    }
    return self;
}


- (UIImage *)getImageByName:(NSString *)name withImageType:(CIImageType)type
{
    if (!name)
    {
        return nil;
    }
    if (type != enum_imageType_highlight)
    {
        return nil;
    }
     __block  UIImage *im = nil;
    [_imageCacheAry enumerateObjectsUsingBlock:^(CIImageUnit * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj.name isEqualToString:name]&&obj.type == type && obj.color == _highlightColor && obj.blendMode == _blendMode)
        {
            im = obj.image;
            // 将最新用到图片，移到数组末尾
            [_imageCacheAry removeObject:obj];
            [_imageCacheAry addObject:obj];
            *stop = YES;
        }
    }];
    if (!im)
    {
        UIImage *n_im = [UIImage  imageNamed:name];
 
        im = [n_im imageWithTintColor:_highlightColor blendMode:_blendMode];
        CIImageUnit *unit = [[CIImageUnit alloc] init];
        unit.image = im;
        unit.name = name;
        unit.type = type;
        unit.color = _highlightColor;
        unit.blendMode = _blendMode;
        [_imageCacheAry addObject:unit];
        if (_imageCacheAry.count > _maxCacheImageCount) {
            
            [self  releaseCacheImage:_removeCacheImageCount];
        }
    }
    return im;
}


- (void)releaseCacheImage:(NSInteger)count
{
    if (count >= _imageCacheAry.count)
    {
        [_imageCacheAry removeAllObjects];
    }
    else
    {
      [_imageCacheAry removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)]];
    }
}


- (void)releaseAllCacheImage
{
   [_imageCacheAry removeAllObjects];
}



@end


@implementation UIImage(CIDefine)

+(UIImage *)imageNamed:(NSString *)name withImageType:(CIImageType)type
{
    UIImage  *im = nil;
    switch (type) {
        case enum_imageType_normal:
            im = [UIImage imageNamed:name];
            break;
        case enum_imageType_highlight:
            im = [[CIImageManager getInstance] getImageByName:name withImageType:type];
            break;
        default:
            break;
    }
    
    return im;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}


- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}


- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn)
    {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
