//
//  WeiboBasicUserInfo.h
//  weiboDemo
//
//  Created by 伟 李 on 12-4-23.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboBasicUserInfo : NSObject

@property (nonatomic, copy) NSString *qqWeiboappKey;
@property (nonatomic, copy) NSString *qqWeiboappSecret;
@property (nonatomic, copy) NSString *qqWeibotokenKey;
@property (nonatomic, copy) NSString *qqWeibotokenSecret;
@property (nonatomic, copy) NSString *qqWeiboverifier;
@property (nonatomic, copy) NSString *qqWeiboresponse;

- (void)parseTokenKeyWithResponse:(NSString *)response;
- (void)saveDefaultKey;
+(WeiboBasicUserInfo *)sharedWeiboBasicUserInfo;
@end
