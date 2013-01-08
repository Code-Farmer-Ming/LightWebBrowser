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
{
    LightWebView *webBrowser;
    UIScrollView *mainScrollView;
    NSMutableArray *thumbArrary;
    int currentPageIndex;
}
    @property (weak, nonatomic) IBOutlet UIButton *reload;
    
    @property (weak, nonatomic) IBOutlet UIButton *go;
   
    @property (weak, nonatomic) IBOutlet UIButton *stop;

    @property (weak, nonatomic) IBOutlet UITextField *addressField;
    @property (weak, nonatomic) IBOutlet UIScrollView *webScrollView;

    @property (weak, nonatomic) IBOutlet UIButton *back;

    @property (weak, nonatomic) IBOutlet UIButton *forward;
 

    @property (weak, nonatomic) IBOutlet UIView *toolbar;

    

@end



@implementation ASTONViewController
const float   PAGE_CONTENT_INSET = 16;
const float   TOOLBAR_HEIGHT = 44;

#pragma mark rootview委托
- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPageIndex =-1;
	// Do any additional setup after loading the view, typically from a nib.
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-PAGE_CONTENT_INSET,TOOLBAR_HEIGHT, self.view.frame.size.width+PAGE_CONTENT_INSET, self.view.frame.size.height) ];
    mainScrollView.contentSize =CGSizeMake((self.view.frame.size.width+PAGE_CONTENT_INSET),self.view.frame.size.height);
    mainScrollView.pagingEnabled = YES;
    webBrowser = [[LightWebView alloc] initWithFrame:CGRectMake(PAGE_CONTENT_INSET,0, self.view.frame.size.width,  self.view.frame.size.height)];
    webBrowser.multipleTouchEnabled = YES;
    webBrowser.scalesPageToFit = YES;
    webBrowser.scrollView.delegate= self;
    webBrowser.delegate =self;
    
    [mainScrollView addSubview:webBrowser];
    mainScrollView.backgroundColor =[UIColor brownColor];
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
    //    [webBrowser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baike.com"]] ] ;
    
    
    UIView *thumbImage;
    for (int i=1; i<4; i++) {
        thumbImage = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width +PAGE_CONTENT_INSET)*(i-1)+PAGE_CONTENT_INSET,0, self.view.frame.size.width,  self.view.frame.size.height)];
        thumbImage.tag = i;
        thumbImage.backgroundColor = [UIColor whiteColor];
        thumbImage.hidden = YES;
        [mainScrollView addSubview:thumbImage];
    }
    //    thumbImage = nil;
    [self updateButtons];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark scrollview委托
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float yy= scrollView.contentOffset.y;
    if (scrollView.contentOffset.y>self.toolbar.frame.size.height)
        yy = self.toolbar.frame.size.height;
    [self.toolbar setFrame:CGRectMake(0,-yy, self.toolbar.frame.size.width,self.toolbar.frame.size.height)] ;
    [mainScrollView setFrame:CGRectMake(mainScrollView.frame.origin.x,self.toolbar.frame.size.height-yy, mainScrollView.frame.size.width,mainScrollView.frame.size.height+self.toolbar.frame.size.height-yy)] ;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = floor((scrollView.contentOffset.x - self.view.frame.size.width / 2) / self.view.frame.size.width) + 1;
    int relativePageIndex = currentPageIndex % 3;
    if (page==relativePageIndex) {
        return;
    }
    if (page<relativePageIndex){
               [webBrowser goBack];
        currentPageIndex--;
        
    }
    else
    {
           [webBrowser goForward];
              currentPageIndex++;
    }
    [mainScrollView viewWithTag:relativePageIndex+1].hidden= NO;
    webBrowser.frame =CGRectMake((self.view.frame.size.width +PAGE_CONTENT_INSET) *page+PAGE_CONTENT_INSET, 0, self.view.frame.size.width, self.view.frame.size.height);
    

}
#pragma mark uiwebview委托
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self updateAddress :request];
   
     if ([thumbArrary count]> currentPageIndex) {
        [thumbArrary removeObjectsInRange:NSMakeRange(currentPageIndex+1, 999)];
    }
    
        currentPageIndex++;
        [thumbArrary addObject:[[request URL] absoluteString]];
    int lastPageIndex = currentPageIndex;
    if (lastPageIndex>2) lastPageIndex =2;
    
    
    mainScrollView.contentSize = CGSizeMake((self.view.frame.size.width +PAGE_CONTENT_INSET) *(lastPageIndex+1), self.view.frame.size.height);
    
    webBrowser.frame = CGRectMake((self.view.frame.size.width +PAGE_CONTENT_INSET) *lastPageIndex+PAGE_CONTENT_INSET, 0, self.view.frame.size.width, self.view.frame.size.height);
    [mainScrollView viewWithTag:lastPageIndex].hidden= NO;
    
    [mainScrollView scrollRectToVisible:CGRectMake((self.view.frame.size.width +PAGE_CONTENT_INSET) *lastPageIndex+PAGE_CONTENT_INSET, 0, self.view.frame.size.width+PAGE_CONTENT_INSET, self.view.frame.size.height) animated:NO];
    
     return YES;
}
	
- (void)webViewDidStartLoad:(UIWebView *)webView{
   [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self updateButtons];
    [mainScrollView bringSubviewToFront:webView];
}


- (UIWebView *)webView:(UIWebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
    
    return sender;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self updateButtons];
}
#pragma mark 输入框委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self go  :nil];
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
    [webBrowser loadRequest:urlRequest];
}

- (IBAction)reload:(id)sender {
    [webBrowser reload];
}
 

-(IBAction)stop:(id)sender{
    [webBrowser stopLoading];
}

- (IBAction)goback:(UIButton *)sender {
    [webBrowser goBack];
}

- (IBAction)forWard:(UIButton *)sender {
    [webBrowser goForward];
}




#pragma mark 私有方法
-(void) updateButtons
{
    self.forward.enabled = webBrowser.canGoForward;
    self.back.enabled = webBrowser.canGoBack;
    self.stop.hidden = !webBrowser.loading;
    self.reload.hidden = webBrowser.loading;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = webBrowser.loading;
}

- (void) updateAddress:(NSURLRequest*)request
{
    NSURL* url = [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    self.addressField.text = absoluteString;
}

@end
