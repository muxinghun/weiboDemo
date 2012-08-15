//
//  QQweiboEngine.h
//  weiboDemo
//
//  Created by 伟 李 on 12-4-23.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentLoginView.h"
@interface QQweiboEngine : NSObject<TencentLoginViewDelegate>
@property (nonatomic, copy) NSString *qqWeiboappKey;
@property (nonatomic, copy) NSString *qqWeiboappSecret;
@property (nonatomic, copy) NSString *qqWeibotokenKey;
@property (nonatomic, copy) NSString *qqWeibotokenSecret;
@property (nonatomic, copy) NSString *qqWeiboverifier;
@property (nonatomic, copy) NSString *qqWeiboresponse;
@property(nonatomic,retain) TencentLoginView * loginDialog;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,retain)NSMutableData *responseData;	

- (void)parseTokenKeyWithResponse:(NSString *)response;
- (void)saveDefaultKey;
+(QQweiboEngine *)sharedQQweiboEngine;
-(BOOL)login;
-(void)logout;
-(void)pubishMessage:(NSString*)messageConent;
@end
