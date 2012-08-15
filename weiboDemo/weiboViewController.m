//
//  weiboViewController.m
//  weiboDemo
//
//  Created by 伟 李 on 12-4-20.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import "weiboViewController.h"

#import "QQweiboEngine.h"

//#import "QWeiboSyncApi.h"
//#import "QWeiboSyncApi.h"

#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101
#define QQWEIBOVERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="

@interface weiboViewController ()

@end

@implementation weiboViewController
@synthesize weiBoEngine=_weiBoEngine;
@synthesize tencentOAuth=_tencentOAuth;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)QQweibologin{
    QQweiboEngine * qweiboEngine = [QQweiboEngine sharedQQweiboEngine];

    [qweiboEngine pubishMessage:@"liweiceshi"];
}
-(void)weibologin{
    NSLog(@"%@",@"微博登录");
    [_weiBoEngine sendWeiBoWithText:@"ceshiliwei" image:nil];

}
-(void)weibologout{
 NSLog(@"%@",@"微博退出");
    [ _weiBoEngine logOut];

}
-(void)QQlogin{
      NSLog(@"%@",@"QQ登录");
[_tencentOAuth authorize:_permissions inSafari:NO];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
    
    _permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share",@"add_idol",nil] retain];
	
	
	_tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100245148"
											andDelegate:self];
	_tencentOAuth.redirectURI = @"www.qq.com";

    
    
	UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //创建圆角矩形button
	[weiboButton setFrame:CGRectMake(10, 10, 80, 30)]; //设置button的frame
	[weiboButton setTitle:@"新浪微博" forState:UIControlStateNormal]; //设置button的标题
	[weiboButton addTarget:self action:@selector(weibologin) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
	[self.view addSubview:weiboButton]; //添加到view
    
    UIButton *weiboButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //创建圆角矩形button
	[weiboButton1 setFrame:CGRectMake(10, 40, 80, 30)]; //设置button的frame
	[weiboButton1 setTitle:@"新浪微博退出" forState:UIControlStateNormal]; //设置button的标题
	[weiboButton1 addTarget:self action:@selector(weibologout) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
	[self.view addSubview:weiboButton1]; //添加到view
    

    
    UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //创建圆角矩形button
	[qqButton setFrame:CGRectMake(150, 10, 100, 30)]; //设置button的frame
	[qqButton setTitle:@"QQ开放平台" forState:UIControlStateNormal]; //设置button的标题
	[qqButton addTarget:self action:@selector(QQlogin) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
	[self.view addSubview:qqButton]; //添加到view
    
    
    UIButton *qqweiboButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //创建圆角矩形button
	[qqweiboButton setFrame:CGRectMake(150, 50, 100, 30)]; //设置button的frame
	[qqweiboButton setTitle:@"QQ微博" forState:UIControlStateNormal]; //设置button的标题
	[qqweiboButton addTarget:self action:@selector(QQweibologin) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
	[self.view addSubview:qqweiboButton]; //添加到view

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
//    [indicatorView stopAnimating];
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                           message:@"请先登出！" 
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定" 
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
//    [indicatorView stopAnimating];
    NSLog(@"新浪openid%@",engine.userID);

//    [self verfiyOpenidRequest];
    
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
//    [indicatorView stopAnimating];
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录失败！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登出成功！" 
													  delegate:self
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
	[alertView release];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    NSLog(@"%@",@"sdfsd!!!!!!");
    [_weiBoEngine logIn];
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"请重新登录！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}


- (void)tencentDidLogin {
	// 登录成功
    NSLog(@"%@", @"token获取成功");
    
    //    UTXAccountUserIDAndInfo * mUserIDAndInfo = [UTXAccountUserIDAndInfo sharedUTXAccountUserIDAndInfo];
    //    mUserIDAndInfo.qqopenid =_tencentOAuth.openId;
    //    mUserIDAndInfo.loginType=1;
    //    
    NSLog(@"腾讯openid%@",_tencentOAuth.openId);

  	
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
        NSLog(@"%@", @"用户取消登录");
	}
	else {
        NSLog(@"%@", @"登录失败");
	}
	
}


-(void)dealloc{

    [_permissions release];
    [_tencentOAuth release];
    [super dealloc];
}
@end
