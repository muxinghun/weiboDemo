//
//  weibologinViewController.m
//  weiboDemo
//
//  Created by 伟 李 on 12-4-20.
//  Copyright (c) 2012年 搜房网. All rights reserved.
//

#import "weibologinViewController.h"
//#import "QWeiboSyncApi.h"
#import "WeiboBasicUserInfo.h"
//#import "QWeiboSyncApi.h"
@interface weibologinViewController (Private)





@end

@implementation weibologinViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
//    webView.scalesPageToFit = YES;
//    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [webView setDelegate:self];
    [self.view addSubview:webView];
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 240)];
    [self.view addSubview:indicatorView];
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
#pragma mark Actions

- (void)onCloseButtonTouched:(id)sender
{
[self.parentViewController  dismissModalViewControllerAnimated:YES];
}

#pragma mark - WBAuthorizeWebView Public Methods

- (void)loadRequestWithURL:(NSURL *)url
{
    NSURLRequest *request =[NSURLRequest requestWithURL:url
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                        timeoutInterval:60.0];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
	[indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
	[indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error
{
    [indicatorView stopAnimating];
}
#pragma mark -
#pragma mark private methods

-(NSString*) valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@",request.URL.absoluteString);
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    
    if (range.location != NSNotFound)
    {
        NSString *code = [request.URL.absoluteString substringFromIndex:range.location + range.length];
        
        if ([delegate respondsToSelector:@selector(authorizeController:didReceiveAuthorizeCode:)])
        {
            [delegate authorizeController:self didReceiveAuthorizeCode:code];
        }
    }
    
    
//    NSString *query = [[request URL] query];
//	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query];
//	
//	if (verifier && ![verifier isEqualToString:@""]) {
//		
//		
//		WeiboBasicUserInfo *userInfo = [WeiboBasicUserInfo sharedWeiboBasicUserInfo];
//        
//		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
//		NSString *retString = [api getAccessTokenWithConsumerKey:userInfo.qqWeiboappKey 
//												  consumerSecret:userInfo.qqWeiboappSecret
//												 requestTokenKey:userInfo.qqWeibotokenKey
//											  requestTokenSecret:userInfo.qqWeibotokenSecret
//														  verify:verifier];
//		NSLog(@"\nget access token:%@", retString);
//		[userInfo parseTokenKeyWithResponse:retString];
//		[userInfo saveDefaultKey];
//		
//        NSLog(@"%@",@"成功登录");
//		
//		return NO;
//	}
	
	return YES;

//    return YES;
}

- (void)dealloc
{
   
    [webView release], webView = nil;

    [indicatorView release] ,indicatorView =nil;
    [super dealloc];
}

@end
