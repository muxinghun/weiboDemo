//
//  weiboViewController.h
//  weiboDemo
//
//  Created by 伟 李 on 12-4-20.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "TencentOAuth.h"
#import "TencentLoginView.h"
@interface weiboViewController : UIViewController<WBEngineDelegate,WBRequestDelegate,TencentSessionDelegate,TencentLoginViewDelegate>{

    TencentOAuth* _tencentOAuth;
    
	NSMutableArray* _permissions; 
}

@property(nonatomic,retain) WBEngine *weiBoEngine;
@property(nonatomic,retain) TencentOAuth *tencentOAuth;

@end
