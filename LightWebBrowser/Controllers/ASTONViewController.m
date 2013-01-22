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

@interface ASTONViewController ()
{
    LightWebView *webBrowser;
    UIScrollView *mainScrollView;
    NSMutableArray *thumbArrary;
    int currentPageIndex;
    NSLayoutConstraint *webBrowserLeftConstraint;
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
const float   PAGE_CONTENT_INSET = 18;
const float   TOOLBAR_HEIGHT = 44;

#pragma mark rootview委托
- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPageIndex =0;
	// Do any additional setup after loading the view, typically from a nib.
    mainScrollView = [UIScrollView new];
    mainScrollView.translatesAutoresizingMaskIntoConstraints=NO;
      mainScrollView.pagingEnabled = YES;
    webBrowser = [LightWebView new];
    webBrowser.multipleTouchEnabled = YES;
    webBrowser.scalesPageToFit = YES;
    webBrowser.translatesAutoresizingMaskIntoConstraints =NO;
//    webBrowser.scrollView.delegate= self;
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
    
    //    [webBrowser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baike.com"]] ] ;
    
    UIImageView *thumbImage;
    for (int i=1; i<4; i++) {
        thumbImage = [	UIImageView new];
        thumbImage.tag = i;
        thumbImage.backgroundColor = [UIColor blueColor];
        thumbImage.translatesAutoresizingMaskIntoConstraints = NO;
        
        [mainScrollView addSubview:thumbImage];
        //设置 images的位置
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:i-1] attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PAGE_CONTENT_INSET]];
        
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-PAGE_CONTENT_INSET]];
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:[mainScrollView viewWithTag:i] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];

    }
    //设置webbrowser的位置
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    webBrowserLeftConstraint = [NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:1]  attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [mainScrollView addConstraint:webBrowserLeftConstraint];

    
    //    thumbImage = nil;
    [self updateButtons];
    thumbArrary = [[NSMutableArray alloc] init];
    [self adjustScrollAndContent];
    currentPageIndex =-1;
 
    NSLog(@"constraint %d", [mainScrollView.constraints count]);
    NSLog(@"%@", mainScrollView.constraints);
    
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
-(int) actualPageIndex{
    int pageIndex=currentPageIndex;
    int bound =[thumbArrary count];
    if ((pageIndex+1)>=bound && bound>2) {
        pageIndex=2;
    }else if (pageIndex>1) {
        pageIndex=1;
    }
    return pageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     
    int page =   floor(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSLog(@" current page %d",page);
    int actualPageIndex = [self actualPageIndex];
    if (page==actualPageIndex) {
        return;
    }
    if (page<actualPageIndex){	
       [webBrowser goBack];
        currentPageIndex--;
    }
    else
    {
        [webBrowser goForward];
        currentPageIndex++;
    }
   [self adjustScrollAndContent];
}
#pragma mark uiwebview委托
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    [self updateAddress :request];
    NSLog(@"%d",navigationType);
    

    if (navigationType!=UIWebViewNavigationTypeBackForward && !request.isFromFrameLoading) {
//             if ([thumbArrary count]> (currentPageIndex+1)) {
//                [thumbArrary removeObjectsInRange:NSMakeRange(currentPageIndex, [thumbArrary count])];
//            }
        NSLog(@"url: %@",[[request URL] absoluteString]);
 
        currentPageIndex++;
        [thumbArrary addObject: [DirectoryHelper filePathName:[[[request mainDocumentURL] absoluteString] toMD5]]];
        [self adjustScrollAndContent] ;
    }
    return YES;
}

 

-(void)adjustScrollAndContent{
    int bound =[thumbArrary count];
    int pageIndex= [self actualPageIndex];
    NSLog(@"count %d",[thumbArrary count]);
    if (bound>3){
        bound= 3;
    }
    mainScrollView.contentSize = CGSizeMake((mainScrollView.bounds.size.width) *bound, self.view.frame.size.height);
    [mainScrollView removeConstraint:webBrowserLeftConstraint];
            webBrowserLeftConstraint = [NSLayoutConstraint constraintWithItem: webBrowser attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[mainScrollView viewWithTag:pageIndex+1]  attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [mainScrollView addConstraint:webBrowserLeftConstraint];
    [mainScrollView updateConstraintsIfNeeded];
    
    
    [mainScrollView scrollRectToVisible:CGRectMake((self.view.bounds.size.width+PAGE_CONTENT_INSET) *pageIndex+PAGE_CONTENT_INSET, 0, mainScrollView.bounds.size.width, mainScrollView.bounds.size.height) animated:NO];
        [mainScrollView bringSubviewToFront:((UIImageView*)[mainScrollView viewWithTag:pageIndex+1])];
    if (pageIndex>0) {
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex]).hidden=NO;
        [ ((UIImageView*)[mainScrollView viewWithTag:pageIndex]) bringToFront];
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex]).image= [UIImage imageWithContentsOfFile:[thumbArrary objectAtIndex:currentPageIndex-1]];
    }
    if (bound>(pageIndex+1)) {
        ((UIImageView*)[mainScrollView viewWithTag:pageIndex+2]).hidden=NO;
         [((UIImageView*)[mainScrollView viewWithTag:pageIndex+2] )bringToFront];
       ((UIImageView*)[mainScrollView viewWithTag:pageIndex+2]).image = [UIImage imageWithContentsOfFile:[thumbArrary objectAtIndex:currentPageIndex+1]];
    }
    
   
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
   [self updateButtons];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self updateButtons];
    [webBrowser saveCaptureToCacheFile];
    [webView performSelector:@selector(bringToFront) withObject:nil afterDelay:1];
    id  backList = [webBrowser backForwardList];
    NSLog(@"%@", backList);
    NSLog(@"lenght %d", (int)[backList performSelector:@selector(backListCount)]);
    NSLog(@"finished");
}


-  (id)webView:(id)sender createWebViewWithRequest:(id)arg2 windowFeatures:(id)arg3{
    
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
    [webBrowser loadRequestFromString: self.addressField.text];
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
