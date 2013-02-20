//
//  AutoCompleteView.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-12.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "AutoCompleteView.h"
#import "UIView+Extension.h"
#import "QuartzCore/QuartzCore.h"
#import "HistoryItem.h"

@interface AutoCompleteView ()
{
     UITableView *autocompleteTableView;
}

@end
@implementation AutoCompleteView

- (id)init:(UITextField*) inputField
{
    self = [super init];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 4;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.borderWidth=1;
        self.layer.borderColor= [[UIColor grayColor] CGColor ];
        autocompleteTableView = [UITableView new];
        autocompleteTableView.dataSource = self;
        autocompleteTableView.delegate = self;
        self.autocompleteUrls = [[NSArray alloc] init];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        autocompleteTableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:autocompleteTableView];
        self.inputField  = inputField;
         
      
        self.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"%@",self.constraints);
        NSLog(@"%f",self.frame.size.width);
        [self.inputField addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
        
               [self.inputField addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
        self.hidden = YES;
    }
    return self;
}
 
-(void)editBegin
{
    self.hidden=NO;
    self.frame = CGRectMake(self.inputField.frame.origin.x, self.inputField.frame.origin.y+self.inputField.frame.size.height, self.inputField.frame.size.width, 160);
    autocompleteTableView.frame = self.bounds;
    [self bringToFront];

}
-(void)editEnd{
    self.hidden=YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    NSLog(@"auto complete urls %d",self.autocompleteUrls.count);
    return self.autocompleteUrls.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AutoCompleteRowIdentifier];
    }

    cell.textLabel.text =((HistoryItem*)self.autocompleteUrls[indexPath.row]).url ;
    cell.detailTextLabel.text = ((HistoryItem*)self.autocompleteUrls[indexPath.row]).title;
    return cell;
}
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     
    
}
@end
