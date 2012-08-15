//
//  QweiboSyncRequest.h
//  weiboDemo
//
//  Created by 伟 李 on 12-4-23.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ResultType {
	
	RESULTTYPE_XML, RESULTTYPE_JSON
	
}ResultType;

typedef enum _PageFlag {
	
	PAGEFLAG_FIRST, 
	PAGEFLAG_NEXT, 
	PAGEFLAG_LAST
	
}PageFlag;

@interface QweiboSyncRequest : NSObject
//Get request token
- (NSString *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret;

//Get access token
- (NSString *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify;

//Request timeline messages.
- (NSString *)getHomeMsgWithConsumerKey:(NSString *)aConsumerKey
						 consumerSecret:(NSString *)aConsumerSecret 
						 accessTokenKey:(NSString *)aAccessTokenKey 
					  accessTokenSecret:(NSString *)aAccessTokenSecret 
							 resultType:(ResultType)aResultType 
							  pageFlage:(PageFlag)aPageFlag 
								nReqNum:(NSInteger)aReqNum;

//Publish a message w/ or w/o image.
- (NSString *)publishMsgWithConsumerKey:(NSString *)aConsumerKey 
						 consumerSecret:(NSString *)aConsumerSecret 
						 accessTokenKey:(NSString *)aAccessTokenKey 
					  accessTokenSecret:(NSString *)aAccessTokenSecret 
								content:(NSString *)aContent 
							  imageFile:(NSString *)aImageFile 
							 resultType:(ResultType)aResultType;

- (NSURLConnection *)getHomeMsgWithConsumerKey:(NSString *)aConsumerKey
                                consumerSecret:(NSString *)aConsumerSecret 
                                accessTokenKey:(NSString *)aAccessTokenKey 
                             accessTokenSecret:(NSString *)aAccessTokenSecret 
                                    resultType:(ResultType)aResultType 
                                     pageFlage:(PageFlag)aPageFlag 
                                       nReqNum:(NSInteger)aReqNum 
                                      delegate:(id)aDelegate;

- (NSURLConnection *)publishMsgWithConsumerKey:(NSString *)aConsumerKey 
                                consumerSecret:(NSString *)aConsumerSecret 
                                accessTokenKey:(NSString *)aAccessTokenKey 
                             accessTokenSecret:(NSString *)aAccessTokenSecret 
                                       content:(NSString *)aContent 
                                     imageFile:(NSString *)aImageFile 
                                    resultType:(ResultType)aResultType 
                                      delegate:(id)aDelegate;


@end
