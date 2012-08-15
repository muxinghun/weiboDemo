//
//  WeiboBasicUserInfo.m
//  weiboDemo
//
//  Created by 伟 李 on 12-4-23.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import "WeiboBasicUserInfo.h"
//#import "Qweibo.h"
#define QQWeiboAppKey			@"QQWeiboAppKey"
#define QQWeiboAppSecret		@"QQWeiboAppSecret"
#define QQWeiboAppTokenKey		@"QQWeiboAppTokenKey"
#define QQWeiboAPPTokenSecret	@"QQWeiboAPPTokenSecret"

static WeiboBasicUserInfo * _sharedWeiboBasicUserInfo = nil;
@implementation WeiboBasicUserInfo
@synthesize qqWeiboappKey=_qqWeiboappKey;
@synthesize qqWeiboappSecret=_qqWeiboappSecret;
@synthesize qqWeibotokenKey=_qqWeibotokenKey;
@synthesize qqWeibotokenSecret=_qqWeibotokenSecret;
@synthesize qqWeiboverifier=_qqWeiboverifier;
@synthesize qqWeiboresponse=_qqWeiboresponse;

-(id)init{

    self = [super init];
    if (self) {
        [self loadDefaultKey  ];
        self.qqWeiboappKey = @"801092980";
        self.qqWeiboappSecret = @"232010c231c27e3cb6d76ced4988e1e7";
    }
    return self;
}


- (void)dealloc {
	
	[_qqWeiboappKey release];
	[_qqWeiboappSecret release];
	[_qqWeibotokenKey release];
	[_qqWeibotokenSecret release];
	[_qqWeiboverifier release];
    [_qqWeiboresponse release];

    [super dealloc];
}

- (void)saveDefaultKey {
	
	[[NSUserDefaults standardUserDefaults] setValue:self.qqWeiboappKey forKey:QQWeiboAppKey];
	[[NSUserDefaults standardUserDefaults] setValue:self.qqWeiboappSecret forKey:QQWeiboAppSecret];
	[[NSUserDefaults standardUserDefaults] setValue:self.qqWeibotokenKey forKey:QQWeiboAppTokenKey];
	[[NSUserDefaults standardUserDefaults] setValue:self.qqWeibotokenSecret forKey:QQWeiboAPPTokenSecret];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark -
#pragma mark private methods

- (void)loadDefaultKey {
	
	self.qqWeiboappKey = [[NSUserDefaults standardUserDefaults] valueForKey:QQWeiboAppKey];
	self.qqWeiboappSecret = [[NSUserDefaults standardUserDefaults] valueForKey:QQWeiboAppSecret];
	self.qqWeibotokenKey = [[NSUserDefaults standardUserDefaults] valueForKey:QQWeiboAppTokenKey];
	self.qqWeibotokenSecret = [[NSUserDefaults standardUserDefaults] valueForKey:QQWeiboAPPTokenSecret];
}


- (void)parseTokenKeyWithResponse:(NSString *)aResponse{

//
//    NSDictionary *params = [NSURL parseURLQueryString:aResponse];
//	self.qqWeibotokenKey = [params objectForKey:@"oauth_token"];
//	self.qqWeibotokenSecret = [params objectForKey:@"oauth_token_secret"];

}

+(WeiboBasicUserInfo *)sharedWeiboBasicUserInfo
{
    @synchronized([WeiboBasicUserInfo class])  
    {  
        if (!_sharedWeiboBasicUserInfo)  
            _sharedWeiboBasicUserInfo = [[WeiboBasicUserInfo alloc] init];  
        
        return _sharedWeiboBasicUserInfo;  
    }  
    
    return nil;
}

@end
