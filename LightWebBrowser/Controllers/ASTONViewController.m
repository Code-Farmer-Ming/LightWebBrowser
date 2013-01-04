//
//  ASTONViewController.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-19.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "ASTONViewController.h"
#import "LightWebView.h"

@interface ASTONViewController ()
    @property (strong, nonatomic)  LightWebView *webBrowser;
@property (strong, nonatomic)  UIScrollView *mainScrollView;
 
    
    @property (weak, nonatomic) IBOutlet UITextField *addressField;
    @property (weak, nonatomic) IBOutlet UIScrollView *webScrollView;

    @property (weak, nonatomic) IBOutlet UIButton *goButton;
 

    @property (weak, nonatomic) IBOutlet UIView *toolbar;

    - (IBAction)toTop:(UIBarButtonItem *)sender;

@end

@implementation ASTONViewController

#pragma mark uiwebview委托
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self updateAddress :request];
    return YES;
}
	
- (void)webViewDidStartLoad:(UIWebView *)webView{
 
  
  
                   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}


- (UIWebView *)webView:(UIWebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
    
    return sender;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.addressField.text = @"error";
}
#pragma mark 输入框委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self go  :self.goButton];
    return YES;
}
#pragma mark 可视化组件事件
- (IBAction)go:(UIButton *)sender {
  
    NSURL *url = [NSURL URLWithString: self.addressField.text];
    if (!url.scheme)
    {
        NSString* modifiedURLString = [NSString stringWithFormat:@"http://%@", self.addressField.text];
        url = [NSURL URLWithString:modifiedURLString];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webBrowser loadRequest:urlRequest];
}

-(IBAction)stop:(id)sender{
    
}
const float   PAGE_CONTENT_INSET = 16;

#pragma mark rootview委托
- (void)viewDidLoad
{
    [super viewDidLoad];
 
	// Do any additional setup after loading the view, typically from a nib.
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-PAGE_CONTENT_INSET, 44, self.view.frame.size.width+PAGE_CONTENT_INSET, self.view.frame.size.height) ];
     self.mainScrollView.contentSize =CGSizeMake(self.view.frame.size.width*2+2*PAGE_CONTENT_INSET,self.view.frame.size.height);
    self.mainScrollView.pagingEnabled = YES;
    self.webBrowser = [[LightWebView alloc] initWithFrame:CGRectMake(PAGE_CONTENT_INSET,0, self.view.frame.size.width,  self.view.frame.size.height)];
    self.webBrowser.multipleTouchEnabled = YES;
    self.webBrowser.scalesPageToFit = YES;
    self.webBrowser.scrollView.delegate= self;
    
    [self.webBrowser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baike.com"]] ] ;
    
    [self.mainScrollView addSubview:self.webBrowser];
       self.mainScrollView.backgroundColor =[UIColor brownColor];
    [self.view addSubview:self.mainScrollView];
 
          
//    self.mainScrollView.frame=CGRectMake(-PAGE_CONTENT_INSET, 44, self.view.frame.size.width+PAGE_CONTENT_INSET, self.view.frame.size.height);
//    UIWebView *u1 = [[UIWebView alloc] initWithFrame:CGRectMake(PAGE_CONTENT_INSET,0, self.view.frame.size.width,  self.view.frame.size.height)];
//    [u1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baike.com"]] ] ;
//    u1.multipleTouchEnabled = YES;
//    u1.scalesPageToFit = YES;
//
//    u1.backgroundColor =[UIColor redColor];
//  
//    [self.mainScrollView addSubview:u1];
//    u1 =nil;
//    u1=  [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.size.width+2*PAGE_CONTENT_INSET,0, self.view.frame.size.width,  self.view.frame.size.height)];
//    u1.backgroundColor= [	UIColor blueColor];
//    
//    [u1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]] ] ;
//    u1.multipleTouchEnabled = YES;
//    u1.scalesPageToFit = YES;
//   
//      [self.mainScrollView addSubview:u1];
//    self.mainScrollView.contentSize =CGSizeMake(self.view.frame.size.width*2+2*PAGE_CONTENT_INSET,self.view.frame.size.height);
//     self.mainScrollView.backgroundColor =[UIColor brownColor];
//     u1=nil;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    if (scrollView.contentOffset.y>=0 && scrollView.contentOffset.y<= self.toolbar.frame.size.height)
    {
        [self.toolbar setFrame:CGRectMake(0,-scrollView.contentOffset.y, self.toolbar.frame.size.width,self.toolbar.frame.size.height)] ;
        float yy = self.toolbar.frame.size.height-scrollView.contentOffset.y;;

        if (yy<0)
            yy =0;
                     [self.mainScrollView setFrame:CGRectMake(0,yy, self.mainScrollView.frame.size.width,self.mainScrollView.frame.size.height)] ;
    }
  
    NSLog(@"x %f y %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 私有方法
- (void) updateAddress:(NSURLRequest*)request
{
    NSURL* url = [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    self.addressField.text = absoluteString;
}
- (IBAction)toTop:(UIBarButtonItem *)sender {
    [self.webScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}
@end
