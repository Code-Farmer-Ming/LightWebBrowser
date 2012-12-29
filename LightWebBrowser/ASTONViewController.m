//
//  ASTONViewController.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-19.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "ASTONViewController.h"

@interface ASTONViewController ()
    @property (weak, nonatomic) IBOutlet UIWebView *webBrowser;
    @property (weak, nonatomic) IBOutlet UITextField *addressField;

    @property (weak, nonatomic) IBOutlet UIBarButtonItem *goButton;

@end

@implementation ASTONViewController

#pragma mark uiwebview委托
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self updateAddress :request];
    return YES;
}
	
- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop) ];
    stopButton.style = UIBarButtonItemStylePlain;
  
                   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark 输入框委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self go  :self.goButton];
    return YES;
}
#pragma mark 可视化组件事件
- (IBAction)go:(UIBarButtonItem *)sender {
  
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

#pragma mark rootview委托
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
@end
