//
//  weibologinViewController.h
//  weiboDemo
//
//  Created by 伟 李 on 12-4-20.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import <UIKit/UIKit.h>
@class weibologinViewController;
@protocol WBAuthorizeControllerDelegate <NSObject>

- (void)authorizeController:(weibologinViewController *)weibologinViewController didReceiveAuthorizeCode:(NSString *)code;

@end
@interface weibologinViewController : UIViewController<UIWebViewDelegate> 
{
 UIActivityIndicatorView *indicatorView;
	UIWebView *webView;
    
    UIInterfaceOrientation previousOrientation;
    
    id<WBAuthorizeControllerDelegate> delegate;
}

@property (nonatomic, assign) id<WBAuthorizeControllerDelegate> delegate;

- (void)loadRequestWithURL:(NSURL *)url;

@end
