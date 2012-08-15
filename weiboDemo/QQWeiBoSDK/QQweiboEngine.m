//
//  QQweiboEngine.m
//  weiboDemo
//
//  Created by 伟 李 on 12-4-23.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import "QQweiboEngine.h"
#import "QweiboSyncRequest.h"
//#import "Qweibo.h"
#import "NSURL+QAdditions.h"
#define QQWeiboAppKey			@"QQWeiboAppKey"
#define QQWeiboAppSecret		@"QQWeiboAppSecret"
#define QQWeiboAppTokenKey		@"QQWeiboAppTokenKey"
#define QQWeiboAPPTokenSecret	@"QQWeiboAPPTokenSecret"
#define VERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="
static QQweiboEngine * _sharedQQweiboEngine = nil;
@implementation QQweiboEngine
@synthesize qqWeiboappKey=_qqWeiboappKey;
@synthesize qqWeiboappSecret=_qqWeiboappSecret;
@synthesize qqWeibotokenKey=_qqWeibotokenKey;
@synthesize qqWeibotokenSecret=_qqWeibotokenSecret;
@synthesize qqWeiboverifier=_qqWeiboverifier;
@synthesize qqWeiboresponse=_qqWeiboresponse;
@synthesize loginDialog =_loginDialog;
@synthesize connection =_connection;
@synthesize responseData=_responseData;
-(id)init{
    
    self = [super init];
    if (self) {
        [self loadDefaultKey];
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
    [_loginDialog release];
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
    
    
       NSDictionary *params = [NSURL parseURLQueryString:aResponse];
   	self.qqWeibotokenKey = [params objectForKey:@"oauth_token"];
    self.qqWeibotokenSecret = [params objectForKey:@"oauth_token_secret"];
    
}

+(QQweiboEngine *)sharedQQweiboEngine
{
    @synchronized([QQweiboEngine class])  
    {  
        if (!_sharedQQweiboEngine)  
            _sharedQQweiboEngine = [[QQweiboEngine alloc] init];  
        
        return _sharedQQweiboEngine;  
    }  
    
    return nil;
}
-(BOOL)login{

    if (_qqWeibotokenKey && ![_qqWeibotokenKey isEqualToString:@""] && 
        _qqWeibotokenSecret&& ![_qqWeibotokenSecret isEqualToString:@""]) {
     NSLog(@"已经登录");
        return TRUE;
        
      
        
    } else {
        
        QweiboSyncRequest *api = [[[QweiboSyncRequest alloc] init] autorelease];
        NSString *retString = [api getRequestTokenWithConsumerKey:_qqWeiboappKey consumerSecret:_qqWeiboappSecret];
        NSLog(@"Get requestToken:%@", retString);
        
        [self parseTokenKeyWithResponse:retString];

        
        NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL, _qqWeibotokenKey];
        
        _loginDialog = [[TencentLoginView alloc] initWithURL:url
                                                      params:nil
                                                    delegate:self];
        _loginDialog.loginType=@"qqweibo";
        [_loginDialog show];
        return FALSE;
        
    }

}
- (void)authorizeVerfyCode:(TencentLoginView *)weibologinView didReceiveVerfyCode:(NSString *)code{

	QweiboSyncRequest *api = [[[QweiboSyncRequest alloc] init] autorelease];
    NSString *retString = [api getAccessTokenWithConsumerKey:_qqWeiboappKey
                                              consumerSecret:_qqWeiboappSecret
                                             requestTokenKey:_qqWeibotokenKey
                                          requestTokenSecret:_qqWeibotokenSecret
                                                      verify:code];
    NSLog(@"\nget access token:%@", retString);
    [self parseTokenKeyWithResponse:retString];
    [self saveDefaultKey];
    
    [_loginDialog dismissWithSuccess:YES animated:YES];

}
-(void)logout{
    
}

-(void)pubishMessage:(NSString*)messageConent{
    if ([self login]) {
        //asynchronous http request
        QweiboSyncRequest *api = [[[QweiboSyncRequest alloc] init] autorelease];
        
        self.connection	= [api publishMsgWithConsumerKey:_qqWeiboappKey 
                                          consumerSecret:_qqWeiboappSecret
                                          accessTokenKey:_qqWeibotokenKey 
                                       accessTokenSecret:_qqWeibotokenSecret
                                                 content:messageConent 
                                               imageFile: nil 
                                              resultType:RESULTTYPE_JSON 
                                                delegate:self];
    }
}

#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"%@",@"asdasd");
	[_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
		NSLog(@"%@",@"asdas22221");
	self.responseData = [NSMutableData data];
	NSLog(@"total = %d", [response expectedContentLength]);

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
		NSLog(@"%@",@"asdasd11111");
		
	self.qqWeiboresponse = [[[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding] autorelease];
	

	self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
			NSLog(@"%@",@"asdasd111wewerw11");
	self.qqWeiboresponse= [NSString stringWithFormat:@"connection error:%@", error];
	
	NSLog(@"%@",_qqWeiboresponse);
	self.connection = nil;
}


@end
