//
//  Photos.m
//  PhotoObj
//
//  Created by pengxiuxiu on 16/7/28.
//  Copyright © 2016年 pengxiuxiu. All rights reserved.
//

#import "Photos.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation Photos

+ (void)sendValueToViewController:(SendValue)value{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
    __block NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
    __block NSArray *timeArr = [[NSArray alloc]init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    
                    //获得相片的时间
                    NSDate *timeStr = [result valueForProperty:ALAssetPropertyDate];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"YYYY-MM-dd"];
                    NSString *dateStr = [formatter stringFromDate:timeStr];
                    
                    //把对应时间的照片存入同一个数组中，再存入字典中，时间做key
                    if (!imageDic[dateStr]) {
                        imageDic[dateStr] = [NSMutableArray array];
                    }
                    [imageDic[dateStr] addObject:result];
                }
            }];
            
            //拍照时间按正序
            timeArr = [[imageDic allKeys]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSDate *date1 = obj1;
                NSDate *date2 = obj2;
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedDescending;
            }];
            value(imageDic,timeArr,assetsLibrary);
            
        }
    } failureBlock:^(NSError *error) {
        
    }];

}

@end
