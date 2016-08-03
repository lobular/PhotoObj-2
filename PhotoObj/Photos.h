//
//  Photos.h
//  PhotoObj
//
//  Created by pengxiuxiu on 16/7/28.
//  Copyright © 2016年 pengxiuxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^SendValue)(NSDictionary *dataDic,NSArray *timeArr,ALAssetsLibrary *assetsLibrary);

@interface Photos : NSObject

@property (nonatomic,strong)ALAssetsLibrary *assetLibrary;

+ (void)sendValueToViewController:(SendValue)value;

@end
