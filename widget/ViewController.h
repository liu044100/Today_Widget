//
//  ViewController.h
//  widget
//
//  Created by ryu-ushin on 2014/11/27.
//  Copyright (c) 2014年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

