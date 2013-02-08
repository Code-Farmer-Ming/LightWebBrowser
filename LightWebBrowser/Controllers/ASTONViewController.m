//
//  ASTONViewController.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-19.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "ASTONViewController.h"
#import "LightWebView.h"
#import "DirectoryHelper.h"
#import "NSString+toMD5.h"
#import "NSURLRequest+Extension.h"
#import "UIView+Extension.h"
#import "WebHistoryItem.h"
#import "WebBackForwardList.h"
#import "GoButton.h"
@interface ASTONViewController ()
{
    LightWebView *webBrowser;
    UIScrollView *mainScrollView;
    
    NSLayoutConstraint *webBrowserLeftConstraint;
}

    @property (weak, nonatomic) IBOutlet UIButton *reload;
    
    @property (weak, nonatomic) IBOutlet GoButton *go;
   
    @property (weak, nonatomic) IBOutlet UIButton *stop;

    @property (weak, nonatomic) IBOutlet UITextField *addressField;
    @property (weak, nonatomic) IBOutlet UIScrollView *webScrollView;

    @property (weak, nonatomic) IBOutlet UIButton *back;

    @property (weak, nonatomic) IBOutlet UIButton *forward;
 

    @property (weak, nonatomic) IBOutlet UIView *toolbar;
 
- (IBAction)textEditChanged:(UITextField *)sender;
- (IBAction)editBegin:(id)sender;
- (IBAction)editEnd:(id)sender;

@end



@implementation ASTONViewController
const float   PAGE_CONTENT_INSET = 18;
const float   TOOLBAR_HEIGHT = 44;

#pragma mark rootview委托
- (void)viewDidLoad
{
    [super viewDidLoad];
 
	// Do any additional setup after loading the view, typically from a nib.
    mainScrollView = [UIScrollView new];
    mainScrollView.translatesAutoresizingMaskIntoConstraints=NO;
    mainScrollView.pagingEnabled = YES;
    webBrowser = [LightWebView new];
    webBrowser.multipleTouchEnabled = YES;
    webBrowser.scalesPageToFit = YES;
    webBrowser.translatesAutoresizingMaskIntoConstraints =NO;
    webBrowser.scrollView.delegate= self;
    webBrowser.delegate =self;
    self.view.backgroundColor =[UIColor redColor];
    
    [mainScrollView addSubview:webBrowser];
    mainScrollView.backgroundColor =[UIColor brownColor];
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    //设置 scorllview的位置
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString  stringWithFormat:@"|-(-%f)-[mainScrollView]|",PAGE_CONTENT_INSET] options:0 metrics:nil views:NSDictionaryOfVariableBindings(mainScrollView)]];
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_toolbar(%f)][mainScrollView]|",TOOLBAR_HEIGHT ]  options:0 metrics:nil views:NSDictionaryOfVariableBindings(mainScrollView,_toolbar)]];
    
    [self.view addConstraints:tmpConstraints];
    UIButton *seach = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    self.addressField.rightViewMode = UITextFieldViewModeAlways;
    [self.addressField.rightView addSubview:self.go];
    [self.toolbar addSubview:seach];
    //    [webBrowser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baike.com"]] ] ;
 
  
    UIImageView *thumbImage;
    for (int i=1; i<4; i++) {
        thumbImage = [UIImageView new];
        thumbImage.tag = i;
        thumbImage.hidden= true;
        thumbImage.backgroundColor = [UIColor blueColor];
        thumbImage.translatesAutoresizingMaskIntoConstraints = NO;
        
        [mainScrollView addSubview:thumbImage];
        //设置 images的位置
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:i>1 ? [mainScrollView viewWithTag:i-1]: nil  attribute:NSLayoutAttributeRight multiplier:1.0 constant:PAGE_CONTENT_INSET]];
        
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-PAGE_CONTENT_INSET]];
        
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];

    }
    //设置webbrowser的位置
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:0]  attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: [mainScrollView viewWithTag:1]   attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    webBrowserLeftConstraint = [NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [mainScrollView addConstraint:webBrowserLeftConstraint];
    
    
    //    thumbImage = nil;
    [self updateButtons];

    NSLog(@"%@",mainScrollView.constraints);
 
   [self adjustScrollAndContent];
}
 
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self adjustScrollAndContent];
    [webBrowser bringToFront];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark scrollview委托
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==webBrowser.scrollView) {
        float yy= scrollView.contentOffset.y;
        if (scrollView.contentOffset.y>self.toolbar.frame.size.height)
        yy = self.toolbar.frame.size.height;
        [self.toolbar setFrame:CGRectMake(0,-yy, self.toolbar.frame.size.width,self.toolbar.frame.size.height)] ;
        [mainScrollView setFrame:CGRectMake(mainScrollView.frame.origin.x,self.toolbar.frame.size.height-yy, mainScrollView.frame.size.width,mainScrollView.frame.size.height+self.toolbar.frame.size.height-yy)] ;
        [self.view layoutSubviews];
    }
    else
    {
       
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     if (scrollView!=mainScrollView) {
        return;
    }
    int page =   floor(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSLog(@" current page %d ,actual page index %d",page, [self actualPageIndex]);
    int actualPageIndex = [self actualPageIndex];
    if (page==actualPageIndex) {
        return;
    }
    if (page<actualPageIndex){
       [webBrowser goBack];
    }
    else
    {
       [webBrowser goForward];
    }
}
#pragma mark uiwebview委托
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self updateAddress :request];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
   [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self updateButtons];
   
    
    [self adjustScrollAndContent] ;
//    WebBackForwardList*  backList = [webBrowser backForwardList];
    NSLog(@"finished");
//    NSLog(@"lenght %@",  [backList  currentItem]);
  

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    NSLog(@"错误 domain %@, code %d, localizedDescription %@,localizedFailureReason %@",[error domain],[error code],[error localizedDescription],[error localizedFailureReason]);

   if ([error code] != NSURLErrorCancelled)
   {
    [webBrowser loadHTMLString:[NSString stringWithFormat:@"<h1>%d</h1><h1>%@</h1>",[error code],[error localizedDescription]] baseURL:[NSURL URLWithString:@"about:blank"] ];
    }
    [self updateButtons];
    
    [self adjustScrollAndContent] ;
    
    }
#pragma mark 输入框委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self go  :nil];
    return YES;
}

#pragma mark 可视化组件事件
- (IBAction)go:(GoButton *)sender {
    switch (sender.currentType) {
        case GoBtuttonTypeGo:
            [webBrowser loadRequestFromString: self.addressField.text];
            break;
        case GoBtuttonTypeReload:
            [webBrowser reload];
            break;
        case GoBtuttonTypeStop:
            [webBrowser stopLoading];
            break;
        default:
//            [webBrowser stopLoading];
//查找
            break;
    }
    
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
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder

{
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.addressField.text forKey:@"<#string#>"];
    
}



-(void)decodeRestorableStateWithCoder:(NSCoder *)coder

{
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.addressField.text = [coder decodeObjectForKey:@"<#string#>"];
    
}
#pragma mark 私有方法
-(void)adjustScrollAndContent{
    
    int bound = [[webBrowser backForwardList] backListCount] + [[webBrowser backForwardList] forwardListCount]+1;
    int pageIndex= [self actualPageIndex];
    NSLog(@"当前页面 %@",webBrowser.backForwardList.currentItem);
    if (bound>3){
        bound= 3;
    }
 
    webBrowser.alpha = 0.0f;
    mainScrollView.contentSize = CGSizeMake((mainScrollView.frame.size.width) *bound, mainScrollView.frame.size.height);
    
    [mainScrollView removeConstraint:webBrowserLeftConstraint];
    UIView* currentPage = [mainScrollView viewWithTag:pageIndex+1];
    webBrowserLeftConstraint = [NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:currentPage  attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [mainScrollView addConstraint:webBrowserLeftConstraint];
    [mainScrollView updateConstraintsIfNeeded];
    
    [mainScrollView scrollRectToVisible: CGRectMake(currentPage.frame.origin.x-PAGE_CONTENT_INSET, currentPage.frame.origin.y, currentPage.frame.size.width+PAGE_CONTENT_INSET, currentPage.frame.size.height)  animated:NO];
    
    if (pageIndex>0) {
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex]).hidden=NO;
         ((UIImageView*)[mainScrollView viewWithTag:pageIndex]).image= [UIImage imageWithContentsOfFile:[webBrowser  captureFilePath:[[[[webBrowser backForwardList] backItem] URLString] toMD5]]];
    }
    if (bound>(pageIndex+1)) {
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex+2]).hidden=NO;
 
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex+2]).image = [UIImage imageWithContentsOfFile:[webBrowser  captureFilePath:[[[[webBrowser backForwardList] forwardItem] URLString] toMD5] ]];
    }
    
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    webBrowser.alpha = 1.0f;
    [UIView commitAnimations];
    [webBrowser saveCaptureToCacheFile];
    
    [webBrowser bringToFront];
}

-(int) actualPageIndex{
    int pageIndex=[[webBrowser backForwardList] backListCount];
//    NSLog(@"当前页面%d",pageIndex);
    int bound = [[webBrowser backForwardList] backListCount] + [[webBrowser backForwardList] forwardListCount]+1;
//       NSLog(@"总页面%d",bound);
    if ((pageIndex+1)>=bound && bound>2) {
        pageIndex=2;
    }else if (pageIndex>1) {
        pageIndex=1;
    }
    return pageIndex;
}

-(void) updateButtons
{
  
    self.go.currentType = webBrowser.loading ? GoBtuttonTypeStop : GoBtuttonTypeReload;
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = webBrowser.loading;
//    mainScrollView.scrollEnabled = ! webBrowser.loading;
   
}

- (void) updateAddress:(NSURLRequest*)request
{
    NSURL* url = [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    self.addressField.text = absoluteString;
    url= nil;
}

- (IBAction)textEditChanged:(UITextField *)sender {
     NSURL *url = [NSURL URLWithString: sender.text];
    NSLog(@"url %d",url.isFileReferenceURL);
    self.go.currentType = url.host ? GoBtuttonTypeGo : GoBtuttonTypeSeach;
}

- (IBAction)editBegin:(id)sender {
    self.addressField.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)editEnd:(id)sender {
    self.addressField.borderStyle = UITextBorderStyleBezel;
}
@end
