//
//  AutoCompleteView.h
//  LightWebBrowser
//
//  Created by 明 on 13-2-12.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AutoCompleteItemDelegate <NSObject>
@optional
    -(void) clickItem:(NSDictionary*)item;
@end

@interface AutoCompleteView : UIView<UITableViewDelegate, UITableViewDataSource>
    @property   (strong,nonatomic,setter = setAutoCompleteUrls:) NSArray *autocompleteUrls;
    @property   (weak,nonatomic)UITextField *inputField;
    @property   (weak,nonatomic)id<AutoCompleteItemDelegate> delegate;
    - (id)init:(UITextField*) inputField;
@end
