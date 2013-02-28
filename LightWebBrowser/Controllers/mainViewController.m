//
//  mainViewController.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-22.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "mainViewController.h"
#import "ASTONViewController.h"
@interface mainViewController ()

@end

@implementation mainViewController
- (IBAction)click:(id)sender {
    [self newCard];
}

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
 
	 
//    NSData	*data1 = [NSKeyedArchiver archivedDataWithRootObject:self.controllerCards];//将s1序列化后,保存到NSData中
// 
//	[data1 writeToFile:@"/tmp/data.txt" atomically:YES];//持久化保存成物理文件
//    
//	NSData *data2 = [NSData dataWithContentsOfFile:@"/tmp/data.txt"];//读取文件
//	NSArray *s2 = [NSKeyedUnarchiver unarchiveObjectWithData:data2];//反序列化
//    NSLog(@"container %@",s2);
//    self.controllerCards = s2;
//    [self reloadInputViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfControllerCardsInNoteView:(KLNoteViewController*) noteView {
    return  1;
}
- (UIViewController<ControlViewData> *)noteView:(KLNoteViewController*)noteView viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Initialize a blank uiviewcontroller for display purposes
    UIStoryboard *st = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    
    ASTONViewController* viewController = [st instantiateViewControllerWithIdentifier:@"WebViewController"];
 
    
     
    
    //Return the custom view controller
    return viewController;
}

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder

{
    
    [super encodeRestorableStateWithCoder:coder];
    
     
}



-(void)decodeRestorableStateWithCoder:(NSCoder *)coder

{
    
    [super decodeRestorableStateWithCoder:coder];
       
}

@end
