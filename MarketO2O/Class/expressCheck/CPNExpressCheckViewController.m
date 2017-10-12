//
//  CPNExpressCheckViewController.m
//  MarketO2O
//
//  Created by phh on 2017/10/12.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNExpressCheckViewController.h"
#import <WebKit/WebKit.h>

@interface CPNExpressCheckViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, copy)NSString *expressId;
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)NSURL *url;


@end

@implementation CPNExpressCheckViewController


- (id)initWithExpressId:(NSString *)expressid
{
    if (self = [self init]) {
        if (expressid) {
            self.expressId = expressid;
            
        }
    }
    return self;
}

- (void)loadWebPage
{
    if (!self.webView)
    {
        [self initWKWebView];
        self.url = [NSURL URLWithString:[NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=yunda&postid=%@", self.expressId]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30]];
    }else
    {
        [self.webView reload];
    }
    
}

-(void)initWKWebView
{
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.allowsBackForwardNavigationGestures =YES;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    self.webView = webView;
    webView.scrollView.delegate = (id<UIScrollViewDelegate>)self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebPage];
    // Do any additional setup after loading the view.
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self deleteAD];
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
    [self deleteAD];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    [self deleteAD];
    //    [self resetControl];
    //    if (webView.title.length > 0) {
    //        self.title = webView.title;
    //    }
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    
    NSLog(@"didFailProvisionalNavigation");
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSLog(@"4.%@",navigationAction.request);
    decisionHandler(WKNavigationActionPolicyAllow);
    [self deleteAD];
    
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    if( navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    completionHandler(@"Client Not handler");
    
}
- (void)deleteAD
{
    [self.webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('adsbygoogle')[0].style.display = 'none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('smart-return-btn ui-btn-left ui-btn ui-btn-up-a ui-shadow ui-btn-corner-all')[0].style.display = 'none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('smart-header ui-header ui-bar-a ui-header-fixed slidedown')[0].style.display = 'none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.body.removeChild(document.getElementByClassName('smart-header ui-header ui-bar-a ui-header-fixed slidedown')" completionHandler:nil];
}

///判断当前加载的url是否是WKWebView不能打开的协议类型
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL *)url
{
    BOOL retValue = NO;
    
    return retValue;
}





@end
